-- load defaults i.e lua_lsp
require("nvchad.configs.lspconfig").defaults()

-- enable lsp inlay hints
vim.lsp.inlay_hint.enable(true)

-- setup lsp servers in specific order
local servers = {
  "cssls",
  "eslint",
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

-- Enable servers with default config in order
for _, lsp in ipairs(servers) do
  vim.lsp.enable(lsp)
end

-- Lua language server config
vim.lsp.config("lua_ls", {
  settings = {
    Lua = {
      runtime = {
        version = "LuaJIT",
      },
      diagnostics = {
        globals = { "vim" },
      },
      workspace = {
        library = vim.api.nvim_get_runtime_file("", true),
      },
      telemetry = {
        enable = false,
      },
    },
  },
})
vim.lsp.enable "lua_ls"

-- HTML (doing both here because I don't want htmx or tailwindcss loading before html)
vim.lsp.config("html", {
  init_options = {
    provideFormatter = false,
  },
})
vim.lsp.enable "html"

-- ESLint auto-fix on save
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client and client.name == "eslint" then
      vim.api.nvim_create_autocmd("BufWritePre", {
        buffer = args.buf,
        callback = function()
          vim.lsp.buf.execute_command {
            command = "eslint.applyAllFixes",
            arguments = {
              {
                uri = vim.uri_from_bufnr(args.buf),
                version = vim.lsp.util.buf_versions[args.buf],
              },
            },
          }
        end,
      })
    end
  end,
})

vim.lsp.config("htmx", {})
vim.lsp.enable "htmx"

vim.lsp.config("tailwindcss", {})
vim.lsp.enable "tailwindcss"

vim.lsp.config("emmet_ls", {})
vim.lsp.enable "emmet_ls"

-- YAML language server with Ansible schemas
vim.lsp.config("yamlls", {
  settings = {
    yaml = {
      schemas = {
        ["https://raw.githubusercontent.com/ansible/ansible-lint/main/src/ansiblelint/schemas/ansible.json"] = {
          "playbooks/*.yml",
          "playbooks/*.yaml",
          "playbook.yml",
          "playbook.yaml",
          "**/ansible/**/*.yml",
          "**/ansible/**/*.yaml",
          "**/playbooks/**/*.yml",
          "**/playbooks/**/*.yaml",
        },
        ["https://raw.githubusercontent.com/ansible/ansible-lint/main/src/ansiblelint/schemas/tasks.json"] = {
          "**/tasks/**/*.yml",
          "**/tasks/**/*.yaml",
        },
      },
      customTags = {
        "!vault",
        "!encrypted/pkcs1-oaep scalar",
        "!vault-encrypted scalar",
      },
      validate = true,
      hover = true,
      completion = true,
      format = {
        enable = true,
      },
    },
  },
})
