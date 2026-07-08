-- shortcuts
local opt = vim.opt

-- Varibles
vim.g.mapleader = " " -- leader key
vim.g.netrw_browse_split = 0 -- open files in the same window in netr
vim.g.netrw_banner = 0 -- hide the info banner at the top in netrw
vim.g.netrw_liststyle = 0 -- short listing (long listing is bugged and doesn't show directories at the top)
vim.g.netrw_timefmt = "%Y-%m-%d %H:%M" -- cleaner date format
vim.g.netrw_sizestyle = "H" -- human readable sizes

-- Options
opt.conceallevel = 0 -- so that `` is visible in markdown files
opt.backupdir = "/tmp/nvim-backup//" -- where to store backups
opt.backup = true -- store backups of the files
opt.cmdheight = 1 -- more space in the neovim command line for displaying messages
-- opt.clipboard = "unnamedplus" -- allows neovim to access the system clipboard
opt.fileencoding = "utf-8" -- the encoding written to a file
opt.hidden = true -- required to keep multiple buffers and open multiple buffers
opt.hlsearch = true -- highlight all matches on previous search pattern
opt.ignorecase = true -- ignore case in search patterns
opt.mouse = "" -- NO MOUSE
opt.showmode = false -- already showin in statusline
opt.showtabline = 0 -- never show tabs
opt.smartcase = true -- smart case
opt.smartindent = false -- this is a legacy option now
opt.autoindent = true -- copies indent from other lines
opt.splitbelow = true -- force all horizontal splits to go below current window
opt.splitright = true -- force all vertical splits to go to the right of current window
opt.swapfile = true -- creates a swapfile, don't lose work on crash
opt.termguicolors = true -- set term gui colors (most terminals support this)
opt.title = true -- set the title of window to the value of the titlestring
opt.titlestring = "%<%F%=%l/%L - nvim" -- what the title of the window will be set termguicolors
opt.undofile = true -- enable persistent undo
opt.updatetime = 300 -- faster completion
opt.writebackup = true -- allow writting backups
opt.expandtab = false -- forces the use of tabs
opt.shiftwidth = 4 -- the number of spaces inserted for each indentation
opt.tabstop = 4 -- insert 4 spaces for a tab
opt.softtabstop = 0 -- Fine-tunes how many spaces a tab counts for while editing
opt.cursorline = false -- highlight the current line
opt.number = true -- set numbered lines
opt.relativenumber = true -- set relative numbered lines
opt.numberwidth = 2 -- set number column width to 2 {default 4}
opt.signcolumn = "yes" -- always show the sign column otherwise it would shift the text each time
opt.wrap = true -- continue displaying long lines by going on the next line, wrapping as the name suggests.
opt.breakindent = true -- on the extra lines from wrapped lines apply the same level of indent
opt.linebreak = true -- wrap lines at word boundries rather than mid-word
opt.smoothscroll = true -- on wrapped lines don't skip scroll as if they are just a line
opt.laststatus = 3 -- keep one single status line that adapts depending on the buffer selected
opt.spell = false
opt.spelllang = "en"
opt.scrolloff = 8
opt.sidescrolloff = 8
opt.splitkeep = "screen" -- i.e open the terminal over the buffer instead of moving the buffer above
opt.inccommand = "split" -- show a split window of how it will look like after substitutions (:s)
opt.list = true -- show clearly the difference between spaces, tabs, trailing spaces
opt.listchars = {
	tab = "│ ",
	leadtab = "│ ",
	leadmultispace = "¦   ",
	nbsp = "␣",
}
opt.virtualedit = "block" -- get CTRL+V to actually use the same column regardless of line length
opt.shiftround = true -- if a line is for example at 3 space using ">" will take it to 8 rather than 7
opt.exrc = true -- allow local .nvim.lua for configuring options
opt.jumpoptions = "stack,view,clean" -- make jump history behave like a normal history
-- opt.winbar = " "
opt.statusline = table.concat({
	" %{%v:lua.require'util.statusline'.mode()%}",
	"%{v:lua.require'util.statusline'.git_branch()} ",
	"%{v:lua.require'util.statusline'.git_diff()}",
	" │ %{v:lua.require'util.statusline'.file()} %m%r",
	"%=",
	" %{v:lua.require'util.statusline'.progress()}",
	"%=",
	"%{v:lua.require'util.statusline'.diagnostics()} ",
	"%{v:lua.require'util.statusline'.lsp()} ",
	"%{v:lua.require'util.statusline'.project()} ",
	" %l:%c  %P ",
})
