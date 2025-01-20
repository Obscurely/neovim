-- nvchad mappings
require "nvchad.mappings"

-- my mappings

local map = vim.keymap.set

-- misc
map("i", "<C-s>", "<cmd> :w <CR>", { desc = "Make ctrl+s also save when in insert mode" })
map("n", "<leader>q", ":q <CR>", { desc = "quit bind" })
map("n", "<leader>s", ":set spell!<CR>", { desc = "Activate/deactivate spelling" })
map("x", "p", '"_dP', { desc = "Paste without overwriting register" })

-- rename variables with lsp
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
-- Neogen
map("n", "<leader>n", ":Neogen<CR>", { desc = "Run Neogen" })

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

-- Harpoon
-- basic telescope configuration
local conf = require("telescope.config").values
local function toggle_telescope(harpoon_files)
    local file_paths = {}
    for _, item in ipairs(harpoon_files.items) do
        table.insert(file_paths, item.value)
    end

    require("telescope.pickers").new({}, {
        prompt_title = "Harpoon",
        finder = require("telescope.finders").new_table({
            results = file_paths,
        }),
        previewer = conf.file_previewer({}),
        sorter = conf.generic_sorter({}),
    }):find()
end
-- key maps
map("n", "hh", function() toggle_telescope(require("harpoon"):list()) end,
    { desc = "Open harpoon window" })
map("n", "ha", function() require("harpoon"):list():add() end)
map("n", "hp", function() require("harpoon"):list():prev() end)
map("n", "hn", function() require("harpoon"):list():next() end)
