local history = {}
local last_response_buf = nil
local current_chat_file = nil

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
			if msg:match("^User: ") then
				hint = msg:match("^User: (.-)$"):sub(1, 40):gsub("[^%w ]", ""):gsub("%s+", "-")
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

-- Auto-save when starting a new conversation (if previous exists)
local original_reset = function()
	if last_response_buf and vim.api.nvim_buf_is_valid(last_response_buf) then
		vim.api.nvim_buf_delete(last_response_buf, { force = true })
	elseif #history > 0 then
		save_chat()
		history = {}
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

-- main claude interaction function
local function send_to_claude(context, question)
	vim.cmd("vsplit")
	local response_buf = vim.api.nvim_create_buf(false, true)
	vim.api.nvim_win_set_buf(0, response_buf)
	vim.bo[response_buf].filetype = "markdown"
	vim.bo[response_buf].buftype = "nofile"
	vim.bo[response_buf].bufhidden = "wipe"

	vim.api.nvim_create_autocmd("BufWipeout", {
		buffer = response_buf,
		callback = function()
			if #history > 0 then
				save_chat()
				history = {}
				last_response_buf = nil
				current_chat_file = nil
			end
		end,
	})

	vim.api.nvim_buf_set_lines(response_buf, 0, -1, false, { "Thinking..." })
	table.insert(history, "User: " .. question)

	local prompt = context .. get_project_instructions() .. "\n\n" .. question

	vim.system({
		"claude",
		"--print",
		"--tools",
		"",
		"--append-system-prompt",
		system_prompt,
		"--model",
		"claude-opus-4-6",
		prompt,
	}, { text = true }, function(result)
		vim.schedule(function()
			if result.code == 0 then
				vim.api.nvim_buf_set_lines(response_buf, 0, -1, false, vim.split(result.stdout, "\n"))
				table.insert(history, "Assistant: " .. result.stdout)
				last_response_buf = response_buf
			else
				vim.api.nvim_buf_set_lines(response_buf, 0, -1, false, { "Error: " .. (result.stderr or "unknown") })
			end
		end)
	end)
end

-- Ask about current buffer
vim.keymap.set("n", "<leader>ai", function()
	original_reset()
	local context = get_file_content(vim.fn.expand("%:p"))
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
		table.insert(history, "User: " .. question)
		local full_prompt = table.concat(history, "\n\n")

		if last_response_buf and vim.api.nvim_buf_is_valid(last_response_buf) then
			local current = vim.api.nvim_buf_get_lines(last_response_buf, 0, -1, false)
			table.insert(current, "")
			table.insert(current, "---")
			table.insert(current, "")
			table.insert(current, "Thinking...")
			vim.api.nvim_buf_set_lines(last_response_buf, 0, -1, false, current)
		end

		vim.system({
			"claude",
			"--print",
			"--tools",
			"",
			"--append-system-prompt",
			system_prompt,
			"--model",
			"claude-opus-4-6",
			full_prompt,
		}, { text = true }, function(result)
			vim.schedule(function()
				if result.code == 0 then
					table.insert(history, "Assistant: " .. result.stdout)
					if last_response_buf and vim.api.nvim_buf_is_valid(last_response_buf) then
						local lines = vim.api.nvim_buf_get_lines(last_response_buf, 0, -1, false)
						if lines[#lines] == "Thinking..." then
							table.remove(lines)
						end
						for _, line in ipairs(vim.split(result.stdout, "\n")) do
							table.insert(lines, line)
						end
						vim.api.nvim_buf_set_lines(last_response_buf, 0, -1, false, lines)
						local win = vim.fn.bufwinid(last_response_buf)
						if win ~= -1 then
							vim.api.nvim_win_set_cursor(win, { #lines, 0 })
						end
					end
				end
			end)
		end)
	end)
end, { desc = "Follow up question" })

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
				history = vim.fn.json_decode(content)
				last_response_buf = nil

				-- Display the loaded conversation
				vim.cmd("vsplit")
				last_response_buf = vim.api.nvim_create_buf(false, true)
				vim.api.nvim_win_set_buf(0, last_response_buf)
				vim.bo[last_response_buf].filetype = "markdown"
				vim.bo[last_response_buf].buftype = "nofile"
				vim.bo[last_response_buf].bufhidden = "wipe"

				vim.api.nvim_create_autocmd("BufWipeout", {
					buffer = last_response_buf,
					callback = function()
						if #history > 0 then
							save_chat()
							history = {}
							last_response_buf = nil
							current_chat_file = nil
						end
					end,
				})

				local display = {}
				for _, msg in ipairs(history) do
					for _, line in ipairs(vim.split(msg, "\n")) do
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
