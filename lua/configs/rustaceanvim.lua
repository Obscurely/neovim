vim.g.rustaceanvim = {
  -- LSP configuration
  server = {
    on_attach = function(_, bufnr)
	  -- Enable diagnostics to run on change instead of only on save
      vim.diagnostic.config({
        update_in_insert = true,
        virtual_text = true,
      })

	  -- keymaps
      local map = vim.keymap.set

      map("n", "<leader>ca", function()
        vim.cmd.RustLsp "codeAction" -- supports rust-analyzer's grouping
      end, { silent = true, buffer = bufnr, desc = "Code actions" })

      map(
        "n",
        "<C-space>", -- Override Neovim's built-in hover keymap with rustaceanvim's hover actions
        function()
          vim.cmd.RustLsp { "hover", "actions" }
        end,
        { silent = true, buffer = bufnr }
      )

      map("n", "<leader>rr", function()
        vim.cmd.RustLsp { "runnables", bang = false }
      end, { silent = true, buffer = bufnr, desc = "Show runnables" })

      map("n", "<C-j>", function()
        vim.cmd.RustLsp { "moveItem", "down" }
      end, { silent = true, buffer = bufnr })

      map("n", "<C-k>", function()
        vim.cmd.RustLsp { "moveItem", "up" }
      end, { silent = true, buffer = bufnr })

      map("n", "<leader>re", function()
        vim.cmd.RustLsp { "explainError", "current" }
      end, { silent = true, buffer = bufnr, desc = "Eplain current error" })

      map("n", "<leader>rd", function()
        vim.cmd.RustLsp { "renderDiagnostic", "current" }
      end, { silent = true, buffer = bufnr, desc = "Render diagnostics" })

      map("n", "<leader>rc", function()
        vim.cmd.RustLsp "openCargo"
      end, { silent = true, buffer = bufnr, desc = "Open Cargo.toml" })
    end,
  },
}
