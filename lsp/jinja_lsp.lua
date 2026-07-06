return {
	filetypes = { "jinja", "yaml", "yaml.ansible" },
	handlers = {
		["textDocument/publishDiagnostics"] = function(err, result, ctx, config)
			if result and result.diagnostics then
				result.diagnostics = vim.tbl_filter(function(d)
					return not d.message:find("Undefined variable")
				end, result.diagnostics)
			end
			vim.lsp.handlers["textDocument/publishDiagnostics"](err, result, ctx, config)
		end,
	},
}
