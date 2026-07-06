vim.diagnostic.config({
	severity_sort = true,
	float = {
		border = "single",
		source = true,
	},
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = "",
			[vim.diagnostic.severity.WARN] = "",
			[vim.diagnostic.severity.HINT] = "",
			[vim.diagnostic.severity.INFO] = "",
		},
	},
	virtual_text = {
		prefix = "«",
		spacing = 4,
		virt_text_pos = "eol_right_align",
	},
})
