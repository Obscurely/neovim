return {
  -- navigate fast through the buffer
  {
    "ggandor/leap.nvim",
    event = { "BufNewFile", "BufReadPre", "FilterReadPre" },
    config = function()
      require("leap").add_default_mappings()
    end,
  },

  -- add smooth scrolling to neovim ()
  {
    "karb94/neoscroll.nvim",
    event = { "BufNewFile", "BufReadPre", "FilterReadPre" },
    config = function()
      require("configs.neoscroll").setup()
    end,
  },

  -- Rainbow parantheses and other delimiters
  { "HiPhish/rainbow-delimiters.nvim", event = { "BufNewFile", "BufReadPre", "FilterReadPre" } },

  {
    "nvzone/minty",
    cmd = { "Shades", "Huefy" },
    dependencies = { "nvzone/volt", lazy = true },
  },
}
