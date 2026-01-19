-- nvchad mappings
require "nvchad.mappings"

-- my mappings

local map = vim.keymap.set

-- misc
map("i", "<C-s>", "<cmd> :w <CR>", { desc = "Make ctrl+s also save when in insert mode" })
map("n", "<leader>q", ":q <CR>", { desc = "quit bind" })
map("n", "<leader>s", ":set spell!<CR>", { desc = "Activate/deactivate spelling" })
map("x", "p", '"_dP', { desc = "Paste without overwriting register" })

-- code actions
map("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", { silent = true, desc = "Open code action menu" })

-- rename variables with lsp
map("n", "<leader>lr", ':lua require "nvchad.lsp.renamer"()<CR>', { desc = "Rename variable under cursor" })

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

-- Gen.nvim (self hosted AI) & CodeCompanion (claude)
map("n", "<leader>gg", ":CodeCompanionChat<CR>", { desc = "Open CodeCompanion chat" })
map("n", "<leader>ga", ":CodeCompanionActions<CR>", { desc = "Open CodeCompanion actions" })
map("v", "<leader>ga", ":CodeCompanionActions<CR>", { desc = "Open CodeCompanion actions" })
map("n", "<leader>gq", ":CodeCompanionCmd", { desc = "Start CodeCompanion cmd" })

-- Gitsigns
map("n", "<leader>gh", ":Gitsigns preview_hunk<CR>", { desc = "View git diffs in a virtual window" })
map("n", "<leader>gbm", ":Gitsigns blame<CR>", { desc = "Open the git blame menu" })
map("n", "<leader>gbl", ":Gitsigns blame_line<CR>", { desc = "Blame the current line" })
map("n", "<leader>gd", ":Gitsigns toggle_deleted<CR>", { desc = "Virtually show deleted lines using gitsigns" })
map("n", "<leader>gc", ":Gitsigns diffthis<CR>", { desc = "Show git differences" })

-- Minty
map("n", "<leader>lh", ":Huefy<CR>", { desc = "Open huefy menu" })
map("n", "<leader>ls", ":Shades<CR>", { desc = "Open shades menu" })

-- Minuet Enable
map("n", "<leader>mm", ":Minuet virtualtext enable<CR>", { desc = "Enable Minuet via Virtualtext" })
map("n", "<leader>md", ":Minuet virtualtext disable<CR>", { desc = "Disable Minuet via Virtualtext" })

-- Leap
map({ "n", "x", "o" }, "s", "<Plug>(leap)")
map("n", "S", "<Plug>(leap-from-window)")

-- undo
map("n", "<leader>u", ":Telescope undo<CR>", { desc = "Open undo history" })

-- Harpoon
-- basic telescope configuration
local conf = require("telescope.config").values
local function toggle_telescope(harpoon_files)
  local file_paths = {}
  for _, item in ipairs(harpoon_files.items) do
    table.insert(file_paths, item.value)
  end

  require("telescope.pickers")
    .new({}, {
      prompt_title = "Harpoon",
      finder = require("telescope.finders").new_table {
        results = file_paths,
      },
      previewer = conf.file_previewer {},
      sorter = conf.generic_sorter {},
    })
    :find()
end
-- key maps
map("n", "hh", function()
  toggle_telescope(require("harpoon"):list())
end, { desc = "Open harpoon window" })
map("n", "ha", function()
  require("harpoon"):list():add()
end)
map("n", "hp", function()
  require("harpoon"):list():prev()
end)
map("n", "hn", function()
  require("harpoon"):list():next()
end)

-- Delete current file from harpoon
map("n", "hd", function()
  require("harpoon"):list():remove()
end, { desc = "Remove current file from harpoon" })

-- Interactive delete via telescope
map("n", "hD", function()
  local harpoon = require "harpoon"
  local list = harpoon:list()

  if #list.items == 0 then
    print "Harpoon list is empty"
    return
  end

  local file_paths = {}
  for _, item in ipairs(list.items) do
    table.insert(file_paths, item.value)
  end

  require("telescope.pickers")
    .new({}, {
      prompt_title = "Delete from Harpoon",
      finder = require("telescope.finders").new_table {
        results = file_paths,
      },
      previewer = conf.file_previewer {},
      sorter = conf.generic_sorter {},
      attach_mappings = function(prompt_bufnr, map_telescope)
        local actions = require "telescope.actions"
        local action_state = require "telescope.actions.state"

        map_telescope("i", "<CR>", function()
          local selection = action_state.get_selected_entry()
          actions.close(prompt_bufnr)

          -- Find and remove the selected item
          for i, item in ipairs(list.items) do
            if item.value == selection.value then
              list:remove_at(i)
              print("Removed " .. selection.value .. " from Harpoon")
              break
            end
          end
        end)

        return true
      end,
    })
    :find()
end, { desc = "Interactive delete from harpoon via telescope" })

-- Clear all files from harpoon
map("n", "hc", function()
  local harpoon = require "harpoon"
  local list = harpoon:list()

  if #list.items == 0 then
    print "Harpoon list is already empty"
    return
  end

  -- Confirm before clearing
  vim.ui.input({ prompt = "Clear all harpoon items? (y/N): " }, function(input)
    if input and (input:lower() == "y" or input:lower() == "yes") then
      list:clear()
      print "Cleared all items from Harpoon"
    end
  end)
end, { desc = "Clear all files from harpoon" })
