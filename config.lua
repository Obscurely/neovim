-- general
lvim.log.level = "warn"
lvim.format_on_save = true
lvim.colorscheme = "onedarker"
-- lvim.transparent_window = true

-- keymappings [view all the defaults by pressing <leader>Lk]
lvim.leader = "space"
lvim.keys.normal_mode["<C-s>"] = ":w<cr>"

vim.api.nvim_set_keymap("n", "<leader>xx", "<cmd>TroubleToggle<cr>",
  {silent = true, noremap = true}
)
vim.api.nvim_set_keymap("n", "<leader>xw", "<cmd>TroubleToggle workspace_diagnostics<cr>",
  {silent = true, noremap = true}
)
vim.api.nvim_set_keymap("n", "<leader>xd", "<cmd>TroubleToggle document_diagnostics<cr>",
  {silent = true, noremap = true}
)
vim.api.nvim_set_keymap("n", "<leader>xl", "<cmd>TroubleToggle loclis<cr>",
  {silent = true, noremap = true}
)
vim.api.nvim_set_keymap("n", "<leader>xq", "<cmd>TroubleToggle quickfix<cr>",
  {silent = true, noremap = true}
)
vim.api.nvim_set_keymap("n", "gR", "<cmd>TroubleToggle lsp_references<cr>",
  {silent = true, noremap = true}
)

-- general builtin
lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"
lvim.builtin.notify.active = true
lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.show_icons.git = 0

lvim.builtin.treesitter.ensure_installed = "all"

lvim.builtin.treesitter.ignore_install = { "haskell", "phpdoc", "swift" }
lvim.builtin.treesitter.highlight.enabled = true

-- Vim options
vim.opt.backup = false -- creates a backup file
vim.opt.clipboard = "unnamed" -- allows neovim to access the system clipboard
vim.opt.cmdheight = 2 -- more space in the neovim command line for displaying messages
vim.opt.colorcolumn = "99999" -- fixes indentline for now
vim.opt.completeopt = { "menuone", "noselect" }
vim.opt.conceallevel = 0 -- so that `` is visible in markdown files
vim.opt.fileencoding = "utf-8" -- the encoding written to a file
vim.opt.foldmethod = "manual" -- folding set to "expr" for treesitter based folding
vim.opt.foldexpr = "" -- set to "nvim_treesitter#foldexpr()" for treesitter based folding
vim.opt.guifont = "monospace:h17" -- the font used in graphical neovim applications
vim.opt.hidden = true -- required to keep multiple buffers and open multiple buffers
vim.opt.hlsearch = true -- highlight all matches on previous search pattern
vim.opt.ignorecase = true -- ignore case in search patterns
vim.opt.mouse = "a" -- allow the mouse to be used in neovim
vim.opt.pumheight = 10 -- pop up menu height
vim.opt.showmode = false -- we don't need to see things like -- INSERT -- anymore
vim.opt.showtabline = 2 -- always show tabs
vim.opt.smartcase = true -- smart case
vim.opt.smartindent = true -- make indenting smarter again
vim.opt.splitbelow = true -- force all horizontal splits to go below current window
vim.opt.splitright = true -- force all vertical splits to go to the right of current window
vim.opt.swapfile = false -- creates a swapfile
vim.opt.termguicolors = true -- set term gui colors (most terminals support this)
vim.opt.timeoutlen = 100 -- time to wait for a mapped sequence to complete (in milliseconds)
vim.opt.title = true -- set the title of window to the value of the titlestring
vim.opt.titlestring = "%<%F%=%l/%L - nvim" -- what the title of the window will be set to
vim.opt.undodir = vim.fn.stdpath "cache" .. "/undo"
vim.opt.undofile = true -- enable persistent undo
vim.opt.updatetime = 300 -- faster completion
vim.opt.writebackup = false -- if a file is being edited by another program (or was written to file while editing with another program) it is not allowed to be edited
vim.opt.expandtab = false -- forces the use of tabs
vim.opt.shiftwidth = 4 -- the number of spaces inserted for each indentation
vim.opt.tabstop = 4 -- insert 2 spaces for a tab
vim.opt.cursorline = true -- highlight the current line
vim.opt.number = true -- set numbered lines
vim.opt.relativenumber = false -- set relative numbered lines
vim.opt.numberwidth = 2 -- set number column width to 2 {default 4}
vim.opt.signcolumn = "yes" -- always show the sign column otherwise it would shift the text each time
vim.opt.wrap = false -- display lines as one long line
vim.opt.spell = false
vim.opt.spelllang = "en"
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8

-- Vim keybindings
vim.cmd("imap <C-l> <Esc>$a") -- press ctrl + l to go to end of line in insert mode

-- formatters setupt
local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
  { exe = "black", filetypes = { "python" } },
  { exe = "rustfmt", filetypes = { "rust" } },
  { exe = "prettier", filetypes = { "json" } },
}

