return {
  {
    "ggandor/leap.nvim",
    event = { "BufNewFile", "BufReadPre", "FilterReadPre" },
    config = function()
      require("leap").add_default_mappings()
    end,
  },

  {
    "nacro90/numb.nvim",
    event = "CmdlineEnter",
    config = function()
      require("custom.plugins.configs.numb").setup()
    end,
  },

  {
    "karb94/neoscroll.nvim",
    event = { "BufNewFile", "BufReadPre", "FilterReadPre" },
    config = function()
      require("custom.plugins.configs.neoscroll").setup()
    end,
  },

  {
    "luukvbaal/stabilize.nvim",
    event = { "BufNewFile", "BufReadPre", "FilterReadPre" },
    config = function()
      require("stabilize").setup()
    end,
  },

  {
    "ethanholz/nvim-lastplace",
    event = { "BufNewFile", "BufReadPre", "FilterReadPre" },
    config = function()
      require("nvim-lastplace").setup()
    end,
  },

  { "mrjones2014/nvim-ts-rainbow", event = { "BufNewFile", "BufReadPre", "FilterReadPre" } },
}
