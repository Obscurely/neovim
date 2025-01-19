local codeium = require "codeium"

local M = {}

M.setup = function()
  codeium.setup {
    wrapper = "/etc/profiles/per-user/" .. os.getenv "USER" .. "/bin/codeium_language_server",
    enable_chat = false,
    tools = {
      language_server = "/etc/profiles/per-user/" .. os.getenv "USER" .. "/bin/codeium_language_server",
    },
  }
end

return M
