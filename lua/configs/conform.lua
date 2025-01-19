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
    -- prettierd
    javascript = { "prettierd" },
    typescript = { "prettierd" },
    javascriptreact = { "prettierd" },
    typescriptreact = { "prettierd" },
    json = { "prettierd" },
    markdown = { "prettierd" },
    html = { "prettierd" },
    css = { "prettierd" },
    scss = { "prettierd" },
    graphql = { "prettierd" },
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
