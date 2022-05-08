local rusttools = require "rust-tools"

local M = {}

M.setup = function()
   	rusttools.setup {
		tools = { -- rust-tools options
			autoSetHints = true,
			hover_with_actions = true,
			inlay_hints = {
				show_parameter_hints = false,
				parameter_hints_prefix = "",
				other_hints_prefix = "",
			},
		},
	}
end

return M
