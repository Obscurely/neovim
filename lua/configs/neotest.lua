local neotest = require "neotest"

local M = {}

M.setup = function()
  neotest.setup {
    adapters = {
      require "rustaceanvim.neotest",
      require "neotest-python",
    },
  }

  vim.keymap.set(
    "n",
    "<leader>rt",
    ':lua require("neotest").run.run(vim.fn.expand("%"))<CR>',
    { silent = true, desc = "Run tests with neotest" }
  )
end

return M
