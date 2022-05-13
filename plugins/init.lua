return {
  ["ggandor/lightspeed.nvim"] = {
    event = {"BufNewFile", "BufReadPre", "FilterReadPre"}
  },
  ["nacro90/numb.nvim"] = {
    event = "CmdlineEnter",
    config = function()
      require("custom.plugins.plugin_configs.numb").setup()
    end
  },
  ["karb94/neoscroll.nvim"] = {
    event = {"BufNewFile", "BufReadPre", "FilterReadPre"},
    config = function()
      require("custom.plugins.plugin_configs.neoscroll").setup()
    end,
  },
  ["sindrets/diffview.nvim"] = {
    after = "plenary.nvim",
    cmd = {"DiffviewOpen"},
    config = function()
      require("diffview").setup()
    end
  },
  ["p00f/nvim-ts-rainbow"] = {
    event = {"BufNewFile", "BufReadPre", "FilterReadPre"}
  },
  ["folke/lsp-colors.nvim"] = {
    event = {"BufNewFile", "BufReadPre", "FilterReadPre"},
    config = function()
      require("lsp-colors").setup()
    end
  },
  ["simrat39/symbols-outline.nvim"] = {
    cmd = "SymbolsOutline",
    config = function()
      require("symbols-outline").setup()
    end
  },
  ["Pocco81/AutoSave.nvim"] = {
    event = "InsertEnter",
    config = function()
      require("custom.plugins.plugin_configs.autosave").setup()
    end
  },
  ["ethanholz/nvim-lastplace"] = {
    event = {"BufNewFile", "BufReadPre", "FilterReadPre"},
    config = function()
      require("nvim-lastplace").setup()
    end
  },
  ["windwp/nvim-ts-autotag"] = {
    ft = {"html", "javascriptreact"},
    requires = "nvim-treesitter",
    config = function()
      require("nvim-ts-autotag").setup()
    end
  },
  ["mhartington/formatter.nvim"] = {
    cmd = {"Format"},
    config = function()
      require("custom.plugins.plugin_configs.formatter").setup()
    end
  },
  ["nathom/filetype.nvim"] = {},
  ["simrat39/rust-tools.nvim"] = {
    ft = {"rust"},
    config = function()
      require("custom.plugins.plugin_configs.rust-tools").setup()
    end
  },
  ["folke/trouble.nvim"] = {
    cmd = {"TroubleToggle"},
    requires = "nvim-web-devicons",
    config = function()
      require("trouble").setup()
    end
  },
  ["goolord/alpha-nvim"] = {
    disable = false
  },
  ["luukvbaal/stabilize.nvim"] = {
    event = {"BufNewFile", "BufReadPre", "FilterReadPre"},
    config = function()
      require("stabilize").setup()
    end
  },
  ["folke/which-key.nvim"] = {
    disable = true,
  },
}
