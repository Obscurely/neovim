-- load gitsigns
require("gitsigns").setup({
	current_line_blame_opts = {
		virt_text_pos = "right_align",
		delay = 300,
	},
})

-- shortcuts
local map = vim.keymap.set
local gs = require("gitsigns")

-- Navigation between hunks (falls back to built-in diff if needed)
map("n", "]c", function()
	if vim.wo.diff then
		vim.cmd.normal({ "]c", bang = true })
	else
		gs.nav_hunk("next")
	end
end, { desc = "Next hunk" })

map("n", "[c", function()
	if vim.wo.diff then
		vim.cmd.normal({ "[c", bang = true })
	else
		gs.nav_hunk("prev")
	end
end, { desc = "Prev hunk" })

-- Actions
map("n", "<leader>gs", gs.stage_hunk, { desc = "Stage hunk" })
map("n", "<leader>gr", gs.reset_hunk, { desc = "Reset hunk" })
map("n", "<leader>gS", gs.stage_buffer, { desc = "Stage buffer" })
map("n", "<leader>gR", gs.reset_buffer, { desc = "Reset buffer" })
map("n", "<leader>gp", gs.preview_hunk_inline, { desc = "Preview hunk inline" })
map("n", "<leader>gd", gs.toggle_deleted, { desc = "Toggle deleted lines" })
map("n", "<leader>gf", function()
	require("fzf-lua").git_status()
end, { desc = "Git changed files" })
map("n", "<leader>gl", function()
	require("fzf-lua").git_commits()
end, { desc = "Git log" })
map("n", "<leader>gc", function()
	require("fzf-lua").git_bcommits()
end, { desc = "Git commits (buffer)" })

-- Blame
map("n", "<leader>gb", gs.toggle_current_line_blame, { desc = "Toggle line blame" })
map("n", "<leader>gB", gs.blame, { desc = "Full buffer blame" })

-- Hunk text object (select inside a hunk)
map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", { desc = "Select hunk" })
