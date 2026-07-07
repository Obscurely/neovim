local autocmd = vim.api.nvim_create_autocmd

-- Restore cursor position
autocmd("BufReadPost", {
	callback = function()
		local mark = vim.api.nvim_buf_get_mark(0, '"')
		local line = mark[1]
		if
			line >= 1
			and line <= vim.api.nvim_buf_line_count(0)
			and not vim.tbl_contains({ "commit", "gitrebase", "xxd" }, vim.bo.filetype)
		then
			vim.api.nvim_win_set_cursor(0, mark)
		end
	end,
})

-- Alacritty integration: opaque background, matching color, zero padding
vim.api.nvim_create_augroup("AlacrittyIntegration", { clear = true })

local function find_alacritty_socket()
	local uid = vim.trim(vim.fn.system("id -u"))
	local sockets = vim.fn.glob("/run/user/" .. uid .. "/Alacritty-*.sock", false, true)
	if #sockets == 0 then
		return nil
	end
	if #sockets == 1 then
		return sockets[1]
	end

	local client_pid = vim.trim(vim.fn.system("tmux display-message -p '#{client_pid}'"))
	if client_pid == "" then
		return sockets[1]
	end

	local pid = tonumber(client_pid)
	while pid and pid > 1 do
		for _, sock in ipairs(sockets) do
			if sock:match("%-" .. pid .. "%.sock$") then
				return sock
			end
		end
		pid = tonumber(vim.trim(vim.fn.system("ps -p " .. pid .. " -o ppid=")))
	end
	return sockets[1]
end

local alacritty_socket = find_alacritty_socket()

local function alacritty_msg(...)
	if not alacritty_socket then
		return
	end
	local args = { "alacritty", "msg", "--socket", alacritty_socket }
	for _, arg in ipairs({ ... }) do
		table.insert(args, arg)
	end
	vim.system(args)
end

local function apply_alacritty_config()
	local bg = nil
	local hl = vim.api.nvim_get_hl(0, { name = "Normal", link = false })
	if hl.bg then
		bg = string.format("#%06x", hl.bg)
	end
	alacritty_msg("config", "window.opacity=1")
	alacritty_msg("config", "window.padding.x=0")
	alacritty_msg("config", "window.padding.y=0")
	if bg then
		alacritty_msg("config", ("colors.primary.background='%s'"):format(bg))
	end
end

autocmd("UIEnter", {
	group = "AlacrittyIntegration",
	callback = function()
		vim.schedule(apply_alacritty_config)
	end,
})

autocmd("ColorScheme", {
	group = "AlacrittyIntegration",
	callback = function()
		vim.schedule(apply_alacritty_config)
	end,
})

autocmd("VimLeavePre", {
	group = "AlacrittyIntegration",
	callback = function()
		alacritty_msg("config", "--reset")
	end,
})

-- Load crates.nvim only on Cargo.toml
autocmd("BufRead", {
	pattern = "Cargo.toml",
	once = true,
	callback = function()
		require("crates").setup()
	end,
})

-- Refresh progress of lsp in status line
autocmd("LspProgress", {
	callback = function()
		vim.cmd("redrawstatus")
	end,
})

-- Disable diagnostics in .notes (side pane of no neck pain)
autocmd("BufEnter", {
	callback = function(args)
		if vim.api.nvim_buf_get_name(args.buf):match("%.notes%.md$") then
			vim.diagnostic.enable(false, { bufnr = args.buf })
		end
	end,
})
