local gen = require "gen"

local M = {}

M.setup = function()
  -- Options
  gen.setup {
    model = "codeqwen-optimized:latest", -- The default model to use.
    host = "ollama.server.com",                -- The host running the Ollama service.
    port = "443",                              -- The port on which the Ollama service is listening.
    quit_map = "q",                            -- set keymap for close the response window
    retry_map = "<c-r>",                       -- set keymap to re-send the current prompt
    -- Function to initialize Ollama
    command = function(options)
      local body = { model = options.model, stream = true }
      return "curl --insecure --silent --no-buffer -X POST https://"
          .. options.host
          .. ":"
          .. options.port
          .. "/api/chat -d $body"
    end,
    display_mode = "split", -- The display mode. Can be "float" or "split".
    show_prompt = true,     -- Shows the prompt submitted to Ollama.
    show_model = true,      -- Displays which model you are using at the beginning of your chat session.
    no_auto_close = true,   -- Never closes the window automatically.
    debug = false,          -- Prints errors and the command which is run.
  }

  -- Prompts
  gen.prompts = {
    Generate = {
      prompt = "$input",
      replace = true,
      extract = "```$filetype\n(.-)```",
      model = "codeqwen-optimized:latest",
    },

    Chat_Code = { prompt = "$input", model = "codeqwen-optimized:latest" },

    Review_Code = {
      prompt =
      "Please analyze the following code snippet and provide specific, actionable suggestions for improvement:\n```$filetype\n$text\n```",
      model = "codeqwen-optimized:latest",
    },

    Fix_Code = {
      prompt =
      "Please debug and optimize this code snippet. Identify any syntax errors, logic flaws, or inefficiencies and provide a corrected version: Only ouput the result in format ```$filetype\n...\n```:\n```$filetype\n$text\n```",
      replace = true,
      extract = "```$filetype\n(.-)```",
      model = "codeqwen-optimized:latest",
    },

    Enhance_Code = {
      prompt =
      "Refactor the provided code snippet for improved efficiency and readability. Ensure that the refactored code adheres strictly to coding best practices, including the DRY (Don't Repeat Yourself) principle. Add descriptive comments to clarify any complex logic involved. Aim for optimal performance and maintainability. Only output the result in format ```$filetype\n...\n```:\n```$filetype\n$text\n```",
      replace = true,
      extract = "```$filetype\n(.-)```",
      model = "codeqwen-optimized:latest",
    },

    Change_Code = {
      prompt =
      "Regarding the following code, $input. Only output the result in format ```$filetype\n...\n```:\n```$filetype\n$text\n```",
      replace = true,
      extract = "```$filetype\n(.-)```",
      model = "codeqwen-optimized:latest",
    },

    Chat = { prompt = "$input", model = "llama3-optimized:latest" },

    Summarize = {
      prompt = "Please provide a concise summary of the text below:\n$text",
      model = "llama3-optimized:latest",
    },

    Ask = { prompt = "Regarding the following text, $input:\n$text", model = "llama3-optimized:latest" },

    Ask_Code = { prompt = "Regarding the following snippet, $input:\n$text", model = "codeqwen-optimized:latest" },

    Change = {
      prompt =
      "Change the following text, $input. Just output the final text without additional quotes around it:\n$text",
      replace = true,
      model = "llama3-optimized:latest",
    },

    Enhance_Grammar_Spelling = {
      prompt =
      "Revise the following text to enhance grammar and spelling accuracy. Just output the final text without additional quotes around it:\n$text",
      replace = true,
      model = "llama3-optimized:latest",
    },

    Enhance_Wording = {
      prompt =
      "Revise the following text to enhance its clarity and effectiveness. Just output the final text without additional quotes around it:\n$text",
      replace = true,
      model = "llama3-optimized:latest",
    },

    Make_Concise = {
      prompt = "Simplify the text below. Just output the final text without additional quotes around it:\n$text",
      replace = true,
      model = "llama3-optimized:latest",
    },

    Make_List = {
      prompt = "Please convert the text below into a markdown-formatted list:\n$text",
      replace = true,
      model = "llama3-optimized:latest",
    },

    Make_Table = {
      prompt =
      "Please convert the following data into a well-structured markdown table format. Include headers as appropriate and ensure the data is neatly organized in rows and columns with appropriate alignments:\n$text",
      replace = true,
      model = "llama3-optimized:latest",
    },
  } -- clear all the promps so I can set only the ones I need
end

return M
