local M = {}

M.navigation = {
  i = {
    ["<C-l>"] = { "<End>" },
    ["<C-e>"] = { "<Right>" },
  },
}

M.misc = {
  i = {
    ["<C-s>"] = { "<cmd> :w <CR>" }, -- ctrl s in insert mode to save
  },
  n = {
    ["<leader>cc"] = { ":Telescope <CR>" },
    ["<leader>q"] = { ":q <CR>" },
    ["<leader>s"] = { ":set spell!<CR>" }, -- activate deactivate spelling
    ["<leader>fr"] = {
      function()
        vim.lsp.buf.format()
      end,
      "format",
    }, -- Format when hitting leader + f + r
    -- ["<leader>g"] =
    ["<leader><leader>"] = { ":Nvdash<CR>" }, -- Open Alpha (dashboard)
    ["<leader>d"] = { ":TroubleToggle<CR>" }, -- trouble key bind (diagnostics)
    ["<leader>a"] = { ":SymbolsOutline<CR>" },
    -- Diffview open and close binds
    ["<leader>go"] = { ":DiffviewOpen<CR>" },
    ["<leader>gc"] = { ":DiffviewClose<CR>" },
    -- Markdown preview
    ["<leader>gl"] = { ":MarkdownPreviewToggle<CR>" },
    -- Gen.nvim (self hosted AI)
    ["<leader>gg"] = { ":Gen Generate<CR>"},
    ["<leader>gq"] = { ":Gen Chat_Code<CR>"},
    ["<leader>gm"] = { ":Gen<CR>"},
    -- update nvchad
    ["<leader>uu"] = { ":NvChadUpdate<CR>" },
  },
  v = {
    -- Gen.nvim (self hosted AI)
    ["<leader>gm"] = { ":Gen<CR>"},
  }
}

return M
