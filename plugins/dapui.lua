require("dapui").setup()

local dap, dapui = require "dap", require "dapui"
dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end

-- binds
local opts = { noremap = true, silent = true, desc = "toggle dapui" }
vim.keymap.set("n", "<leader>rd", dapui.toggle, opts)
