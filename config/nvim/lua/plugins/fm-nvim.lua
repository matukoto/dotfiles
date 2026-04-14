-- dot_config/nvim/lua/plugins/fm-nvim.lua
return {
  'matukoto/fm-nvim',
  -- Load lazily, triggered by commands or keymaps
  cmd = {
    'Gitui',
    'Lazygit', -- Add other commands if enabled below
    -- "Lf", "Fm", "Nnn", "Fff", "Twf", "Fzf", "Fzy", "Xplr", "Vifm", "Skim", "Broot", "Ranger", "Joshuto", "Neomutt", "Taskwarrior"
  },
  event = 'VeryLazy',
  -- opts table passes configuration directly to setup()
  opts = {
    edit_cmd = 'edit', -- Command to open file
    on_close = {}, -- Callback on close
    on_open = {}, -- Callback on open
    ui = {
      default = 'float', -- 'split' or 'float'
      float = {
        border = 'none', -- 'none', 'single', 'double', 'rounded', etc.
        float_hl = 'Normal',
        border_hl = 'FloatBorder',
        blend = 0,
        height = 1, -- Ratio (0-1)
        width = 1, -- Ratio (0-1)
        x = 0.7, -- Position (ratio)
        y = 0.7, -- Position (ratio)
      },
      split = {
        direction = 'topleft',
        size = 24,
      },
    },
    -- Enabled terminal commands (ensure they are in $PATH)
    cmds = {
      gitui_cmd = 'gitui',
      lazygit_cmd = 'lazygit',
      -- Uncomment other commands if needed and installed
      -- lf_cmd = 'lf',
      -- fm_cmd = 'fm',
      -- nnn_cmd = 'nnn',
      -- fff_cmd = 'fff',
      -- twf_cmd = 'twf',
      -- fzf_cmd = 'fzf',
      -- fzy_cmd = 'find . | fzy',
      -- xplr_cmd = 'xplr',
      -- vifm_cmd = 'vifm',
      -- skim_cmd = 'sk',
      -- broot_cmd = 'broot',
      -- ranger_cmd = 'ranger',
      -- joshuto_cmd = 'joshuto',
      -- neomutt_cmd = 'neomutt',
      -- taskwarrior_cmd = 'taskwarrior-tui',
    },
    -- Key mappings within the fm-nvim window
    mappings = {
      vert_split = '<C-v>',
      horz_split = '<C-h>',
      tabedit = '<C-t>',
      edit = '<C-e>',
      ESC = '<ESC>',
    },
    -- broot_conf = vim.fn.stdpath('data') .. '/site/pack/lazy/opt/fm-nvim/assets/broot_conf.hjson', -- Adjust path if needed for lazy.nvim structure
  },
  -- config function to define commands after setup
  config = function(_, opts)
    require('fm-nvim').setup(opts)
    -- Define command abbreviation after setup
    vim.cmd('cabbrev G Gitui')
    -- Add other abbreviations if needed
    -- vim.cmd('cabbrev Lg Lazygit')
  end,
}
