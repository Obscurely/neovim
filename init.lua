-- Please check NvChad docs if you're totally new to nvchad + dont know lua!!
-- This is an example init file in /lua/custom/
-- this init.lua can load stuffs etc too so treat it like your ~/.config/nvim/

-- MAPPINGS
local map = require("core.utils").map

map("n", "<leader>cc", ":Telescope <CR>")
map("n", "<leader>q", ":q <CR>")
map("n", "<leader>s", ":set spell!<CR>")
map("i", "<C-s>", "<Esc>:w<CR>a") -- Ctrl + S for saving for insert mode
map("n", "<leader>f", ":Format<CR>") -- Format when hitting leader + f
map("n", "<leader><leader>", ":Alpha<CR>") -- Open Alpha (dashboard)
map("n", "<leader>d", ":TroubleToggle<CR>") -- trouble key bind (diagnostics)
map("n", "<leader>a", ":SymbolsOutline<CR>")

-- Aditional settings
vim.g.gitblame_enabled = 0 -- disable gitblame on startup (to only enable when needed)
vim.g.did_load_filetypes = 1 -- disable default loadtypes plugins thing in order to use the new filetypes.nvim one

-- NOTE: the 4th argument in the map function is be a table i.e options but its most likely un-needed so dont worry about it
