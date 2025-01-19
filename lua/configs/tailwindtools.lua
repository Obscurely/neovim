local M = {}

M.setup = function()
  require("tailwind-tools").setup {
    document_color = {
      kind = "background",
    },
  }

  vim.keymap.set("n", "<Leader>ts", ":TailwindSort<CR>")
  vim.keymap.set("n", "<Leader>tc", ":TailwindConcealToggle<CR>")
end

return M
