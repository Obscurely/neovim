local function has_prettier_config()
  local root = vim.fn.getcwd()
  local config_path = root .. "/prettier.config.mjs"
  return vim.fn.filereadable(config_path) == 1
end

-- Determine which formatter to use based on prettier config
local prettier_formatter = has_prettier_config() and "prettier" or "prettierd"

local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    go = { "gofumpt" },
    python = { "ruff_fix", "ruff_organize_imports", "ruff_format" },
    c = { "uncrustify" },
    cpp = { "uncrustify" },
    c_sharp = { "uncrustify" },
    java = { "uncrustify" },
    rust = { "rustfmt", lsp_format = "fallback" },
    -- prettier/prettierd
    javascript = { prettier_formatter },
    typescript = { prettier_formatter },
    javascriptreact = { prettier_formatter },
    typescriptreact = { prettier_formatter },
    json = { prettier_formatter },
    markdown = { prettier_formatter },
    html = { prettier_formatter },
    css = { prettier_formatter },
    scss = { prettier_formatter },
    graphql = { prettier_formatter },
    -- rest
    toml = { "taplo" },
    sh = { "shfmt" },
    bash = { "shfmt" },
    nix = { "alejandra" },
    yaml = { "yamlfmt" },
    terraform = { "terraform_fmt" },
    hcl = { "terraform_fmt" },
  },
}

return options
