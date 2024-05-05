local select = require('CopilotChat.select')
local prompts = require('CopilotChat.prompts')

require('CopilotChat').setup({
  debug = false, -- Enable debug logging
  proxy = nil, -- [protocol://]host[:port] Use this proxy
  allow_insecure = false, -- Allow insecure server connections

  system_prompt = prompts.COPILOT_INSTRUCTIONS, -- System prompt to use
  model = 'gpt-4', -- GPT model to use, 'gpt-3.5-turbo' or 'gpt-4'
  temperature = 0.1, -- GPT temperature

  question_header = '## User ', -- Header to use for user questions
  answer_header = '## Copilot ', -- Header to use for AI answers
  error_header = '## Error ', -- Header to use for errors
  separator = '---', -- Separator to use in chat

  show_folds = true, -- Shows folds for sections in chat
  show_help = true, -- Shows help message as virtual lines when waiting for user input
  auto_follow_cursor = true, -- Auto-follow cursor in chat
  auto_insert_mode = false, -- Automatically enter insert mode when opening window and if auto follow cursor is enabled on new prompt
  clear_chat_on_new_prompt = false, -- Clears chat on every new prompt

  context = nil, -- Default context to use, 'buffers', 'buffer' or none (can be specified manually in prompt via @).
  history_path = vim.fn.stdpath('data') .. '/copilotchat_history', -- Default path to stored history
  callback = nil, -- Callback to use when ask response is received

  -- default selection (visual or line)
  selection = function(source)
    return select.visual(source) or select.line(source)
  end,

  -- default prompts
  prompts = {
    Explain = {
      prompt = '/COPILOT_EXPLAIN Write an explanation for the active selection as paragraphs of text in Japanese.',
    },
    Review = {
      prompt = '/COPILOT_REVIEW Review the selected code in Japanese.',
      callback = function(response, source)
        -- see config.lua for implementation
      end,
    },
    Tests = {
      prompt = '/COPILOT_TESTS カーソル上のコードの詳細な単体テスト関数を書いてください。',
    },
    Fix = {
      prompt = '/COPILOT_FIX このコードには問題があります。バグを修正したコードに書き換えてください。',
    },
    Optimize = {
      prompt = '/COPILOT_REFACTOR 選択したコードを最適化し、パフォーマンスと可読性を向上させてください。',
    },
    Docs = {
      prompt = '/COPILOT_REFACTOR 選択したコードのドキュメントを書いてください。ドキュメントをコメントとして追加した元のコードを含むコードブロックで回答してください。使用するプログラミング言語に最も適したドキュメントスタイルを使用してください（例：JavaScriptのJSDoc、Pythonのdocstringsなど）',
    },
    FixDiagnostic = {
      prompt = 'ファイル内の次のような診断上の問題を解決してください：',
      selection = select.diagnostics,
    },
    Commit = {
      prompt = 'Write commit message for the change with commitizen convention. Make sure the title has maximum 50 characters and message is wrapped at 72 characters. Wrap the whole message in code block with language gitcommit.',
      selection = select.gitdiff,
    },
    CommitStaged = {
      prompt = 'Write commit message for the change with commitizen convention. Make sure the title has maximum 50 characters and message is wrapped at 72 characters. Wrap the whole message in code block with language gitcommit.',
      selection = function(source)
        return select.gitdiff(source, true)
      end,
    },
  },

  -- default window options
  window = {
    layout = 'vertical', -- 'vertical', 'horizontal', 'float'
    width = 0.5, -- fractional width of parent, or absolute width in columns when > 1
    height = 0.5, -- fractional height of parent, or absolute height in rows when > 1
    -- Options below only apply to floating windows
    relative = 'editor', -- 'editor', 'win', 'cursor', 'mouse'
    border = 'single', -- 'none', single', 'double', 'rounded', 'solid', 'shadow'
    row = nil, -- row position of the window, default is centered
    col = nil, -- column position of the window, default is centered
    title = 'Copilot Chat', -- title of chat window
    footer = nil, -- footer of chat window
    zindex = 1, -- determines if window is on top or below other floating windows
  },

  -- default mappings
  mappings = {
    complete = {
      detail = 'Use @<Tab> or /<Tab> for options.',
      insert = '<Tab>',
    },
    close = {
      normal = 'q',
      insert = '<C-c>',
    },
    reset = {
      normal = '<C-l>',
      insert = '<C-l>',
    },
    submit_prompt = {
      normal = '<CR>',
      insert = '<C-m>',
    },
    accept_diff = {
      normal = '<C-y>',
      insert = '<C-y>',
    },
    yank_diff = {
      normal = 'gy',
    },
    show_diff = {
      normal = 'gd',
    },
    show_system_prompt = {
      normal = 'gp',
    },
    show_user_selection = {
      normal = 'gs',
    },
  },
})

function ShowCopilotChatActionPrompt()
  local actions = require('CopilotChat.actions')
  require('CopilotChat.integrations.telescope').pick(actions.prompt_actions())
end

-- バッファの内容全体を使って Copilot とチャットする
function CopilotChatBuffer()
  local input = vim.fn.input('Quick Chat: ')
  if input ~= '' then
    require('CopilotChat').ask(input, { selection = select.buffer })
  end
end

vim.api.nvim_set_keymap(
  'n',
  '<leader>cp',
  '<cmd>lua ShowCopilotChatActionPrompt()<cr>',
  { noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
  'n',
  '<leader>cq',
  '<cmd>lua CopilotChatBuffer()<cr>',
  { noremap = true, silent = true }
)

-- vim.api.nvim_create_autocmd('BufEnter', {
--     pattern = 'copilot-*',
--     callback = function()
--         vim.opt_local.relativenumber = true
--
--         -- C-p to print last response
--         vim.keymap.set('n', '<C-p>', function()
--           print(require("CopilotChat").response())
--         end, { buffer = true, remap = true })
--     end
-- })

-- function ShowCopilotChatActionPromptVisualSelection()
--   -- Get the start and end line of the visual selection
--   local start_line, end_line = unpack(vim.fn.getpos("'<"), 2, 3), unpack(vim.fn.getpos("'>"), 2, 3)
--
--   -- Get the text in the visual selection
--   local lines = vim.api.nvim_buf_get_lines(0, start_line - 1, end_line, false)
--
--   -- Join the lines into a single string
--   local input = table.concat(lines, "\n")
--
--   -- Send the input to ShowCopilotChatActionPrompt
--   if input ~= "" then
--     require("CopilotChat").ShowCopilotChatActionPrompt(input, { selection = select.visual })
--   end
-- end
--
-- vim.api.nvim_set_keymap("v", "<leader>cv", "<cmd>lua ShowCopilotChatActionPromptVisualSelection()<cr>", { noremap = true, silent = true })
