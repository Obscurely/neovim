vim.lsp.inlay_hint.enable(true)

vim.lsp.enable({
	"bashls",
	"clangd",
	"cmake",
	"csharp_ls",
	"cssls",
	"docker_compose_language_service",
	"dockerls",
	"emmet_ls",
	"eslint",
	"gopls",
	"html",
	"java_language_server",
	"jinja_lsp",
	"jsonls",
	"lua_ls",
	"marksman",
	"nil_ls",
	"pyright",
	"slint_lsp",
	"tailwindcss",
	"taplo",
	"terraformls",
	"ts_ls",
	"yamlls",
	"rust_analyzer",
})

-- ESLint auto-fix on save
vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(args)
		local client = vim.lsp.get_client_by_id(args.data.client_id)
		if client and client.name == "eslint" then
			vim.api.nvim_create_autocmd("BufWritePre", {
				buffer = args.buf,
				callback = function()
					vim.lsp.buf.execute_command({
						command = "eslint.applyAllFixes",
						arguments = {
							{
								uri = vim.uri_from_bufnr(args.buf),
								version = vim.lsp.util.buf_versions[args.buf],
							},
						},
					})
				end,
			})
		end
	end,
})
