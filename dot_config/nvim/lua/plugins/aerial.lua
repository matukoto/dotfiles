-- dot_config/nvim/lua/plugins/aerial.lua
return {
  'stevearc/aerial.nvim',
  -- Dependencies like treesitter and devicons are important
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-tree/nvim-web-devicons"
  },
  -- Load lazily, triggered by commands, keymaps, or events
  cmd = { "AerialToggle", "AerialOpen", "AerialInfo" },
  event = "VeryLazy", -- Or specific BufRead events if preferred
  opts = {
    -- Backend priority list
    backends = { 'treesitter', 'lsp', 'markdown', 'asciidoc', 'man' },

    layout = {
      max_width = { 40, 0.2 }, -- Max 40 columns or 20% of width
      width = nil,
      min_width = 10,
      win_opts = {},
      default_direction = 'prefer_left', -- Prefer left, open right if needed
      placement = 'window', -- Place next to the current window
      resize_to_content = true,
      preserve_equality = false,
    },

    attach_mode = 'window', -- Show symbols for the window aerial was opened from
    close_automatic_events = {}, -- Don't auto-close based on events

    -- Keymaps within the aerial window (copied from original config)
    keymaps = {
      ['?'] = 'actions.show_help',
      ['g?'] = 'actions.show_help',
      ['<CR>'] = 'actions.jump',
      ['<2-LeftMouse>'] = 'actions.jump',
      ['<C-v>'] = 'actions.jump_vsplit',
      ['<C-s>'] = 'actions.jump_split',
      ['p'] = 'actions.scroll',
      ['<C-j>'] = 'actions.down_and_scroll',
      ['<C-k>'] = 'actions.up_and_scroll',
      ['{'] = 'actions.prev',
      ['}'] = 'actions.next',
      ['[['] = 'actions.prev_up',
      [']]'] = 'actions.next_up',
      ['q'] = 'actions.close',
      ['o'] = 'actions.tree_toggle',
      ['za'] = 'actions.tree_toggle',
      ['O'] = 'actions.tree_toggle_recursive',
      ['zA'] = 'actions.tree_toggle_recursive',
      ['l'] = 'actions.tree_open',
      ['zo'] = 'actions.tree_open',
      ['L'] = 'actions.tree_open_recursive',
      ['zO'] = 'actions.tree_open_recursive',
      ['h'] = 'actions.tree_close',
      ['zc'] = 'actions.tree_close',
      ['H'] = 'actions.tree_close_recursive',
      ['zC'] = 'actions.tree_close_recursive',
      ['zr'] = 'actions.tree_increase_fold_level',
      ['zR'] = 'actions.tree_open_all',
      ['zm'] = 'actions.tree_decrease_fold_level',
      ['zM'] = 'actions.tree_close_all',
      ['zx'] = 'actions.tree_sync_folds',
      ['zX'] = 'actions.tree_sync_folds',
    },

    lazy_load = true, -- Don't load until needed
    disable_max_lines = 10000,
    disable_max_size = 2000000, -- 2MB

    -- Filter shown symbol kinds
    filter_kind = {
      'Class', 'Constructor', 'Enum', 'Function',
      'Interface', 'Module', 'Method', 'Struct',
    },

    highlight_mode = 'split_width',
    highlight_closest = true,
    highlight_on_hover = false,
    highlight_on_jump = 300, -- Highlight for 300ms on jump
    autojump = false,
    icons = {}, -- Use default icons (lspkind or devicons)
    nerd_font = 'auto', -- Auto-detect nerd font usage

    -- Ignore settings
    ignore = {
      unlisted_buffers = false,
      diff_windows = true,
      filetypes = {},
      buftypes = 'special',
      wintypes = 'special',
    },

    manage_folds = false,
    link_folds_to_tree = false,
    link_tree_to_folds = true, -- Fold code when collapsing tree

    on_attach = nil, -- function(bufnr) ... end,
    on_first_symbols = nil, -- function(bufnr) ... end,
    open_automatic = false,
    post_jump_cmd = 'normal! zz', -- Center screen after jump
    post_parse_symbol = nil, -- function(bufnr, item, ctx) return true end,
    post_add_all_symbols = nil, -- function(bufnr, items, ctx) return items end,
    close_on_select = false,
    update_events = 'TextChanged,InsertLeave',
    show_guides = false,
    guides = {
      mid_item = '├─',
      last_item = '└─',
      nested_top = '│ ',
      whitespace = '  ',
    },
    get_highlight = nil, -- function(symbol, is_icon, is_collapsed) ... end,

    -- Float settings (if layout.default_direction = 'float')
    float = {
      border = 'rounded',
      relative = 'cursor',
      max_height = 0.9,
      height = nil,
      min_height = { 8, 0.1 },
      override = function(conf, source_winid) return conf end,
    },

    -- Nav settings (for floating nav window, if used)
    nav = {
      border = 'rounded',
      max_height = 0.9,
      min_height = { 10, 0.1 },
      max_width = 0.5,
      min_width = { 0.2, 20 },
      win_opts = { cursorline = true, winblend = 10 },
      autojump = false,
      preview = false,
      keymaps = {
        ['<CR>'] = 'actions.jump',
        ['<2-LeftMouse>'] = 'actions.jump',
        ['<C-v>'] = 'actions.jump_vsplit',
        ['<C-s>'] = 'actions.jump_split',
        ['h'] = 'actions.left',
        ['l'] = 'actions.right',
        ['<C-c>'] = 'actions.close',
      },
    },

    -- Backend specific settings
    lsp = {
      diagnostics_trigger_update = false,
      update_when_errors = true,
      update_delay = 300,
      priority = {},
    },
    treesitter = {
      update_delay = 300,
    },
    markdown = {
      update_delay = 300,
    },
    asciidoc = {
      update_delay = 300,
    },
    man = {
      update_delay = 300,
    },
  },
  -- Define global keymaps using the 'keys' table
  keys = {
    { "<leader>a", "<cmd>AerialToggle!<CR>", desc = "Toggle Aerial Outline" },
  },
  -- config function to define autocmds after setup
  config = function(_, opts)
    -- Call the setup function with the options
    require("aerial").setup(opts)

    -- Autocmd to open aerial automatically for markdown files
    vim.api.nvim_create_autocmd('BufRead', {
      group = vim.api.nvim_create_augroup('AerialMarkdownAutoOpen', { clear = true }),
      pattern = { '*.md' },
      callback = function()
        -- Use vim.schedule to ensure aerial is loaded if lazy-loaded
        vim.schedule(function()
          local aerial_ok, aerial = pcall(require, 'aerial')
          if aerial_ok then
            aerial.open({
              focus = false, -- Don't focus the aerial window
              direction = 'right', -- Open to the right
              -- You might want to check if it's already open
              -- if not aerial.is_open() then ... end
            })
          end
        end)
      end,
    })
  end,
}
