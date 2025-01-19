-- nvchad mappings
require "nvchad.mappings"

-- my mappings

local map = vim.keymap.set

-- misc
map("i", "<C-s>", "<cmd> :w <CR>", { desc = "Make ctrl+s also save when in insert mode" })
map("n", "<leader>q", ":q <CR>", { desc = "quit bind" })
map("n", "<leader>s", ":set spell!<CR>", { desc = "Activate/deactivate spelling" })
map("x", "p", '"_dP', { desc = "Paste without overwriting register" })
map("n", "<leader>lr", ':lua require "nvchad.lsp.renamer"()', { desc = "Rename variable under cursor" })

-- format
map("n", "<leader>fr", function()
  require("conform").format()
end, { desc = "format file" })

-- plugins
map("n", "<leader>cc", ":Telescope <CR>", { desc = "Open telescope main menu" })
map("n", "<leader><leader>", ":Nvdash<CR>", { desc = "Open NVDash" })
-- Trouble
map("n", "<leader>a", ":Trouble diagnostics toggle focus=true<CR>", { desc = "Toggle open trouble diagnostics" })
map("n", "<leader>t", ":Trouble todo toggle focus=true<CR>", { desc = "Toggle open trouble todo list" })
map("n", "<leader>ss", ":Trouble symbols toggle focus=true<CR>", { desc = "Toggle open symbols (trouble)" })
map(
  "n",
  "<leader>lf",
  ":Trouble lsp_references toggle focus=true<CR>",
  { desc = "Toggle open lsp_references (trouble)" }
)
-- Markdown preview
map("n", "<leader>gl", ":MarkdownPreviewToggle<CR>", { desc = "Toggle open markdown preview" })
-- Gen.nvim (self hosted AI)
map("n", "<leader>gg", ":CodeCompanionChat<CR>", { desc = "Open CodeCompanion chat" })
map("n", "<leader>ga", ":CodeCompanionActions<CR>", { desc = "Open CodeCompanion actions" })
map("n", "<leader>gq", ":CodeCompanionCmd", { desc = "Start CodeCompanion cmd" })
map("n", "<leader>gm", ":Gen<CR>", { desc = "Open gen.nvim menu" })
map("v", "<leader>gm", ":Gen<CR>", { desc = "Open gen.nvim menu" })
-- Gitsigns
map("n", "<leader>gh", ":Gitsigns preview_hunk<CR>", { desc = "View git diffs in a virtual window" })
map("n", "<leader>gbm", ":Gitsigns blame<CR>", { desc = "Open the git blame menu" })
map("n", "<leader>gbl", ":Gitsigns blame_line<CR>", { desc = "Blame the current line" })
map("n", "<leader>gd", ":Gitsigns toggle_deleted<CR>", { desc = "Virtually show deleted lines using gitsigns" })
map("n", "<leader>gc", ":Gitsigns diffthis<CR>", { desc = "Show git differences" })
-- Minty
map("n", "<leader>lh", ":Huefy<CR>", { desc = "Open huefy menu" })
map("n", "<leader>ls", ":Shades<CR>", { desc = "Open shades menu" })