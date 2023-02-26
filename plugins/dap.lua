local dap = require "dap"

-- adapters

dap.adapters.lldb = {
  type = "executable",
  command = "/etc/profiles/per-user/netrunner/bin/lldb-vscode", -- adjust as needed, must be absolute path
  name = "lldb",
}

dap.adapters.python = {
  type = 'executable';
  command = '/etc/profiles/per-user/netrunner/bin/python3';
  args = { '-m', 'debugpy.adapter' };
}

dap.adapters.coreclr = {
  type = 'executable',
  command = '/etc/profiles/per-user/netrunner/bin/netcoredbg',
  args = {'--interpreter=vscode'}
}

-- configs

dap.configurations.cpp = {
  {
    name = 'Launch',
    type = 'lldb',
    request = 'launch',
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
    cwd = '${workspaceFolder}',
    stopOnEntry = false,
    args = {},
  },
}

dap.configurations.c = dap.configurations.cpp

dap.configurations.rust = {
{
    name = 'Launch',
    type = 'lldb',
    request = 'launch',
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/target/debug/', 'file')
    end,
    cwd = '${workspaceFolder}',
    stopOnEntry = false,
    args = {},
  },
}

dap.configurations.python = {
  {
    type = 'python'; -- the type here established the link to the adapter definition: `dap.adapters.python`
    request = 'launch';
    name = "Launch file";
    program = "${file}"; -- This configuration will launch the current file if used.
    pythonPath = function()
      local cwd = vim.fn.getcwd()
      if vim.fn.executable('/etc/profiles/per-user/netrunner/bin/python3') == 1 then
        return cwd .. '/venv/bin/python'
      else
        return '/usr/bin/python'
      end
    end;
  },
}

dap.configurations.cs = {
  {
    type = "coreclr",
    name = "launch - netcoredbg",
    request = "launch",
    program = function()
        return vim.fn.input('Path to dll', vim.fn.getcwd() .. '/bin/Debug/', 'file')
    end,
  },
}

-- binds
local opts = { noremap = true, silent = true, desc = "DAP, key is action prefix" }
vim.keymap.set("n", "<leader>rb", dap.toggle_breakpoint, opts)
vim.keymap.set("n", "<leader>rr", dap.continue, opts)
vim.keymap.set("n", "<leader>ro", dap.step_over, opts)
vim.keymap.set("n", "<leader>ri", dap.step_into, opts)
