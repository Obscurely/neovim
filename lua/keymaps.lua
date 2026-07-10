-- shorthand for mapping
local map = vim.keymap.set

-- Navigation
map("n", "<C-d>", "<C-d>zz", { desc = "Half page down, centered" })
map("n", "<C-u>", "<C-u>zz", { desc = "Half page up, centered" })
map("n", "n", "nzzzv", { desc = "Next search result, centered" })
map("n", "N", "Nzzzv", { desc = "Prev search result, centered" })

-- Clipboard
map({ "n", "v" }, "<leader>y", '"+y', { desc = "Yank to system clipboard" })
map("n", "<leader>Y", '"+Y', { desc = "Yank line to system clipboard" })
map({ "n", "v" }, "<leader>p", '"+p', { desc = "Paste from system clipboard" })
map({ "n", "v" }, "<leader>P", '"+P', { desc = "Paste above from system clipboard" })
map("n", "]p", "p=']", { desc = "Paste below, re-indent" })
map("n", "[p", "P=']", { desc = "Paste above, re-indent" })
map("x", "p", '"_dP', { desc = "Paste without overwriting register" })

-- Files
map("n", "<leader>e", function()
	if vim.bo.filetype == "netrw" then
		vim.cmd.bd()
	else
		vim.cmd.Ex()
	end
end, { desc = "Toggle file browser" })

-- Visual mode move
map("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
map("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })

-- Diagnostics
map("n", "<leader>d", vim.diagnostic.open_float, { desc = "Show diagnostic float" })

-- Undotree
map("n", "<leader>u", vim.cmd.Undotree, { desc = "Toggle undotree" })

-- Spell Check
map("n", "<leader>s", "<cmd>set spell!<CR>", { desc = "Toggle spell check" })

-- Clear search highlights
map("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Clear search highlights" })

-- Preview Markdown
local grip_job = nil
map("n", "<leader>mp", function()
	if grip_job then
		grip_job:kill()
		grip_job = nil
		vim.notify("Preview stopped")
	else
		grip_job = vim.system({ "go-grip", vim.fn.expand("%"), "--browser" })
		vim.notify("Preview started")
	end
end, { desc = "Toggle markdown preview" })
vim.api.nvim_create_autocmd("VimLeavePre", {
	callback = function()
		if grip_job then
			grip_job:kill()
		end
	end,
})

-- Generate docs
map("n", "<leader>n", require("neogen").generate, { desc = "Generate doc comment" })
