local M = {}

-- nvim treesitter configuration (default plugin)
M.treesitter = {
   ensure_installed = {
      "lua",
      "html",
      "css",
      "javascript",
      "cpp",
      "c_sharp",
      "java",
      "python",
      "rust",
      "bash",
      "markdown",
      "go",
      "json",
      "toml",
      "make",
      "regex",
      "yaml",
   },
   rainbow = {
    enable = true,
    -- disable = { "jsx", "cpp" }, list of languages you want to disable the plugin for
    extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
    max_file_lines = nil, -- Do not enable for files with more than n lines, int
    -- colors = {}, -- table of hex strings
    -- termcolors = {} -- table of colour name strings
  },
  autotag = {
	  enable = true,
  }
}

-- numb plugin configuration (peak lines)
require('numb').setup{
  show_numbers = true, -- Enable 'number' for the window while peeking
  show_cursorline = true, -- Enable 'cursorline' for the window while peeking
  number_only = false, -- Peek only when the command is only a number instead of when it starts with a number
  centered_peeking = true, -- Peeked line will be centered relative to window
}

-- neoscroll plugin configuration (smooth scroll)
require('neoscroll').setup({
    -- All these keys will be mapped to their corresponding default scrolling animation
    mappings = {'<C-u>', '<C-d>', '<C-b>', '<C-f>',
                '<C-y>', '<C-e>', 'zt', 'zz', 'zb'},
    hide_cursor = true,          -- Hide cursor while scrolling
    stop_eof = true,             -- Stop at <EOF> when scrolling downwards
    use_local_scrolloff = false, -- Use the local scope of scrolloff instead of the global scope
    respect_scrolloff = false,   -- Stop scrolling when the cursor reaches the scrolloff margin of the file
    cursor_scrolls_alone = true, -- The cursor will keep on scrolling even if the window cannot scroll further
    easing_function = nil,       -- Default easing function
    pre_hook = nil,              -- Function to run before the scrolling animation starts
    post_hook = nil,             -- Function to run after the scrolling animation ends
    performance_mode = false,    -- Disable "Performance Mode" on all buffers.
})

-- auto save plugin configuration
require('autosave').setup{
	enabled = true,
}

-- nvim lastplace plugin configuration (remember session)
require('nvim-lastplace').setup()

-- formatter plugin configuration (format files)
local file_type = require "custom.plugins.formatters"
require('formatter').setup{
	filetype = file_type.filetype,
}

-- rust-tools plugin configuration
require('rust-tools').setup{
	tools = { -- rust-tools options
	autoSetHints = true,
	hover_with_actions = true,
	inlay_hints = {
		show_parameter_hints = false,
		parameter_hints_prefix = "",
		other_hints_prefix = "",
		},
	}
}

-- trouble plugin configruration (diagonostics list)
require('trouble').setup()

return M
