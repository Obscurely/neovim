local autosave = require "autosave"

local M = {}

M.setup = function()
   	autosave.setup {
		enabled = true,
	}
end

return M
