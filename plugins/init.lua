local overrides = require "custom.plugins.configs.overrides"

return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = overrides.treesitter,
  },

  {
    "sindrets/diffview.nvim",
    dependencies = "plenary.nvim",
    cmd = { "DiffviewOpen" },
    config = function()
      require("diffview").setup()
    end,
  },

  {
    "Pocco81/auto-save.nvim",
    event = "InsertEnter",
    config = function()
      require("custom.plugins.configs.autosave").setup()
    end,
  },

  { "nathom/filetype.nvim" },

  {
    "folke/trouble.nvim",
    cmd = { "TroubleToggle" },
    dependencies = "nvim-web-devicons",
    config = function()
      require("trouble").setup()
    end,
  },

  {
    "folke/which-key.nvim",
    enabled = true,
    config = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 1000
      require("which-key").setup()
    end,
  },

  { "williamboman/mason.nvim", enabled = false },

  {
    "iamcco/markdown-preview.nvim",
    build = "cd app && npm install",
    init = function()
      vim.g.mkdp_filetypes = { "markdown" }
    end,
    ft = { "markdown" },
  },

  {
    "tpope/vim-obsession",
  },
}
