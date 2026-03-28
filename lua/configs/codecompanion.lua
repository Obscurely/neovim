local codecompanion = require "codecompanion"

local M = {}

M.setup = function()
  codecompanion.setup {
    strategies = {
      chat = {
        adapter = "openrouter",
      },
      inline = {
        adapter = "openrouter",
      },
    },

    adapters = {
      http = {
        anthropic = function()
          return require("codecompanion.adapters").extend("anthropic", {
            env = {
              api_key = "cmd:gpg --decrypt ~/.anthropic/api.key.gpg 2>/dev/null",
            },
            schema = {
              model = {
                default = "claude-sonnet-4-5-20250929",
              },
              extended_output = {
                default = false,
              },
              extended_thinking = {
                default = true,
              },
            },
          })
        end,
        openrouter = function()
          return require("codecompanion.adapters").extend("openai_compatible", {
            formatted_name = "OpenRouter",
            env = {
              url = "https://openrouter.ai/api/v1",
              api_key = "cmd:cat ~/.openrouter/api.key",
              chat_url = "/chat/completions",
            },
            schema = {
              model = {
                default = "deepseek/deepseek-v3.2",
              },
              -- This correctly sends the object payload OpenRouter expects
              reasoning = {
                mapping = "parameters",
                default = {
                  enabled = true,
                  effort = "high",
                },
              },
            },
            -- This intercepts the response and maps the reasoning tokens to the UI
            handlers = {
              parse_message_meta = function(_, data)
                local extra = data.extra
                -- Check for both 'reasoning' (OpenRouter) and 'reasoning_content' (DeepSeek native) just to be safe
                local reasoning_text = extra and (extra.reasoning or extra.reasoning_content)

                if reasoning_text then
                  data.output.reasoning = { content = reasoning_text }
                  if data.output.content == "" then
                    data.output.content = nil
                  end
                end
                return data
              end,
            },
          })
        end,
        gemini = function()
          return require("codecompanion.adapters").extend("gemini", {
            env = {
              api_key = "cmd:gpg --decrypt ~/.gemini/api.key.gpg 2>/dev/null",
            },
            schema = {
              model = {
                default = "gemini-3-pro-preview",
              },
              reasoning_effort = {
                enabled = true,
                default = "high",
              },
            },
          })
        end,
        ollama = function()
          return require("codecompanion.adapters").extend("ollama", {
            schema = {
              model = {
                default = "qwen2.5-coder:3b",
              },
            },
          })
        end,
      },
    },

    display = {
      action_palette = {
        provider = "telescope",
      },
      chat = {
        fold_reasoning = true,
        show_reasoning = true,
      },
    },
  }
end

return M