-- Additional Plugins and their setup
lvim.plugins = {
	{ "simrat39/rust-tools.nvim" },
	{
 	  'wfxr/minimap.vim',
  	  run = "cargo install --locked code-minimap",
  	  -- cmd = {"Minimap", "MinimapClose", "MinimapToggle", "MinimapRefresh", "MinimapUpdateHighlight"},
  	  config = function ()
      vim.cmd ("let g:minimap_width = 10")
      vim.cmd ("let g:minimap_auto_start = 1")
      vim.cmd ("let g:minimap_auto_start_win_enter = 1")
  	  end,
	},
	{ "ggandor/lightspeed.nvim" },
	{
	  "nacro90/numb.nvim",
	  event = "BufRead",
	  config = function()
	  require("numb").setup {
		show_numbers = true, -- Enable 'number' for the window while peeking
		show_cursorline = true, -- Enable 'cursorline' for the window while peeking
	  }
	  end,
	},
	{ "sindrets/diffview.nvim" },
	{
	  "f-person/git-blame.nvim",
	  config = function()
		vim.g.gitblame_enabled = 0
	  end,
	},
	{ "tpope/vim-fugitive" },
		{
	  "windwp/nvim-ts-autotag",
	  event = "InsertEnter",
	  config = function()
		require("nvim-ts-autotag").setup()
	  end,
	},
	{
	  "p00f/nvim-ts-rainbow",
	},
	{ "folke/lsp-colors.nvim" },
	{
	  "norcalli/nvim-colorizer.lua",
		config = function()
		  require("colorizer").setup({ "*" }, {
			  RGB = true, -- #RGB hex codes
			  RRGGBB = true, -- #RRGGBB hex codes
			  RRGGBBAA = true, -- #RRGGBBAA hex codes
			  rgb_fn = true, -- CSS rgb() and rgba() functions
			  hsl_fn = true, -- CSS hsl() and hsla() functions
			  css = true, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
			  css_fn = true, -- Enable all CSS *functions*: rgb_fn, hsl_fn
			  })
	  end,
	},
	{ "onsails/lspkind-nvim" },
	{
	  "ray-x/lsp_signature.nvim",
	  config = function()
		require "lsp_signature".setup()
	  end
	},
	{ "simrat39/symbols-outline.nvim" },
	{
	  "folke/trouble.nvim",
	  requires = "kyazdani42/nvim-web-devicons",
	  config = function()
		require("trouble").setup {
		  -- your configuration comes here
		  -- or leave it empty to use the default settings
		}
	  end
	},
	{
	  "Pocco81/AutoSave.nvim",
	  config = function()
		require("autosave").setup()
	  end,
	},
	{ "npxbr/glow.nvim" },
	{
	  "lukas-reineke/indent-blankline.nvim",
	},
	{ "karb94/neoscroll.nvim" },
	{ "ethanholz/nvim-lastplace" },
	{ "folke/todo-comments.nvim" },
	{ "felipec/vim-sanegx" },
	{ "dracula/vim" },
}

-- nvim-treesitter startup config
require("nvim-treesitter.configs").setup {
  rainbow = {
    enable = true,
    -- disable = { "jsx", "cpp" }, list of languages you want to disable the plugin for
    extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
    max_file_lines = nil, -- Do not enable for files with more than n lines, int
    -- colors = {}, -- table of hex strings
    -- termcolors = {} -- table of colour name strings
  }
}

-- configuration on the lsp for rust
local nvim_lsp = require'lspconfig'

local opts = {
    tools = { -- rust-tools options
        autoSetHints = true,
        hover_with_actions = true,
        inlay_hints = {
            show_parameter_hints = false,
            parameter_hints_prefix = "",
            other_hints_prefix = "",
        },
    },

    -- all the opts to send to nvim-lspconfig
    -- these override the defaults set by rust-tools.nvim
    -- see https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#rust_analyzer
    server = {
        -- on_attach is a callback called when the language server attachs to the buffer
        -- on_attach = on_attach,
        settings = {
            -- to enable rust-analyzer settings visit:
            -- https://github.com/rust-analyzer/rust-analyzer/blob/master/docs/user/generated_config.adoc
            ["rust-analyzer"] = {
                -- enable clippy on save
                checkOnSave = {
                    command = "clippy"
                },
            }
        }
    },
}

require('rust-tools').setup(opts)

-- lspkind configuration
local lspkind = require('lspkind')
require'cmp'.setup {
  formatting = {
    format = lspkind.cmp_format({
      mode = 'symbol', -- show only symbol annotations
      maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)

      -- The function below will be called before any actual modifications from lspkind
      -- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
      before = function (entry, vim_item)
        return vim_item
      end
    })
  }
}

-- neoscroll configuration (smooth scrolling)
require('neoscroll').setup({
	-- All these keys will be mapped to their corresponding default scrolling animation
	mappings = {'<C-u>', '<C-d>', '<C-b>', '<C-f>',
	'<C-y>', '<C-e>', 'zt', 'zz', 'zb'},
	hide_cursor = true,          -- Hide cursor while scrolling
	stop_eof = true,             -- Stop at <EOF> when scrolling downwards
	use_local_scrolloff = false, -- Use the local scope of scrolloff instead of the global scope
	respect_scrolloff = false,   -- Stop scrolling when the cursor reaches the scrolloff margin of the file
	cursor_scrolls_alone = true, -- The cursor will keep on scrolling even if the window cannot scroll further
	easing_function = nil,        -- Default easing function
	pre_hook = nil,              -- Function to run before the scrolling animation starts
	post_hook = nil,              -- Function to run after the scrolling animation ends
})

-- indent_blankline configuration
require("indent_blankline").setup {
  filetype_exclude = {"help", "terminal", "dashboard"},
}

-- nvim-lastplace configuration
require'nvim-lastplace'.setup {
    lastplace_ignore_buftype = {"quickfix", "nofile", "help"},
    lastplace_ignore_filetype = {"gitcommit", "gitrebase", "svn", "hgcommit"},
    lastplace_open_folds = true
}

