-- load defaults i.e lua_lsp
require("nvchad.configs.lspconfig").defaults()

local lspconfig = require "lspconfig"

-- enable lsp inlay hints
vim.lsp.inlay_hint.enable(true)

-- setup lsp servers
local servers = {
  "cssls",
  "clangd",
  "ts_ls",
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
  "terraformls",
  "docker_compose_language_service",
  "dockerls",
  "arduino_language_server",
}
local nvlsp = require "nvchad.configs.lspconfig"

-- lsps with default config
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = nvlsp.on_attach,
    on_init = nvlsp.on_init,
    capabilities = nvlsp.capabilities,
  }
end

-- configuring single server, example: typescript
-- lspconfig.ts_ls.setup {
--   on_attach = nvlsp.on_attach,
--   on_init = nvlsp.on_init,
--   capabilities = nvlsp.capabilities,
-- }

-- Lua language server config
lspconfig["lua_ls"].setup {
  on_attach = nvlsp.on_attach,
  on_init = nvlsp.on_init,
  capabilities = nvlsp.capabilities,
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

-- HTML (doing both here because I don't want htmx or tailwindcss loading before html)
lspconfig["html"].setup {
  on_attach = nvlsp.on_attach,
  on_init = nvlsp.on_init,
  capabilities = nvlsp.capabilities,
  init_options = {
    provideFormatter = false,
  },
}

lspconfig["htmx"].setup {
  on_attach = nvlsp.on_attach,
  on_init = nvlsp.on_init,
  capabilities = nvlsp.capabilities,
}

lspconfig["tailwindcss"].setup {
  on_attach = nvlsp.on_attach,
  on_init = nvlsp.on_init,
  capabilities = nvlsp.capabilities,
}

lspconfig["emmet_ls"].setup {
  on_attach = nvlsp.on_attach,
  on_init = nvlsp.on_init,
  capabilities = nvlsp.capabilities,
}

-- Ansible
lspconfig["ansiblels"].setup {
  on_attach = nvlsp.on_attach,
  on_init = nvlsp.on_init,
  filetypes = { "yaml", "yml" },
  capabilities = nvlsp.capabilities,
  root_dir = function(fname)
    local root_files = {
      "hosts",
    }

    -- Check for the 'role' directory
    local is_role_directory = vim.fn.isdirectory "roles" == 1

    if is_role_directory then
      table.insert(root_files, "roles")
    end

    return lspconfig.util.root_pattern(unpack(root_files))(fname)
      or lspconfig.util.find_git_ancestor(fname)
      or vim.fn.getcwd()
  end,
}
