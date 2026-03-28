local autocmd = vim.api.nvim_create_autocmd
-- Auto-save functionality using autocommands
-- Create AutoSave group
vim.api.nvim_create_augroup("AutoSave", { clear = true })

-- Initialize auto-save toggle global variable
vim.g.auto_save_enabled = true

autocmd({ "InsertLeave", "TextChanged", "BufLeave", "FocusLost" }, {
  group = "AutoSave",
  callback = function()
    -- Check if auto-save is enabled before proceeding
    if not vim.g.auto_save_enabled then
      return
    end

    -- Exclude specific filetypes or unmodifiable buffers
    if vim.bo.filetype == "gitcommit" or vim.bo.filetype == "harpoon" or vim.bo.buftype == "nofile" then
      return
    end

    -- Check modifiable + unsaved changes
    if vim.bo.modifiable and vim.bo.modified then
      local success, err = pcall(function()
        vim.cmd "silent! write" -- Silent write to avoid command errors

		if vim.bo.filetype == "rust" then
		  vim.cmd("RustLsp flyCheck")
		end
      end)

      -- Get the current time
      local time = os.date "%H:%M:%S" -- Format: HH:MM:SS

      -- Improved notification with file name, time, and polished messages
      if success then
        vim.notify(
          string.format(" Auto-saved %s at %s", vim.fn.expand "%:t", time), -- File name + time
          vim.log.levels.INFO,
          { title = " AutoSave", timeout = 1000 }
        )
      else
        vim.notify(
          string.format("✗ Auto-save failed at %s: %s", time, err), -- Time + error message
          vim.log.levels.ERROR,
          { title = " AutoSave", timeout = 2000 }
        )
      end
    end
  end,
})

-- Toggle auto-save using a keymap
vim.keymap.set("n", "<C-q>", function()
  vim.g.auto_save_enabled = not vim.g.auto_save_enabled
  if vim.g.auto_save_enabled then
    vim.notify(
      string.format(" Auto-save enabled at %s", os.date "%H:%M:%S"), -- Time added
      vim.log.levels.INFO,
      { title = " AutoSave", timeout = 1000 }
    )
  else
    vim.notify(
      string.format("✗ Auto-save disabled at %s", os.date "%H:%M:%S"), -- Time added
      vim.log.levels.WARN,
      { title = " AutoSave", timeout = 1000 }
    )
  end
end, { desc = "Toggle AutoSave" })

-- Restore cursor position
autocmd("BufReadPost", {
  pattern = "*",
  callback = function()
    local line = vim.fn.line "'\""
    if
      line > 1
      and line <= vim.fn.line "$"
      and vim.bo.filetype ~= "commit"
      and vim.fn.index({ "xxd", "gitrebase" }, vim.bo.filetype) == -1
    then
      vim.cmd 'normal! g`"'
    end
  end,
})

-- Show NVDash when all buffers are closed
autocmd("BufDelete", {
  callback = function()
    local bufs = vim.t.bufs
    if #bufs == 1 and vim.api.nvim_buf_get_name(bufs[1]) == "" then
      vim.cmd "Nvdash"
    end
  end,
})

-- Set filetype for .j2 files
autocmd({ "BufRead", "BufNewFile" }, {
  pattern = { "*.j2", "*.jinja2" },
  callback = function()
    local filename = vim.fn.expand "%:t"
    if filename:match "%.yaml%.j2$" or filename:match "%.yml%.j2$" or filename:match "%.yaml%.jinja2$" or filename:match "%.yml%.jinja2$" then
      vim.bo.filetype = "yaml"
    else
      vim.bo.filetype = "jinja"
    end
  end,
})

-- Alacritty integration: opaque background, matching color, zero padding
vim.api.nvim_create_augroup("AlacrittyIntegration", { clear = true })

local function apply_alacritty_config()
  local bg = nil
  local hl = vim.api.nvim_get_hl(0, { name = "Normal", link = false })
  if hl.bg then
    bg = string.format("#%06x", hl.bg)
  end

  vim.fn.system { "alacritty", "msg", "config", "window.opacity=1" }
  vim.fn.system { "alacritty", "msg", "config", "window.padding.x=0" }
  vim.fn.system { "alacritty", "msg", "config", "window.padding.y=0" }
  if bg then
    vim.fn.system { "alacritty", "msg", "config", ("colors.primary.background='%s'"):format(bg) }
  end
end

autocmd("UIEnter", {
  group = "AlacrittyIntegration",
  callback = function()
    vim.schedule(apply_alacritty_config)
  end,
})

autocmd("ColorScheme", {
  group = "AlacrittyIntegration",
  callback = function()
    vim.schedule(apply_alacritty_config)
  end,
})

autocmd("VimLeavePre", {
  group = "AlacrittyIntegration",
  callback = function()
    vim.fn.system { "alacritty", "msg", "config", "--reset" }
  end,
})
