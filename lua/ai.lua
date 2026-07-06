local history = {}
local last_response_buf = nil
local current_chat_file = nil
local active_job = nil

local system_prompt = [[
You are a senior software, cloud and systems engineer acting as a peer reviewer and advisor. You have no tools - no web search, no file access, no shell commands. You can only read the context provided and respond.

Rules:
- Be direct and concise. No filler, no hedging, no "great question."
- When showing code, show only the relevant change, not the entire file.
- If you don't know something, say so in one sentence.
- When asked to explain, explain the why, not just the what.
- Point out potential issues the user didn't ask about if they're significant.
- Default to the user's language and toolchain conventions (Rust, Python, Nix, Lua).
- No markdown headers in short answers. Use them only for genuinely structured responses.
]]

local function get_file_content(filepath)
	local lines = vim.fn.readfile(filepath)
	local name = vim.fn.fnamemodify(filepath, ":~:.")
	return string.format("File: %s\n```\n%s\n```", name, table.concat(lines, "\n"))
end

-- Chat history persistence
local function get_chat_dir()
	local project = vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
	local dir = vim.fn.stdpath("data") .. "/ai-chats/" .. project
	return dir
end

-- build a flat prompt string from structured history
local function build_prompt_from_history()
	local parts = {}
	for _, msg in ipairs(history) do
		if msg.role == "context" then
			table.insert(parts, msg.content)
		elseif msg.role == "user" then
			table.insert(parts, "User: " .. msg.content)
		elseif msg.role == "assistant" then
			table.insert(parts, "Assistant: " .. msg.content)
		end
	end
	return table.concat(parts, "\n\n")
end

local function save_chat()
	if #history == 0 then
		return
	end
	local dir = get_chat_dir()
	vim.fn.mkdir(dir, "p")

	local filepath
	if current_chat_file then
		filepath = current_chat_file
	else
		local timestamp = os.date("%Y-%m-%d_%H-%M-%S")
		local hint = ""
		for _, msg in ipairs(history) do
			if msg.role == "user" then
				hint = msg.content:sub(1, 40):gsub("[^%w ]", ""):gsub("%s+", "-")
				break
			end
		end
		filepath = dir .. "/" .. timestamp .. "_" .. hint .. ".json"
	end

	local file = io.open(filepath, "w")
	if file then
		file:write(vim.fn.json_encode(history))
		file:close()
	end
end

-- save current conversation, close buffer, reset state
-- clear history before buf_delete so BufWipeout autocmd doesn't double-save
local original_reset = function()
	if active_job then
		vim.fn.jobstop(active_job)
		active_job = nil
	end
	if #history > 0 then
		save_chat()
	end
	-- clear history before deleting buffer so BufWipeout doesn't double-save
	history = {}
	if last_response_buf and vim.api.nvim_buf_is_valid(last_response_buf) then
		vim.api.nvim_buf_delete(last_response_buf, { force = true })
	end
	last_response_buf = nil
	current_chat_file = nil
end

-- inject per project prompt instructions
local function get_project_instructions()
	local file = vim.fn.findfile(".ai-instructions", ".;")
	if file ~= "" then
		local lines = vim.fn.readfile(file)
		return "\n\nProject-specific instructions:\n" .. table.concat(lines, "\n")
	end
	return ""
end

-- build the claude command args
-- --tools "" explicitly disables all tools (no file access, no shell, no web search)
local function build_cmd(prompt)
	return {
		"claude",
		"--print",
		"--tools",
		"",
		"--model",
		"claude-opus-4-6",
		"--output-format",
		"stream-json",
		"--verbose",
		"--include-partial-messages",
		"--append-system-prompt",
		system_prompt .. get_project_instructions(),
		prompt,
	}
end

