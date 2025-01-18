local M = {}

-- nvim treesitter configuration (default plugin)
M.treesitter = {
  ensure_installed = {
    "lua",
    "html",
    "css",
    "javascript",
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
  rainbow = {
    enable = true,
    extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
    max_file_lines = nil, -- Do not enable for files with more than n lines, int
  },
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
