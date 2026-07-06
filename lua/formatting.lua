local conform = require("conform")

conform.setup({
	formatters = {
		yamlfmt = {
			prepend_args = { "-formatter", "include_document_start=true,max_line_length=80" },
		},
	},
	formatters_by_ft = {
		lua = { "stylua" },
		python = { "ruff_fix", "ruff_organize_imports", "ruff_format" },
		c = { "uncrustify" },
		cpp = { "clang-format" },
		c_sharp = { "uncrustify" },
		java = { "uncrustify" },
		rust = { "rustfmt", lsp_format = "fallback" },
		javascript = { "prettierd", "prettier", stop_after_first = true },
		typescript = { "prettierd", "prettier", stop_after_first = true },
		javascriptreact = { "prettierd", "prettier", stop_after_first = true },
		typescriptreact = { "prettierd", "prettier", stop_after_first = true },
		json = { "prettierd", "prettier", stop_after_first = true },
		markdown = { "prettierd", "prettier", stop_after_first = true },
		html = { "prettierd", "prettier", stop_after_first = true },
		css = { "prettierd", "prettier", stop_after_first = true },
		scss = { "prettierd", "prettier", stop_after_first = true },
		graphql = { "prettierd", "prettier", stop_after_first = true },
		toml = { "taplo" },
		sh = { "shfmt" },
		bash = { "shfmt" },
		nix = { "alejandra" },
		yaml = { "yamlfmt" },
		terraform = { "terraform_fmt" },
		hcl = { "terraform_fmt" },
	},
	format_on_save = {
		timeout_ms = 2000,
		lsp_format = "fallback",
	},
})

-- keymap
vim.keymap.set("n", "<leader>cf", function()
	conform.format({ timeout_ms = 2000, lsp_format = "fallback" })
end, { desc = "Format buffer" })
