local rt = require "rust-tools"

local M = {}

M.setup = function()
  rt.setup {
    tools = {
      autoSetHints = true,
      inlay_hints = {
        show_parameter_hints = false,
        parameter_hints_prefix = "",
        other_hints_prefix = "",
      },
    },
    server = {
      on_attach = function(_, bufnr)
        -- Hover actions
        vim.keymap.set("n", "<C-space>", rt.hover_actions.hover_actions, { buffer = bufnr })
        -- Code action groups
        vim.keymap.set("n", "<Leader>ca", rt.code_action_group.code_action_group, { buffer = bufnr })
        -- Move items
        vim.keymap.set("n", "<C-j>", ":RustMoveItemDown<CR>", { buffer = bufnr })
        vim.keymap.set("n", "<C-k>", ":RustMoveItemUp<CR>", { buffer = bufnr })
        -- Open cargo file
        vim.keymap.set("n", "<leader>c", ":RustOpenCargo<CR>", { buffer = bufnr })
      end,
      settings = {
        ["rust-analyzer"] = {
          check = {
            command = "clippy",
          },
        },
      },
    },
  }
end

return M
