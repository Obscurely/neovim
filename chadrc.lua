-- Just an example, supposed to be placed in /lua/custom/

local M = {}

-- make sure you maintain the structure of `core/default_config.lua` here,
-- example of changing theme:

M.options = {
  backup = false, -- creates a backup file
  cmdheight = 2, -- more space in the neovim command line for displaying messages
  clipboard = "unnamedplus", -- allows neovim to access the system clipboard
  completeopt = { "menuone", "noselect" },
  conceallevel = 0, -- so that `` is visible in markdown files
  fileencoding = "utf-8", -- the encoding written to a file
  foldmethod = "expr", -- folding set to "expr" for treesitter based folding
  foldexpr = "nvim_treesitter#foldexpr()", -- set to "nvim_treesitter#foldexpr()" for treesitter based folding
  hidden = true, -- required to keep multiple buffers and open multiple buffers
  hlsearch = true, -- highlight all matches on previous search pattern
  ignorecase = true, -- ignore case in search patterns
  mouse = "a", -- allow the mouse to be used in neovim
  showmode = false, -- we don't need to see things like -- INSERT -- anymore
  showtabline = 2, -- always show tabs
  smartcase = true, -- smart case
  smartindent = true, -- make indenting smarter again
  splitbelow = true, -- force all horizontal splits to go below current window
  splitright = true, -- force all vertical splits to go to the right of current window
  swapfile = false, -- creates a swapfile
  termguicolors = true, -- set term gui colors (most terminals support this)
  title = true, -- set the title of window to the value of the titlestring
  titlestring = "%<%F%=%l/%L - nvim", -- what the title of the window will be set termguicolors
  undofile = true, -- enable persistent undo
  updatetime = 300, -- faster completion
  writebackup = false, -- if a file is being edited by another program (or was written to file while editing with another program) it is not allowed to be edited
  expandtab = false, -- forces the use of tabs
  shiftwidth = 4, -- the number of spaces inserted for each indentation
  tabstop = 4, -- insert 2 spaces for a tab
  cursorline = true, -- highlight the current line
  number = true, -- set numbered lines\
  relativenumber = false, -- set relative numbered lines
  numberwidth = 2, -- set number column width to 2 {default 4}
  signcolumn = "yes", -- always show the sign column otherwise it would shift the text each time
  wrap = false, -- display lines as one long line
  spell = false,
  spelllang = "en",
  scrolloff = 8,	
  sidescrolloff = 8,
}

M.ui = {
   	hl_override = "custom.highlights",
	theme = "onedark",
}

M.mappings = {
	insert_nav = {
		forward = "<C-e>",
		end_of_line = "<C-l>",
		save_file = "<C-s>",
	},
}

local userPlugins = require "custom.plugins" -- path to table
local pluginConfs = require "custom.plugins.configs"

M.plugins = {
   install = userPlugins,
   default_plugin_config_replace = {
      nvim_treesitter = pluginConfs.treesitter,
   },
	options = {
      lspconfig = {
         setup_lspconf = "custom.plugins.lspconfig",
      },
   },
   status = {
	   alpha = true, --dashboard
   },
}

return M
