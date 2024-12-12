require('flash').setup({
  -- 検索時のラベル
  labels = 'asdfghjklqwertyuiopzxcvbnm',
  search = {
    -- ウィンドウをまたいでの検索
    multi_window = true,
    forward = true,
    -- false のときは方向を決めて検索する (ex: f ▼後方検索, F ▲後方検索)
    wrap = true,
    -- fuzzy, exact, search
    mode = 'exact',
    incremental = false,
  },
  jump = {
    -- ジャンプリストに登録する
    jumplist = true,
    -- ジャンプ位置
    pos = 'start', ---@type "start" | "end" | "range"
    -- clear highlight after jump
    nohearch = true,
    -- automatically jump when there is only one match
    autojump = true,
    -- You can force inclusive/exclusive jumps by setting the
    -- `inclusive` option. By default it will be automatically
    -- set based on the mode.
    inclusive = nil, ---@type boolean?
    -- jump position offset. Not used for range jumps.
    -- 0: default
    -- 1: when pos == "end" and pos < current position
    offset = nil, ---@type number
  },
  label = {
    -- allow uppercase labels
    uppercase = true,
    current = true,
    after = false, ---@type boolean|number[]
    -- show the label before the match
    before = true, ---@type boolean|number[]
    -- ラベル位置
    style = 'overlay', ---@type "eol" | "overlay" | "right_align" | "inline"
    -- flash tries to re-use labels that were already assigned to a position,
    -- when typing more characters. By default only lower-case labels are re-used.
    reuse = 'lowercase', ---@type "lowercase" | "all" | "none"
    -- for the current window, label targets closer to the cursor first
    distance = true,
    -- minimum pattern length to show labels
    -- Ignored for custom labelers.
    min_pattern_length = 0,
    -- Enable this to use rainbow colors to highlight labels
    -- Can be useful for visualizing Treesitter ranges.
    rainbow = {
      enabled = true,
      -- number between 1 and 9
      shade = 5,
    },
  },
  highlight = {
    groups = {
      match = 'FlashMatch',
      current = 'FlashCurrent',
      backdrop = 'FlashBackdrop',
      label = 'FlashLabel',
    },
  },
  -- Use it with `require("flash").jump({mode = "forward"})`
  ---@type table<string, Flash.Config>
  modes = {
    -- options used when flash is activated through
    -- a regular search with `/` or `?`
    search = {
      -- when `true`, flash will be activated during regular search by default.
      -- You can always toggle when searching with `require("flash").toggle()`
      enabled = true,
      highlight = { backdrop = true },
      jump = { history = true, register = true, nohlsearch = true },
      search = {
        -- `forward` will be automatically set to the search direction
        -- `mode` is always set to `search`
        -- `incremental` is set to `true` when `incsearch` is enabled
      },
    },
    -- options used when flash is activated through
    -- `f`, `F`, `t`, `T`, `;` and `,` motions
    char = {
      enabled = true,
      -- dynamic configuration for ftFT motions
      config = function(opts)
        -- autohide flash when in operator-pending mode
        opts.autohide = opts.autohide or (vim.fn.mode(true):find('no') and vim.v.operator == 'y')

        -- disable jump labels when not enabled, when using a count,
        -- or when recording/executing registers
        opts.jump_labels = opts.jump_labels
          and vim.v.count == 0
          and vim.fn.reg_executing() == ''
          and vim.fn.reg_recording() == ''

        -- Show jump labels only in operator-pending mode
        -- opts.jump_labels = vim.v.count == 0 and vim.fn.mode(true):find("o")
      end,
      -- hide after jump when not using jump labels
      autohide = false,
      -- show jump labels
      jump_labels = false,
      -- set to `false` to use the current line only
      multi_line = true,
      -- When using jump labels, don't use these keys
      -- This allows using those keys directly after the motion
      label = { exclude = 'hjkliardc' },
      -- by default all keymaps are enabled, but you can disable some of them,
      -- by removing them from the list.
      -- If you rather use another key, you can map them
      -- to something else, e.g., { [";"] = "L", [","] = H }
      keys = { 'f', 'F', 't', 'T', ';', ',' },
      ---@alias Flash.CharActions table<string, "next" | "prev" | "right" | "left">
      -- The direction for `prev` and `next` is determined by the motion.
      -- `left` and `right` are always left and right.
      char_actions = function(motion)
        return {
          [';'] = 'next', -- set to `right` to always go right
          [','] = 'prev', -- set to `left` to always go left
          -- clever-f style
          [motion:lower()] = 'next',
          [motion:upper()] = 'prev',
          -- jump2d style: same case goes next, opposite case goes prev
          -- [motion] = "next",
          -- [motion:match("%l") and motion:upper() or motion:lower()] = "prev",
        }
      end,
      search = { wrap = false },
      highlight = { backdrop = true },
      jump = {
        register = false,
        -- when using jump labels, set to 'true' to automatically jump
        -- or execute a motion when there is only one match
        autojump = false,
      },
    },
    -- options used for treesitter selections
    -- `require("flash").treesitter()`
    treesitter = {
      labels = 'abcdefghijklmnopqrstuvwxyz',
      jump = { pos = 'range', autojump = true },
      search = { incremental = false },
      label = { before = true, after = true, style = 'inline' },
      highlight = {
        backdrop = false,
        matches = false,
      },
    },
    treesitter_search = {
      jump = { pos = 'range' },
      search = { multi_window = true, wrap = true, incremental = false },
      remote_op = { restore = true },
      label = { before = true, after = true, style = 'inline' },
    },
    -- options used for remote flash
    remote = {
      remote_op = { restore = true, motion = true },
    },
  },
  -- options for the floating window that shows the prompt,
  -- for regular jumps
  -- `require("flash").prompt()` is always available to get the prompt text
  prompt = {
    enabled = true,
    prefix = { { '⚡', 'FlashPromptIcon' } },
    win_config = {
      relative = 'editor',
      width = 1, -- when <=1 it's a percentage of the editor width
      height = 1,
      row = -1, -- when negative it's an offset from the bottom
      col = 0, -- when negative it's an offset from the right
      zindex = 1000,
    },
  },
  -- options for remote operator pending mode
  remote_op = {
    -- restore window views and cursor position
    -- after doing a remote operation
    restore = false,
    -- For `jump.pos = "range"`, this setting is ignored.
    -- `true`: always enter a new motion when doing a remote operation
    -- `false`: use the window's cursor position and jump target
    -- `nil`: act as `true` for remote windows, `false` for the current window
    motion = false,
  },
})

vim.keymap.set('n', 'f', function()
  require('flash').jump({
    search = { forward = true, wrap = true, multi_window = false },
  })
end)

vim.keymap.set('n', 'F', function()
  require('flash').jump({
    search = { forward = false, wrap = false, multi_window = false },
  })
end)

vim.keymap.set('n', 's', function()
  require('flash').jump()
end)

vim.keymap.set('n', 't', function()
  require('flash').treesitter()
end)

vim.keymap.set('n', 'T', function()
  require('flash').treesitter_search()
end)
