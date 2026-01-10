return {
  -- navigate fast through the buffer
  {
    "ggandor/leap.nvim",
    event = { "BufNewFile", "BufReadPre", "FilterReadPre" },
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

  {
    "debugloop/telescope-undo.nvim",
    dependencies = {
      {
        "nvim-telescope/telescope.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
      },
    },
	cmd = { "Telescope undo" },
    config = function(_, opts)
      require("telescope").setup(opts)
      require("telescope").load_extension "undo"
    end,
  },
}
