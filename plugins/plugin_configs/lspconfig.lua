local M = {}

M.setup_lsp = function(attach, capabilities)
  local lspconfig = require "lspconfig"

  -- lspservers with default config
  local servers = {
    "html",
    "cssls",
    "clangd",
    "sumneko_lua",
    "tsserver",
    "csharp_ls",
    "java_language_server",
    "pyright",
    "bashls",
    "remark_ls",
    "gopls",
    "jsonls",
    "taplo",
    "cmake",
    "yamlls"
  }

  for _, lsp in ipairs(servers) do
    lspconfig[lsp].setup {
      on_attach = attach,
      capabilities = capabilities,
      flags = {
        debounce_text_changes = 150
      }
    }
  end
end

return M
