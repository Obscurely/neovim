local dap = require "dap"

-- adapters
dap.adapters.codelldb = {
  type = "server",
  port = "${port}",
  executable = {
    command = "codelldb",
    args = { "--port", "${port}" },
  },
}

dap.adapters.python = {
  type = "executable",
  command = "/etc/profiles/per-user/" .. os.getenv "USER" .. "/bin/python3",
  args = { "-m", "debugpy.adapter" },
}

dap.adapters.coreclr = {
  type = "executable",
  command = "/etc/profiles/per-user/" .. os.getenv "USER" .. "/bin/netcoredbg",
  args = { "--interpreter=vscode" },
}

require("dap").adapters["pwa-node"] = {
  type = "server",
  host = "localhost",
  port = "${port}",
  executable = {
    command = "js-debug",
    args = {"${port}"},
  }
}

-- cpp
dap.configurations.cpp = {
  {
    name = "Launch",
    type = "codelldb",
    request = "launch",
    program = function()
      return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
    end,
    cwd = "${workspaceFolder}",
    stopOnEntry = false,
  },
}

-- c
dap.configurations.c = dap.configurations.cpp

-- rust
dap.configurations.rust = {
  {
    name = "Launch",
    type = "codelldb",
    request = "launch",
    program = function()
      return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/target/debug/", "file")
    end,
    cwd = "${workspaceFolder}",
    stopOnEntry = false,
  },
}

-- python

dap.configurations.python = {
  {
    type = "python", -- the type here established the link to the adapter definition: `dap.adapters.python`
    request = "launch",
    name = "Launch file",
    program = "${file}", -- This configuration will launch the current file if used.
    pythonPath = function()
      local cwd = vim.fn.getcwd()
      if vim.fn.executable "/etc/profiles/per-user/" .. os.getenv "USER" .. "/bin/python3" == 1 then
        return cwd .. "/venv/bin/python"
      else
        return "/usr/bin/python"
      end
    end,
  },
}

-- c sharp

dap.configurations.cs = {
  {
    type = "coreclr",
    name = "launch - netcoredbg",
    request = "launch",
    program = function()
      return vim.fn.input("Path to dll", vim.fn.getcwd() .. "/bin/Debug/", "file")
    end,
  },
}

-- javascript
require("dap").configurations.javascript = {
  {
    type = "pwa-node",
    request = "launch",
    name = "Launch file",
	skipFiles = {"<node_internals>/**"},
    program = "${file}",
    cwd = "${workspaceFolder}",
  },
}

require("dap").configurations.typescript = {
  {
    type = "pwa-node",
    request = "launch",
    name = "Launch file",
	skipFiles = {"<node_internals>/**"},
    program = "${file}",
	preLaunchTask = "tsc: build - tsconfig.json",
    cwd = "${workspaceFolder}",
	outFiles = {"${workspaceFolder}/**/*.js"},
  },
}

-- binds
local map = vim.keymap.set

map("n", "<leader>db", dap.toggle_breakpoint, { noremap = true, silent = true, desc = "DAP: toggle breakpoint" })
map("n", "<leader>dr", dap.continue, { noremap = true, silent = true, desc = "DAP: Run/Continue" })
map("n", "<leader>do", dap.step_over, { noremap = true, silent = true, desc = "DAP: Step Over" })
map("n", "<leader>di", dap.step_into, { noremap = true, silent = true, desc = "DAP: Step Into" })
map("n", "<leader>dt", dap.terminate, { noremap = true, silent = true, desc = "DAP: Terminate" })
