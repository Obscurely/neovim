return {
  ["nvim-treesitter/nvim-treesitter"] = {
    override_options = require "custom.plugins.configs",
  },
  ["NvChad/ui"] = {
    override_options = {
      statusline = {
        separator_style = "round",
      },
    },
  },
  ["ggandor/leap.nvim"] = {
    event = { "BufNewFile", "BufReadPre", "FilterReadPre" },
    config = function()
      require("leap").add_default_mappings()
    end,
  },
  ["nacro90/numb.nvim"] = {
    event = "CmdlineEnter",
    config = function()
      require("custom.plugins.numb").setup()
    end,
  },
  ["karb94/neoscroll.nvim"] = {
    event = { "BufNewFile", "BufReadPre", "FilterReadPre" },
    config = function()
      require("custom.plugins.neoscroll").setup()
    end,
  },
  ["sindrets/diffview.nvim"] = {
    after = "plenary.nvim",
    cmd = { "DiffviewOpen" },
    config = function()
      require("diffview").setup()
    end,
  },
  ["mrjones2014/nvim-ts-rainbow"] = {
    event = { "BufNewFile", "BufReadPre", "FilterReadPre" },
  },
  ["folke/lsp-colors.nvim"] = {
    event = { "BufNewFile", "BufReadPre", "FilterReadPre" },
    config = function()
      require("lsp-colors").setup()
    end,
  },
  ["simrat39/symbols-outline.nvim"] = {
    cmd = "SymbolsOutline",
    config = function()
      require("symbols-outline").setup()
    end,
  },
  ["Pocco81/auto-save.nvim"] = {
    event = "InsertEnter",
    config = function()
      require("custom.plugins.autosave").setup()
    end,
  },
  ["ethanholz/nvim-lastplace"] = {
    event = { "BufNewFile", "BufReadPre", "FilterReadPre" },
    config = function()
      require("nvim-lastplace").setup()
    end,
  },
  ["windwp/nvim-ts-autotag"] = {
    ft = { "html", "javascriptreact" },
    requires = "nvim-treesitter",
    config = function()
      require("nvim-ts-autotag").setup()
    end,
  },
  ["nathom/filetype.nvim"] = {},
  ["simrat39/rust-tools.nvim"] = {
    ft = { "rust" },
    config = function()
      require("custom.plugins.rust-tools").setup()
    end,
  },
  ["folke/trouble.nvim"] = {
    cmd = { "TroubleToggle" },
    requires = "nvim-web-devicons",
    config = function()
      require("trouble").setup()
    end,
  },
  ["goolord/alpha-nvim"] = {
    disable = false,
  },
  ["luukvbaal/stabilize.nvim"] = {
    event = { "BufNewFile", "BufReadPre", "FilterReadPre" },
    config = function()
      require("stabilize").setup()
    end,
  },
  ["folke/which-key.nvim"] = {
    disable = false,
    config = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 1000
      require("which-key").setup()
    end,
  },
  ["neovim/nvim-lspconfig"] = {
    config = function()
      require "plugins.configs.lspconfig"
      require "custom.plugins.lspconfig"
    end,
  },
  ["stevearc/vim-arduino"] = {
    cmd = { "ArduinoAttach" },
  },
  ["wakatime/vim-wakatime"] = {
    event = { "BufNewFile", "BufReadPre", "FilterReadPre" },
  },
  ["williamboman/mason.nvim"] = {
    disable = true,
  },
  ["jose-elias-alvarez/null-ls.nvim"] = {
    after = "nvim-lspconfig",
    config = function()
      require "custom.plugins.null-ls"
    end,
  },
  ["folke/todo-comments.nvim"] = {
    event = { "BufNewFile", "BufReadPre", "FilterReadPre" },
    config = function()
      require("todo-comments").setup()
    end,
  },
  ["saecki/crates.nvim"] = {
    event = { "BufRead Cargo.toml" },
    requires = { "nvim-lua/plenary.nvim" },
    config = function()
      require "custom.plugins.crates"
      require("crates").setup()
    end,
  },
  ["iamcco/markdown-preview.nvim"] = {
    run = "cd app && npm install",
    setup = function()
      vim.g.mkdp_filetypes = { "markdown" }
    end,
    ft = { "markdown" },
  },
  ["michaelb/sniprun"] = {
    cmd = "SnipRun",
    run = "bash ./install.sh",
  },
  ["mfussenegger/nvim-dap"] = {
    ft = { "rust", "cpp", "python", "csharp" },
    config = function()
      require "custom.plugins.dap"
    end,
  },
  ["rcarriga/nvim-dap-ui"] = {
    ft = { "rust", "cpp", "python", "csharp" },
    requires = { "mfussenegger/nvim-dap" },
    config = function()
      require "custom.plugins.dapui"
    end,
  },
}
