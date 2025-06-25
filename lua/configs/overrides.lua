local M = {}

-- nvim treesitter configuration (default plugin)
M.treesitter = {
  ensure_installed = {
    "lua",
    "html",
    "css",
    "scss",
    "javascript",
    "typescript",
    "tsx",
    "cpp",
    "c_sharp",
    "java",
    "python",
    "rust",
    "bash",
    "markdown",
    "go",
    "json",
    "toml",
    "make",
    "regex",
    "yaml",
    "nix",
    "gitignore",
    "ini",
    "markdown",
    "rasi",
    "terraform",
  },
  highlight = {
    enable = true,
  },
  indent = { enable = true },
}

M.cmp = {
  sources = {
    { name = "luasnip" },
    { name = "nvim_lua" },
    { name = "buffer" },
    { name = "nvim_lsp" },
    { name = "path" },
    { name = "codeium" },
    { name = "codecompanion" },
  },
}

return M
