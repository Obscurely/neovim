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

local function apply_alacritty_config()
	local bg = nil
	local hl = vim.api.nvim_get_hl(0, { name = "Normal", link = false })
	if hl.bg then
		bg = string.format("#%06x", hl.bg)
	end

	vim.system({ "alacritty", "msg", "config", "window.opacity=1" })
	vim.system({ "alacritty", "msg", "config", "window.padding.x=0" })
	vim.system({ "alacritty", "msg", "config", "window.padding.y=0" })
	if bg then
		vim.system({ "alacritty", "msg", "config", ("colors.primary.background='%s'"):format(bg) })
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
		vim.system({ "alacritty", "msg", "config", "--reset" })
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
