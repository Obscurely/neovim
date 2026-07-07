require("no-neck-pain").setup({
	width = 110,
	autocmds = {
		enableOnVimEnter = true,
	},
	buffers = {
		right = {
			enabled = false,
		},
		scratchPad = {
			enabled = true,
			fileName = "notes",
			location = "./.notes/",
		},
		bo = {
			filetype = "md",
		},
	},
})

vim.keymap.set("n", "<leader>z", ":NoNeckPain<CR>", { desc = "Toggle center mode" })
