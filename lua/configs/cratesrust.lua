-- autocmds
local autocmd = vim.api.nvim_create_autocmd

-- add crates.nvim to cmp sources once we open Cargo.toml and set binds
local cmp = require "cmp"
local crates = require "crates"
autocmd("BufRead", {
  group = vim.api.nvim_create_augroup("CmpSourceCargo", { clear = true }),
  pattern = "Cargo.toml",
  callback = function()
    -- add sources
    cmp.setup.buffer { sources = { { name = "crates" } } }
    -- binds
    vim.keymap.set(
      "n",
      "<leader>ct",
      crates.toggle,
      { noremap = true, silent = true, buffer = true, desc = "Crates: Toggle" }
    )
    vim.keymap.set(
      "n",
      "<leader>cr",
      crates.reload,
      { noremap = true, silent = true, buffer = true, desc = "Crates: Reload" }
    )

    vim.keymap.set(
      "n",
      "<leader>cv",
      crates.show_versions_popup,
      { noremap = true, silent = true, buffer = true, desc = "Crates: Show versions" }
    )
    vim.keymap.set(
      "n",
      "<leader>cf",
      crates.show_features_popup,
      { noremap = true, silent = true, buffer = true, desc = "Crates: Show features" }
    )
    vim.keymap.set(
      "n",
      "<leader>cd",
      crates.show_dependencies_popup,
      { noremap = true, silent = true, buffer = true, desc = "Crates: Show dependencies" }
    )

    vim.keymap.set(
      "n",
      "<leader>cu",
      crates.update_crate,
      { noremap = true, silent = true, buffer = true, desc = "Crates: Update crate" }
    )
    vim.keymap.set(
      "v",
      "<leader>cu",
      crates.update_crates,
      { noremap = true, silent = true, buffer = true, desc = "Crates: Update crates" }
    )
    vim.keymap.set(
      "n",
      "<leader>ca",
      crates.update_all_crates,
      { noremap = true, silent = true, buffer = true, desc = "Crates: Update all crates" }
    )
    vim.keymap.set(
      "n",
      "<leader>cU",
      crates.upgrade_crate,
      { noremap = true, silent = true, buffer = true, desc = "Crates: Upgrade crate" }
    )
    vim.keymap.set(
      "v",
      "<leader>cU",
      crates.upgrade_crates,
      { noremap = true, silent = true, buffer = true, desc = "Crates: Upgrade crates" }
    )
    vim.keymap.set(
      "n",
      "<leader>cA",
      crates.upgrade_all_crates,
      { noremap = true, silent = true, buffer = true, desc = "Crates: Upgrade all crates" }
    )

    vim.keymap.set(
      "n",
      "<leader>cH",
      crates.open_homepage,
      { noremap = true, silent = true, buffer = true, desc = "Crates: Open homepage" }
    )
    vim.keymap.set(
      "n",
      "<leader>cR",
      crates.open_repository,
      { noremap = true, silent = true, buffer = true, desc = "Crates: Open repo" }
    )
    vim.keymap.set(
      "n",
      "<leader>cD",
      crates.open_documentation,
      { noremap = true, silent = true, buffer = true, desc = "Crates: Open docs" }
    )
    vim.keymap.set(
      "n",
      "<leader>cC",
      crates.open_crates_io,
      { noremap = true, silent = true, buffer = true, desc = "Crates: open crates.io" }
    )
  end,
})
