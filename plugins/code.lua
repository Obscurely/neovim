return {
  {
    "saecki/crates.nvim",
    event = { "BufRead Cargo.toml" },
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require "custom.plugins.configs.crates"
      require("crates").setup()
    end,
  },
  { "michaelb/sniprun", cmd = "SnipRun", build = "bash ./install.sh 1" },
  {
    "mfussenegger/nvim-dap",
    ft = { "rust", "cpp", "python", "csharp" },
    config = function()
      require "custom.plugins.configs.dap"
    end,
  },
  {
    "rcarriga/nvim-dap-ui",
    ft = { "rust", "cpp", "python", "csharp" },
    dependencies = { "mfussenegger/nvim-dap" },
    config = function()
      require "custom.plugins.configs.dapui"
    end,
  },
  {
    "folke/todo-comments.nvim",
    event = { "BufNewFile", "BufReadPre", "FilterReadPre" },
    config = function()
      require("todo-comments").setup()
    end,
  },
  {
    "simrat39/symbols-outline.nvim",
    cmd = "SymbolsOutline",
    config = function()
      require("symbols-outline").setup()
    end,
  },
  {
    "folke/lsp-colors.nvim",
    event = { "BufNewFile", "BufReadPre", "FilterReadPre" },
    config = function()
      require("lsp-colors").setup()
    end,
  },
  {
    "windwp/nvim-ts-autotag",
    ft = { "html", "javascriptreact" },
    dependencies = "nvim-treesitter",
    config = function()
      require("nvim-ts-autotag").setup()
    end,
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      -- format & linting
      {
        "jose-elias-alvarez/null-ls.nvim",
        config = function()
          require "custom.plugins.configs.null-ls"
        end,
      },
    },
    config = function()
      require "plugins.configs.lspconfig"
      require "custom.plugins.configs.lspconfig"
    end,
  },
  {
    "simrat39/rust-tools.nvim",
    ft = { "rust" },
    config = function()
      require("custom.plugins.configs.rust-tools").setup()
    end,
  },
}
