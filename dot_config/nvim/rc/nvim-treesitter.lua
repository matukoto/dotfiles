require('nvim-treesitter.configs').setup({
  ensure_installed = {
    -- Neovim
    'query',
    'vimdoc',
    'vim',
    'lua',
    'fsharp',
    -- フロント
    'typescript',
    'tsx',
    'javascript',
    'vue',
    'svelte',
    'html',
    'css',
    --
    'java',
    'groovy',
    'bash',
    'go',
    'sql',
    -- 'nu',
    'markdown',
    'markdown_inline',
    -- ファイル
    'dot',
    'json',
    'yaml',
    'toml',
  },
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = { 'markdown' },
  },
  endwise = {
    enable = true,
  },
  indent = {
    enable = true,
  },
})

-- default settings
require('treesitter-context').setup({
  enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
  max_lines = 0, -- How many lines the window should span. Values <= 0 mean no limit.
  min_window_height = 0, -- Minimum editor window height to enable context. Values <= 0 mean no limit.
  line_numbers = true,
  multiline_threshold = 20, -- Maximum number of lines to show for a single context
  trim_scope = 'outer', -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
  mode = 'cursor', -- Line used to calculate context. Choices: 'cursor', 'topline'
  -- Separator between context and content. Should be a single character string, like '-'.
  -- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
  separator = nil,
  zindex = 20, -- The Z-index of the context window
  on_attach = nil, -- (fun(buf: integer): boolean) return false to disable attaching
})
