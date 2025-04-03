-- dot_config/nvim/lua/plugins/comment.lua
return {
  'numToStr/Comment.nvim',
  -- Load lazily, usually on keypress or specific events.
  -- 'VeryLazy' is a safe default, or you could use `keys` to trigger loading.
  event = "VeryLazy",
  -- opts table directly passes configuration to the setup function
  opts = {
    -- Add space b/w comment and the line
    padding = true,
    -- Whether the cursor should stay at its position
    sticky = true,
    -- Lines to ignore detecting buffer boundaries
    ignore = nil,
    -- LHS of toggle mappings in NORMAL mode
    toggler = {
      -- Line-comment toggle keymap
      line = 'gcc',
      -- Block-comment toggle keymap
      block = 'gbc',
    },
    -- LHS of operator-pending mappings in NORMAL and VISUAL mode
    opleader = {
      -- Line-comment keymap
      line = 'gc',
      -- Block-comment keymap
      block = 'gb',
    },
    -- LHS of extra mappings
    extra = {
      -- Add comment on the line above
      above = 'gcO',
      -- Add comment on the line below
      below = 'gco',
      -- Add comment at the end of line
      eol = 'gcA',
    },
    -- Enable keybindings
    -- NOTE: If you set `mappings = false` you will have to create mappings yourself which
    -- is useful if you want to define your own keymaps
    mappings = {
      -- Operator-pending mapping; `gcc` and `gbc` toggle mapping like `gc G` and `gb G`
      basic = true,
      -- Extra mapping; `gco`, `gcO`, `gcA`
      extra = true,
      -- Extended mapping; `g>`, `g<`, `g;`
      -- extended = false,
    },
    -- Function to call before (un)comment
    pre_hook = nil,
    -- Function to call after (un)comment
    post_hook = nil,
  },
  -- No explicit config function needed if opts is sufficient
  -- config = function(_, opts)
  --   require('Comment').setup(opts)
  -- end,
}
