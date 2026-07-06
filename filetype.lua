-- Set filetype for .j2 files
vim.filetype.add({
	extension = {
		j2 = function(path)
			if path:match("%.ya?ml%.j2$") then
				return "yaml"
			end
			return "jinja"
		end,
		jinja2 = function(path)
			if path:match("%.ya?ml%.jinja2$") then
				return "yaml"
			end
			return "jinja"
		end,
	},
})

--- use nvim treesitter for syntax highlighting in mdx too
vim.filetype.add({
	extension = {
		mdx = "markdown",
	},
})

-- Configure meta words highlighting
vim.api.nvim_create_autocmd("FileType", {
	callback = function()
		vim.fn.matchadd("Todo", [[\<\(TODO\|FIXME\|HACK\|BUG\)\>]])
	end,
})
