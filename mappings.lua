local map = require("core.utils").map

map("i", "<C-l>", "<End>")
map("i", "<C-e>", "<Right>")
map("i", "<C-s>", "<cmd> :w <CR>") -- ctrl s in insert mode to save
map("n", "<leader>cc", ":Telescope <CR>")
map("n", "<leader>q", ":q <CR>")
map("n", "<leader>s", ":set spell!<CR>") -- activate deactivate spelling
map("n", "<leader>fr", ":Format<CR>") -- Format when hitting leader + f + r
map("n", "<leader><leader>", ":Alpha<CR>") -- Open Alpha (dashboard)
map("n", "<leader>d", ":TroubleToggle<CR>") -- trouble key bind (diagnostics)
map("n", "<leader>a", ":SymbolsOutline<CR>")
