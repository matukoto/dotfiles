-- dot_config/nvim/lua/plugins/lspsaga.lua
return {
  'nvimdev/lspsaga.nvim',
  -- Dependencies: Icons and potentially UI components
  dependencies = {
    'nvim-tree/nvim-web-devicons', -- For icons in UI components
    -- 'nvim-lua/plenary.nvim', -- May be needed by some features
  },
  -- Load lazily, often triggered by LSP events or specific commands/keymaps
  event = 'LspAttach',
  cmd = { 'Lspsaga' }, -- Expose the main command
  -- opts table passes configuration directly to setup()
  opts = {
    ui = {
      border = 'rounded',
      devicon = true,
      foldericon = true,
      title = true,
      -- Use default icons or customize if needed
      -- expand = '⊞', collapse = '⊟', code_action = '💡',
      -- lines = { '┗', '┣', '┃', '━', '┏' },
      -- kind = {}, -- Use default kind icons from devicons
      -- button = { '', '' },
      -- imp_sign = '󰳛 ',
    },
    hover = {
      max_width = 0.9,
      max_height = 0.8,
      open_link = 'gx', -- Command to open links (requires netrw or similar)
      -- open_cmd = '!chrome', -- Custom command to open links (commented out)
    },
    diagnostic = {
      show_layout = 'float',
      show_normal_height = 10,
      jump_num_shortcut = true,
      auto_preview = false,
      max_width = 0.8,
      max_height = 0.6,
      max_show_width = 0.9,
      max_show_height = 0.6,
      wrap_long_lines = true,
      extend_relatedInformation = false,
      diagnostic_only_current = false,
      keys = {
        exec_action = 'o',
        quit = 'q',
        toggle_or_jump = '<CR>',
        quit_in_show = { 'q', '<ESC>' },
      },
    },
    code_action = {
      num_shortcut = true,
      show_server_name = true,
      extend_gitsigns = true, -- Integrate with gitsigns if available
      only_in_cursor = true,
      max_height = 0.3,
      cursorline = true,
      keys = {
        quit = { '<ESC>', 'q' },
        exec = '<CR>',
      },
    },
    lightbulb = {
      enable = false, -- Disabled in original config
      sign = false,
      debounce = 10,
      sign_priority = 40,
      virtual_text = true,
      enable_in_insert = true,
    },
    scroll_preview = {
      scroll_down = '<C-j>',
      scroll_up = '<C-k>',
    },
    request_timeout = 2000,
    finder = {
      max_height = 0.5,
      left_width = 0.4,
      methods = {}, -- Use default methods
      default = 'ref+imp', -- Show references and implementations by default
      layout = 'float',
      silent = false,
      filter = {},
      fname_sub = nil,
      sp_inexist = false,
      sp_global = false,
      ly_botright = false,
      keys = {
        shuttle = '[w', -- Use default or customize
        toggle_or_open = 'o',
        vsplit = 's',
        split = 'i',
        tabe = 't',
        tabnew = 'r',
        quit = 'q',
        close = '<C-c>k', -- Use default or customize
      },
    },
    definition = {
      width = 0.6,
      height = 0.5,
      save_pos = false,
      keys = {
        edit = '<C-o>', -- Use default or customize
        vsplit = '<C-v>',
        split = '<C-x>',
        tabe = '<C-t>',
        tabnew = '<C-c>n', -- Use default or customize
        quit = 'q',
        close = '<ESC>',
      },
    },
    rename = {
      in_select = true, -- Rename in select mode (visual)
      auto_save = false,
      project_max_width = 0.5,
      project_max_height = 0.5,
      keys = {
        quit = { '<ESC>', 'q' },
        exec = '<CR>',
        select = 'x',
      },
    },
    symbol_in_winbar = {
      enable = true,
      separator = ' › ',
      hide_keyword = false,
      ignore_patterns = nil,
      show_file = true,
      folder_level = 1,
      color_mode = true,
      delay = 300,
    },
    outline = {
      win_position = 'right',
      win_width = 30,
      auto_preview = true,
      detail = true,
      auto_close = true,
      close_after_jump = false,
      layout = 'normal',
      max_height = 0.5,
      left_width = 0.3,
      keys = {
        toggle_or_jump = 'o',
        quit = 'q',
        jump = 'e',
      },
    },
    callhierarchy = {
      layout = 'float',
      left_width = 0.2,
      keys = {
        edit = 'e',
        vsplit = 's',
        split = 'i',
        tabe = 't',
        close = '<C-c>k',
        quit = 'q',
        shuttle = '[w',
        toggle_or_req = 'u',
      },
    },
    typehierarchy = {
      layout = 'float',
      left_width = 0.2,
      keys = {
        edit = 'e',
        vsplit = 's',
        split = 'i',
        tabe = 't',
        close = '<C-c>k',
        quit = 'q',
        shuttle = '[w',
        toggle_or_req = 'u',
      },
    },
    implement = {
      enable = false, -- Disabled in original config
      sign = true,
      lang = {},
      virtual_text = true,
      priority = 100,
    },
    beacon = {
      enable = true,
      frequency = 7,
    },
    floaterm = {
      height = 0.7,
      width = 0.7,
    },
    -- logger = { ... }, -- Configure logging if needed
    -- pt = { ... }, -- Configure project management if needed
  },
  -- Define keymaps using the 'keys' table (optional, can also be in lspconfig)
  -- These are common mappings often associated with lspsaga
  keys = {
    -- LSP Navigation / Actions (ensure these don't conflict with lspconfig mappings)
    { 'gh', '<cmd>Lspsaga lsp_finder<CR>', desc = 'LSP Finder' },
    { 'ga', '<cmd>Lspsaga code_action<CR>', mode = { 'n', 'v' }, desc = 'Code Action' },
    { 'K', '<cmd>Lspsaga hover_doc<CR>', mode = 'n', desc = 'Hover Doc' },
    { 'gd', '<cmd>Lspsaga peek_definition<CR>', mode = 'n', desc = 'Peek Definition' },
    { 'gr', '<cmd>Lspsaga rename<CR>', mode = 'n', desc = 'Rename' },
    -- Diagnostics
    { '[e', '<cmd>Lspsaga diagnostic_jump_prev<CR>', mode = 'n', desc = 'Prev Diagnostic' },
    { ']e', '<cmd>Lspsaga diagnostic_jump_next<CR>', mode = 'n', desc = 'Next Diagnostic' },
    {
      '<leader>sl',
      '<cmd>Lspsaga show_line_diagnostics<CR>',
      mode = 'n',
      desc = 'Show Line Diagnostics',
    },
    {
      '<leader>sb',
      '<cmd>Lspsaga show_buf_diagnostics<CR>',
      mode = 'n',
      desc = 'Show Buffer Diagnostics',
    },
    -- Outline
    { '<leader>so', '<cmd>Lspsaga outline<CR>', mode = 'n', desc = 'Outline' },
  },
  -- No explicit config function needed if opts and keys are sufficient
  -- config = function(_, opts)
  --   require('lspsaga').setup(opts)
  --   -- Keymaps could also be defined here
  -- end,
}
