local overrides = require "configs.overrides"

return {
  -- disable mason.nvim since I am using NixOS
  { "williamboman/mason.nvim", enabled = false },

  -- configure treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    opts = overrides.treesitter,
  },

  -- configure cmp
  {
    "hrsh7th/nvim-cmp",
    opts = overrides.cmp,
  },

  -- view IDE things (errors etc.)
  {
    "folke/trouble.nvim",
    cmd = { "Trouble" },
    dependencies = "nvim-web-devicons",
    -- version = "v2.10.0",
    config = function()
      require("trouble").setup()
    end,
  },

  {
    "folke/todo-comments.nvim",
    event = { "BufNewFile", "BufReadPre", "FilterReadPre" },
    config = function()
      require("todo-comments").setup()
    end,
  },

  -- preview markdown files in the browser with synced scrolling
  {
    "iamcco/markdown-preview.nvim",
    build = "cd app && npm install",
    init = function()
      vim.g.mkdp_filetypes = { "markdown" }
    end,
    ft = { "markdown" },
  },
}
