-- dot_config/nvim/lua/plugins/flash.lua
return {
  'folke/flash.nvim',
  -- Load lazily, triggered by keymaps or commands
  event = 'VeryLazy',
  ---@type Flash.Config
  opts = {
    labels = 'asdfghjklqwertyuiopzxcvbnm',
    search = {
      multi_window = true,
      forward = true,
      wrap = true,
      mode = 'exact', -- 'fuzzy' | 'exact' | 'search' (regex)
      incremental = false, -- Requires entering pattern first
      -- exclude = { ... }, -- Filetypes/buftypes to exclude
      -- max_length = nil, -- Max pattern length
    },
    jump = {
      jumplist = true, -- Add jumps to the jumplist
      pos = 'start', -- 'start' | 'end' | 'range'
      nohlsearch = true, -- Clear search highlight after jump
      autojump = true, -- Automatically jump if only one match
      inclusive = nil, -- Make jumps inclusive/exclusive
      offset = nil, -- Jump offset
      -- history = false, -- Add search pattern to history
      -- register = false, -- Add search pattern to search register
      -- current_line = false, -- Only search on current line
    },
    label = {
      uppercase = true, -- Allow uppercase labels
      current = true, -- Label the match under the cursor
      after = false, -- Show labels after the match
      before = true, -- Show labels before the match
      style = 'overlay', -- 'eol' | 'overlay' | 'right_align' | 'inline'
      reuse = 'lowercase', -- 'lowercase' | 'all' | 'none'
      distance = true, -- Assign labels based on distance
      min_pattern_length = 0, -- Minimum pattern length to show labels
      rainbow = {
        enabled = true,
        shade = 5,
      },
      -- exclude_chars = "", -- Characters to exclude from labels
    },
    highlight = {
      groups = {
        match = 'FlashMatch',
        current = 'FlashCurrent',
        backdrop = 'FlashBackdrop',
        label = 'FlashLabel',
      },
      -- blend_transparency = 60, -- Backdrop transparency
      -- blend_target = false, -- Blend backdrop with target window background
    },
    modes = {
      -- Default search mode (/ and ?)
      search = {
        enabled = true,
        highlight = { backdrop = true },
        jump = { history = true, register = true, nohlsearch = true },
        -- search opts are automatically configured
      },
      -- Character motion mode (f, F, t, T)
      char = {
        enabled = true,
        config = function(opts)
          -- Hide flash in operator-pending mode when yanking
          opts.autohide = opts.autohide or (vim.fn.mode(true):find('no') and vim.v.operator == 'y')
          -- Don't show jump labels when count is used or during macro execution/recording
          opts.jump_labels = opts.jump_labels
            and vim.v.count == 0
            and vim.fn.reg_executing() == ''
            and vim.fn.reg_recording() == ''
        end,
        autohide = false, -- Hide flash after jump
        jump_labels = false, -- Show jump labels for char motions
        multi_line = false, -- Only search on current line
        label = { exclude = 'hjkliardc' }, -- Exclude common motion keys from labels
        keys = { 'f', 'F', 't', 'T', ';', ',' }, -- Trigger keys
        char_actions = function(motion)
          return {
            [';'] = 'next',
            [','] = 'prev',
            [motion:lower()] = 'next',
            [motion:upper()] = 'prev',
          }
        end,
        search = { wrap = false },
        highlight = { backdrop = true },
        jump = { register = false, autojump = false },
      },
      -- Treesitter motion mode
      treesitter = {
        labels = 'abcdefghijklmnopqrstuvwxyz',
        jump = { pos = 'range', autojump = true },
        search = { incremental = false },
        label = { before = true, after = true, style = 'inline' },
        highlight = { backdrop = false, matches = false },
      },
      -- Treesitter search mode
      treesitter_search = {
        jump = { pos = 'range' },
        search = { multi_window = true, wrap = true, incremental = false },
        remote_op = { restore = true },
        label = { before = true, after = true, style = 'inline' },
      },
      -- Remote operation mode (for targeting other windows)
      remote = {
        remote_op = { restore = true, motion = true },
      },
    },
    prompt = {
      enabled = true,
      prefix = { { '⚡', 'FlashPromptIcon' } },
      win_config = {
        relative = 'editor',
        width = 1,
        height = 1,
        row = -1, -- Bottom of the editor
        col = 0,
        zindex = 1000, -- High z-index
      },
    },
    remote_op = {
      restore = false, -- Restore window view/cursor after remote op
      motion = false, -- Apply motion in target window (pos="range" disables this)
    },
    -- override = function(conf) ... end, -- Function to override config per invocation
    -- label_verifier = function(label) ... end, -- Function to verify labels
  },
  -- Define keymaps using the 'keys' table
  keys = {
    -- Default Flash keymaps (s, S, r, R are often provided by the plugin)
    -- You might want to define them explicitly here if you prefer
    -- { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash Jump" },
    -- { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
    -- { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
    -- { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },

    -- Custom keymaps from the original config
    {
      'f', -- Custom jump within current window only
      mode = 'n',
      function()
        require('flash').jump({ search = { multi_window = false } })
      end,
      desc = 'Flash Jump (Current Window)',
    },
    {
      'F', -- Custom jump across all windows
      mode = 'n',
      function()
        require('flash').jump({ search = { multi_window = true } }) -- Default behavior, but explicit
      end,
      desc = 'Flash Jump (All Windows)',
    },
    {
      't', -- Custom Treesitter jump/select
      mode = { 'n', 'x', 'o' }, -- Available in multiple modes
      function()
        require('flash').treesitter()
      end,
      desc = 'Flash Treesitter',
    },
    {
      'T', -- Custom Treesitter search
      mode = { 'o', 'x' }, -- Operator-pending and Visual modes
      function()
        require('flash').treesitter_search()
      end,
      desc = 'Flash Treesitter Search',
    },
  },
  -- No explicit config function needed if opts and keys are sufficient
  -- config = function(_, opts)
  --   require('flash').setup(opts)
  --   -- Keymaps could also be defined here
  -- end,
}
