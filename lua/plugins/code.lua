return {
  -- lsp support
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },

  -- linters
  {
    "mfussenegger/nvim-lint",
    ft = {
      "python",
      "c",
      "cpp",
      "markdown",
      "sh",
      "bash",
      "nix",
      "yaml",
      "terraform",
      "hcl",
      "dockerfile",
      "html",
      "javascript",
      "typescript",
    },
    config = function()
      require "configs.lint"
    end,
  },

  -- formatting
  {
    "stevearc/conform.nvim",
    opts = require "configs.conform",
  },

  -- rust
  {
    "mrcjkb/rustaceanvim",
    version = "^5", -- Recommended
    ft = { "rust" },
    config = function()
      require "configs.rustaceanvim"
    end,
  },

  {
    "saecki/crates.nvim",
    event = { "BufRead Cargo.toml" },
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require "configs.cratesrust"
      require("crates").setup()
    end,
  },

  -- debugging
  {
    "mfussenegger/nvim-dap",
    ft = { "rust", "cpp", "python", "csharp", "typescript", "javascript" },
    config = function()
      require "configs.dap"
    end,
  },

  {
    "rcarriga/nvim-dap-ui",
    ft = { "rust", "cpp", "python", "csharp", "typescript", "javascript" },
    dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
    config = function()
      require "configs.dapui"
    end,
  },

  -- running tests
  {
    "nvim-neotest/neotest",
    ft = { "rust", "python" },
    dependencies = {
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "nvim-neotest/neotest-python",
    },
    config = function()
      require("configs.neotest").setup()
    end,
  },

  { "michaelb/sniprun", cmd = "SnipRun", build = "bash ./install.sh 1" },

  -- Writting docs
  {
    "danymat/neogen",
    config = true,
    version = "*",
    cmd = { "Neogen" },
  },

  -- auto close tags in html and javascript
  {
    "windwp/nvim-ts-autotag",
    ft = { "html", "javascript" },
    dependencies = "nvim-treesitter",
    config = function()
      require("nvim-ts-autotag").setup()
    end,
  },

  -- tailwindcss tooling
  {
    "luckasRanarison/tailwind-tools.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    cond = function()
      return vim.fn.filereadable(vim.fn.getcwd() .. "/tailwind.config.js") > 0
    end,
    config = function()
      require("configs.tailwindtools").setup()
    end,
    ft = { "html" },
  },

  -- LLM Gen
  -- local
  {
    "David-Kunz/gen.nvim",
    cmd = { "Gen" },
    config = function()
      require("configs.gen").setup()
    end,
  },
  -- using cluade
  {
    "olimorris/codecompanion.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    cmd = { "CodeCompanionActions", "CodeCompanionChat", "CodeCompanionCmd" },
    config = function()
      require("configs.codecompanion").setup()
    end,
  },
  --- copilot like completions
  {
    "milanglacier/minuet-ai.nvim",
    event = { "BufNewFile", "BufReadPre", "FilterReadPre" },
    config = function()
      require("configs.minuet").setup()
    end,
  },
}
