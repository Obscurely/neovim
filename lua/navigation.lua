-- shortcut
local map = vim.keymap.set

-- harpoon
local harpoon = require("harpoon")
harpoon:setup()

map("n", "<leader>ha", function()
	harpoon:list():add()
end, { desc = "Harpoon add" })
map("n", "<leader>hh", function()
	harpoon.ui:toggle_quick_menu(harpoon:list())
end, { desc = "Harpoon menu" })

for i = 1, 9 do
	map("n", "<leader>" .. i, function()
		harpoon:list():select(i)
	end, { desc = "Harpoon " .. i })
end

-- fzf-lua
local fzf = require("fzf-lua")

fzf.setup({
	winopts = {
		border = "single",
		height = 0.85,
		width = 0.80,
		backdrop = 100,
		preview = {
			border = "single",
			layout = "flex",
			flip_columns = 120,
		},
	},
	files = {
		git_icons = false,
	},
})

-- File navigation
map("n", "<leader>ff", fzf.files, { desc = "Find files" })
map("n", "<leader>fg", fzf.live_grep, { desc = "Live grep" })
map("n", "<leader>fb", fzf.buffers, { desc = "Buffers" })
map("n", "<leader>fo", fzf.oldfiles, { desc = "Recent files" })

-- LSP navigation
map("n", "<leader>fr", fzf.lsp_references, { desc = "LSP references" })
map("n", "<leader>fD", fzf.lsp_definitions, { desc = "LSP definitions" })
map("n", "<leader>fs", fzf.lsp_document_symbols, { desc = "Document symbols" })
map("n", "<leader>fd", fzf.diagnostics_document, { desc = "Document diagnostics" })
map("n", "<leader>fw", fzf.diagnostics_workspace, { desc = "Workspace diagnostics" })

-- Misc
map("n", "<leader>fh", fzf.helptags, { desc = "Help tags" })
map("n", "<leader>fk", fzf.keymaps, { desc = "Keymaps" })
map("n", "<leader>fc", fzf.command_history, { desc = "Command history" })

-- Meta Words
map("n", "<leader>ft", function()
	require("fzf-lua").grep({ search = "TODO|HACK|FIX|BUG", no_esc = true })
end, { desc = "Find TODOs" })
