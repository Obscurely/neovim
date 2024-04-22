local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities

local lspconfig = require "lspconfig"
-- lspservers with default config
local servers = {
  "cssls",
  "clangd",
  "tsserver",
  "csharp_ls",
  "java_language_server",
  "pyright",
  "bashls",
  "marksman",
  "gopls",
  "jsonls",
  "taplo",
  "cmake",
  "yamlls",
  "nil_ls",
  "slint_lsp",
}

for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end

-- Arduino language server config
lspconfig["arduino_language_server"].setup {
  on_attach = on_attach,
  capabilities = capabilities,
  cmd = {
    "arduino-language-server",
    "-cli-config",
    ".arduino15/arduino-cli.yaml",
    "-fqbn",
    "arduino:avr:uno",
    "-cli",
    "arduino-cli",
    "-clangd",
    "clangd",
  },
}

-- Lua language server config
lspconfig["lua_ls"].setup {
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = "LuaJIT",
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = { "vim" },
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true),
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
    },
  },
}

-- HTML (doing both here because I don't want htmx loading before html)
lspconfig["html"].setup {
  on_attach = on_attach,
  capabilities = capabilities,
  init_options = {
    provideFormatter = false
  },
}

lspconfig["htmx"].setup {
  on_attach = on_attach,
  capabilities = capabilities,
}

lspconfig["tailwindcss"].setup {
  on_attach = on_attach,
  capabilities = capabilities,
}