-- stream claude response into a buffer, prefix_lines are prepended to the display (for follow-ups)
local function stream_response(buf, cmd, prefix_lines, on_done)
	local full_response = ""
	local thinking_text = ""
	local is_thinking = false
	local partial_line = ""

	local function update_buffer()
		if not vim.api.nvim_buf_is_valid(buf) then
			return
		end
		local display = {}
		if prefix_lines then
			vim.list_extend(display, prefix_lines)
		end
		if is_thinking and thinking_text ~= "" then
			table.insert(display, "[thinking]")
			for _, line in ipairs(vim.split(thinking_text, "\n")) do
				table.insert(display, "  " .. line)
			end
			table.insert(display, "")
		end
		for _, line in ipairs(vim.split(full_response, "\n")) do
			table.insert(display, line)
		end
		vim.api.nvim_buf_set_lines(buf, 0, -1, false, display)
		local win = vim.fn.bufwinid(buf)
		if win ~= -1 then
			vim.api.nvim_win_set_cursor(win, { #display, 0 })
		end
	end

	active_job = vim.fn.jobstart(cmd, {
		stdout_buffered = false,
		stderr_buffered = true,
		on_stderr = function(_, data, _)
			local msg = table.concat(data, "\n")
			if msg ~= "" then
				vim.schedule(function()
					if vim.api.nvim_buf_is_valid(buf) then
						vim.api.nvim_buf_set_lines(buf, 0, -1, false, { "Error: " .. msg })
					end
				end)
			end
		end,
		on_stdout = function(_, data, _)
			for i, chunk in ipairs(data) do
				local line
				if i == 1 then
					line = partial_line .. chunk
					partial_line = ""
				else
					line = chunk
				end

				if i == #data then
					partial_line = line
				elseif line ~= "" then
					local ok, event = pcall(vim.fn.json_decode, line)
					if ok and event and event.type == "stream_event" then
						local delta = event.event and event.event.delta
						if delta then
							if delta.type == "thinking_delta" then
								is_thinking = true
								thinking_text = thinking_text .. (delta.thinking or "")
								vim.schedule(update_buffer)
							elseif delta.type == "text_delta" then
								if is_thinking then
									is_thinking = false
								end
								full_response = full_response .. (delta.text or "")
								vim.schedule(update_buffer)
							end
						end
					end
				end
			end
		end,
		on_exit = function(_, exit_code, _)
			vim.schedule(function()
				active_job = nil
				if exit_code == 0 and full_response ~= "" then
					is_thinking = false
					thinking_text = ""
					update_buffer()
					on_done(full_response)
				elseif vim.api.nvim_buf_is_valid(buf) then
					if exit_code ~= 0 then
						local err_lines = prefix_lines and vim.list_extend({}, prefix_lines) or {}
						table.insert(err_lines, "Error: request failed")
						vim.api.nvim_buf_set_lines(buf, 0, -1, false, err_lines)
					end
				end
			end)
		end,
	})
end

-- setup a response buffer with common options
local function create_response_buf()
	vim.cmd("vsplit")
	local buf = vim.api.nvim_create_buf(false, true)
	vim.api.nvim_win_set_buf(0, buf)
	vim.bo[buf].filetype = "markdown"
	vim.bo[buf].buftype = "nofile"
	vim.bo[buf].bufhidden = "wipe"

	vim.api.nvim_create_autocmd("BufWipeout", {
		buffer = buf,
		callback = function()
			if #history > 0 then
				save_chat()
				history = {}
				last_response_buf = nil
				current_chat_file = nil
			end
		end,
	})

	return buf
end

-- main claude interaction function
local function send_to_claude(context, question)
	local response_buf = create_response_buf()
	vim.api.nvim_buf_set_lines(response_buf, 0, -1, false, { "Connecting..." })

	-- store context in history so follow-ups retain it
	if context ~= "" then
		table.insert(history, { role = "context", content = context })
	end
	table.insert(history, { role = "user", content = question })

	local prompt = build_prompt_from_history()

	stream_response(response_buf, build_cmd(prompt), nil, function(response)
		table.insert(history, { role = "assistant", content = response })
		last_response_buf = response_buf
	end)
end

-- Ask about current buffer
vim.keymap.set("n", "<leader>ai", function()
	original_reset()
	local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
	local name = vim.fn.fnamemodify(vim.fn.expand("%:p"), ":~:.")
	local context = string.format("File: %s\n```\n%s\n```", name, table.concat(lines, "\n"))
	vim.ui.input({ prompt = "Ask Claude: " }, function(question)
		if not question or question == "" then
			return
		end
		send_to_claude(context, question)
	end)
end, { desc = "Ask Claude about current file" })

-- Ask about visual selection
vim.keymap.set("v", "<leader>ai", function()
	original_reset()
	vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "n", false)
	vim.schedule(function()
		local start_pos = vim.fn.getpos("'<")
		local end_pos = vim.fn.getpos("'>")
		local lines = vim.api.nvim_buf_get_lines(0, start_pos[2] - 1, end_pos[2], false)
		local context = string.format("Selected code:\n```\n%s\n```", table.concat(lines, "\n"))
		vim.ui.input({ prompt = "Ask Claude: " }, function(question)
			if not question or question == "" then
				return
			end
			send_to_claude(context, question)
		end)
	end)
end, { desc = "Ask Claude about selection" })

-- Pick files with fzf then ask
vim.keymap.set("n", "<leader>aI", function()
	original_reset()
	local selected_files = {}
	require("fzf-lua").files({
		actions = {
			["default"] = function(entries)
				for _, entry in ipairs(entries) do
					local path = require("fzf-lua").path.entry_to_file(entry).path
					table.insert(selected_files, path)
				end
				local context = {}
				for _, filepath in ipairs(selected_files) do
					table.insert(context, get_file_content(filepath))
				end
				vim.ui.input({ prompt = "Ask Claude: " }, function(question)
					if not question or question == "" then
						return
					end
					send_to_claude(table.concat(context, "\n\n"), question)
				end)
			end,
		},
		fzf_opts = { ["--multi"] = true },
	})
end, { desc = "Pick files and ask Claude" })

-- Chat without any files
vim.keymap.set("n", "<leader>ac", function()
	original_reset()
	vim.ui.input({ prompt = "Ask Claude: " }, function(question)
		if not question or question == "" then
			return
		end
		send_to_claude("", question)
	end)
end, { desc = "Chat with Claude (no file)" })

-- Follow up on existing conversation
vim.keymap.set("n", "<leader>af", function()
	if #history == 0 then
		vim.notify("No active conversation")
		return
	end
	vim.ui.input({ prompt = "Follow up: " }, function(question)
		if not question or question == "" then
			return
		end
		table.insert(history, { role = "user", content = question })
		local full_prompt = build_prompt_from_history()

		if not (last_response_buf and vim.api.nvim_buf_is_valid(last_response_buf)) then
			return
		end

		local current = vim.api.nvim_buf_get_lines(last_response_buf, 0, -1, false)
		table.insert(current, "")
		table.insert(current, "---")
		table.insert(current, "")
		table.insert(current, "Connecting...")
		vim.api.nvim_buf_set_lines(last_response_buf, 0, -1, false, current)

		local prefix_lines = vim.list_extend({}, current)
		table.remove(prefix_lines)

		stream_response(last_response_buf, build_cmd(full_prompt), prefix_lines, function(response)
			table.insert(history, { role = "assistant", content = response })
		end)
	end)
end, { desc = "Follow up question" })

-- Cancel in-flight request
vim.keymap.set("n", "<leader>aq", function()
	if active_job then
		vim.fn.jobstop(active_job)
		active_job = nil
		vim.notify("Request cancelled")
	else
		vim.notify("No active request")
	end
end, { desc = "Cancel Claude request" })

-- Browse and load old chats
local function open_chat_history()
	local dir = get_chat_dir()
	if vim.fn.isdirectory(dir) == 0 then
		vim.notify("No chat history")
		return
	end
	require("fzf-lua").files({
		cwd = dir,
		fzf_opts = { ["--tac"] = "" },
		actions = {
			["default"] = function(entries)
				local path = dir .. "/" .. require("fzf-lua").path.entry_to_file(entries[1]).path
				current_chat_file = path
				local file = io.open(path, "r")
				if not file then
					return
				end
				local content = file:read("*a")
				file:close()

				local ok, decoded = pcall(vim.fn.json_decode, content)
				if not ok then
					vim.notify("Failed to load chat: corrupted file")
					return
				end
				history = decoded

				last_response_buf = create_response_buf()

				local display = {}
				for _, msg in ipairs(history) do
					local prefix = ""
					if msg.role == "context" then
						prefix = "[context]\n"
					elseif msg.role == "user" then
						prefix = "User: "
					elseif msg.role == "assistant" then
						prefix = ""
					end
					for _, line in ipairs(vim.split(prefix .. msg.content, "\n")) do
						table.insert(display, line)
					end
					table.insert(display, "")
					table.insert(display, "---")
					table.insert(display, "")
				end
				vim.api.nvim_buf_set_lines(last_response_buf, 0, -1, false, display)
				vim.api.nvim_win_set_cursor(0, { #display, 0 })
			end,
			["ctrl-x"] = function(entries)
				for _, entry in ipairs(entries) do
					local path = dir .. "/" .. require("fzf-lua").path.entry_to_file(entry).path
					os.remove(path)
				end
				vim.notify("Deleted " .. #entries .. " chat(s)")
				vim.schedule(open_chat_history)
			end,
		},
	})
end

vim.keymap.set("n", "<leader>ah", open_chat_history, { desc = "Browse chat history" })

-- Save current chat manually
vim.keymap.set("n", "<leader>as", function()
	if #history == 0 then
		vim.notify("No active conversation")
		return
	end
	save_chat()
	vim.notify("Chat saved")
end, { desc = "Save current chat" })

-- rename current chat
vim.keymap.set("n", "<leader>an", function()
	if #history == 0 then
		vim.notify("No active conversation")
		return
	end

	vim.ui.input({ prompt = "Name this chat: " }, function(name)
		if not name or name == "" then
			return
		end

		local dir = get_chat_dir()
		vim.fn.mkdir(dir, "p")
		local sanitized = name:gsub("[^%w ]", ""):gsub("%s+", "-")
		local new_path = dir .. "/" .. sanitized .. ".json"

		-- Handle duplicates
		local counter = 1
		while vim.fn.filereadable(new_path) == 1 do
			new_path = dir .. "/" .. sanitized .. "-" .. counter .. ".json"
			counter = counter + 1
		end

		-- Delete old file if it exists
		if current_chat_file and vim.fn.filereadable(current_chat_file) == 1 then
			os.remove(current_chat_file)
		end

		current_chat_file = new_path
		save_chat()
		vim.notify("Chat named: " .. name)
	end)
end, { desc = "Name current chat" })

-- clear all chats
vim.keymap.set("n", "<leader>ax", function()
	local dir = get_chat_dir()
	if vim.fn.isdirectory(dir) == 0 then
		vim.notify("No chat history for this project")
		return
	end
	vim.ui.input({ prompt = "Clear all chats for this project? (y/n): " }, function(confirm)
		if confirm ~= "y" then
			return
		end
		local files = vim.fn.glob(dir .. "/*.json", false, true)
		for _, f in ipairs(files) do
			os.remove(f)
		end
		history = {}
		current_chat_file = nil
		vim.notify("Cleared " .. #files .. " chat(s)")
	end)
end, { desc = "Clear all chat history" })
