require("no-neck-pain").setup({
	width = 110,
	autocmds = {
		enableOnVimEnter = true,
	},
	buffers = {
		right = {
			enabled = false,
		},
		left = {
			scratchPad = {
				enabled = true,
				pathToFile = "./.notes.md",
			},
			bo = {
				filetype = "markdown",
			},
		},
	},
})

vim.keymap.set("n", "<leader>z", ":NoNeckPain<CR>", { desc = "Toggle center mode" })
