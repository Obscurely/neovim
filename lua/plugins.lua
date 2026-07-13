-- builtin plugins
vim.cmd.packadd("nvim.undotree")
vim.cmd.packadd("nvim.difftool") -- Onlyruns when DiffTool is called

-- external plugins
vim.pack.add({
	-- lsp
	"https://github.com/neovim/nvim-lspconfig",
	"https://github.com/romus204/tree-sitter-manager.nvim",
	{ src = "https://github.com/saghen/blink.cmp", version = "v1" },
	"https://github.com/rafamadriz/friendly-snippets",
	"https://github.com/nvim-mini/mini.pairs",
	"https://github.com/mfussenegger/nvim-lint",
	"https://github.com/stevearc/conform.nvim",
	"https://github.com/danymat/neogen",
	"https://github.com/saecki/crates.nvim",
	-- theme
	"https://github.com/navarasu/onedark.nvim",
	-- git
	"https://github.com/lewis6991/gitsigns.nvim",
	-- navigation
	"https://github.com/nvim-lua/plenary.nvim",
	{ src = "https://github.com/ThePrimeagen/harpoon", version = "harpoon2" },
	"https://github.com/ibhagwan/fzf-lua",
	-- buffer
	"https://github.com/shortcuts/no-neck-pain.nvim",
})

-- Single-line plugin configs that don't warrant their own file
require("mini.pairs").setup() -- Auto Pairs
require("neogen").setup() -- Doc generation
