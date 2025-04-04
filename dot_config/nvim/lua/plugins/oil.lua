-- dot_config/nvim/lua/plugins/oil.lua
return {
  'stevearc/oil.nvim',
  -- Dependencies: Icons are nice to have
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  -- Load lazily, triggered by command or keymap
  cmd = 'Oil',
  event = 'VeryLazy',
  -- opts table passes configuration directly to setup()
  opts = {
    default_file_explorer = false, -- Don't replace netrw by default
    columns = {
      'icon', -- Show filetype icons
      -- "permissions",
      -- "size",
      -- "mtime",
    },
    buf_options = {
      buflisted = false,
      bufhidden = 'hide',
    },
    win_options = {
      wrap = false,
      signcolumn = 'no',
      cursorcolumn = false,
      foldcolumn = '0',
      spell = false,
      list = false,
      conceallevel = 3,
      concealcursor = 'nvic',
    },
    delete_to_trash = false, -- Use standard rm
    skip_confirm_for_simple_edits = false,
    prompt_save_on_select_new_entry = true,
    cleanup_delay_ms = 2000,
    lsp_file_methods = {
      timeout_ms = 1000,
      autosave_changes = false,
    },
    constrain_cursor = 'editable', -- Keep cursor on filenames/dirnames
    experimental_watch_for_changes = false, -- Disable filesystem watching

    -- Keymaps defined within oil.nvim buffer
    -- These are used because use_default_keymaps = false below
    keymaps = {
      ['?'] = 'actions.show_help',
      ['<CR>'] = 'actions.select',
      ['<C-s>'] = 'actions.select_vsplit', -- Vertical split
      ['<C-h>'] = 'actions.select_split', -- Horizontal split (use <C-x> if <C-h> conflicts)
      ['<C-t>'] = 'actions.select_tab', -- Open in new tab
      ['<C-p>'] = 'actions.preview', -- Preview file
      ['<C-c>'] = 'actions.close', -- Close oil buffer
      ['<C-l>'] = 'actions.refresh', -- Refresh
      ['-'] = 'actions.parent', -- Go to parent directory
      ['_'] = 'actions.open_cwd', -- Open oil in current working directory
      ['`'] = 'actions.cd', -- cd into directory
      ['~'] = 'actions.tcd', -- cd into directory in new tab
      ['gs'] = 'actions.change_sort', -- Change sort order
      ['ge'] = 'actions.open_external', -- Open with external app
      ['!'] = 'actions.toggle_hidden', -- Toggle hidden files
      ['g\\'] = 'actions.toggle_trash', -- Toggle trash behavior (if enabled)
    },
    keymaps_help = {
      border = 'rounded',
    },
    -- Disable default keymaps to use the custom ones defined above
    use_default_keymaps = false,
    view_options = {
      show_hidden = false, -- Do not show hidden files by default
      is_hidden_file = function(name, bufnr)
        return vim.startswith(name, '.')
      end,
      is_always_hidden = function(name, bufnr)
        return false
      end,
      natural_order = true, -- Sort intuitively
      sort = {
        { 'type', 'asc' }, -- Sort folders first
        { 'name', 'asc' }, -- Then sort by name
      },
    },
    git = { -- Disable git integration by default
      add = function(path)
        return false
      end,
      mv = function(src_path, dest_path)
        return false
      end,
      rm = function(path)
        return false
      end,
    },
    float = {
      padding = 2,
      max_width = 0,
      max_height = 0,
      border = 'rounded',
      win_options = { winblend = 0 },
      override = function(conf)
        return conf
      end,
    },
    preview = {
      max_width = 0.9,
      min_width = { 40, 0.4 },
      width = nil,
      max_height = 0.9,
      min_height = { 5, 0.1 },
      height = nil,
      border = 'rounded',
      win_options = { winblend = 0 },
      update_on_cursor_moved = true,
    },
    progress = {
      max_width = 0.9,
      min_width = { 40, 0.4 },
      width = nil,
      max_height = { 10, 0.9 },
      min_height = { 5, 0.1 },
      height = nil,
      border = 'rounded',
      minimized_border = 'none',
      win_options = { winblend = 0 },
    },
    ssh = {
      border = 'rounded',
    },
  },
  -- Define global keymaps using the 'keys' table
  keys = {
    { '<Leader>n', '<cmd>Oil --float<CR>', desc = 'Open Oil (Float)' },
    -- Add other global keymaps if needed, e.g., open in current window
    -- { "-", "<cmd>Oil<CR>", desc = "Open parent directory" }, -- Example mapping for '-'
  },
  -- No explicit config function needed if opts and keys are sufficient
  -- config = function(_, opts)
  --   require('oil').setup(opts)
  --   -- Keymaps could also be defined here
  -- end,
}
