require('blink.cmp').setup({
  -- Enables keymaps, completions and signature help when true (doesn't apply to cmdline or term)
  --
  -- If the function returns 'force', the default conditions for disabling the plugin will be ignored
  -- Default conditions: (vim.bo.buftype ~= 'prompt' and vim.b.completion ~= false)
  -- Note that the default conditions are ignored when `vim.b.completion` is explicitly set to `true`
  --
  -- Exceptions: vim.bo.filetype == 'dap-repl'
  -- enabled = function()
  --   return not vim.tbl_contains({ 'lua', 'markdown' }, vim.bo.filetype)
  -- end,
  keymap = {
    preset = 'default',
    ['<C-j>'] = { 'select_and_accept', 'fallback' },
  },
  -- Disable cmdline
  cmdline = {
    enabled = true,
    -- keymap = {
    --   preset = 'default',
    --   ['<CR>'] = { 'accept_and_enter', 'fallback' },
    --   ['<C-j>'] = { 'select_and_accept', 'fallback' },
    -- },
  },
  completion = {
    -- 'prefix' will fuzzy match on the text before the cursor
    -- 'full' will fuzzy match on the text before _and_ after the cursor
    -- example: 'foo_|_bar' will match 'foo_' for 'prefix' and 'foo__bar' for 'full'
    keyword = { range = 'full' },

    -- Disable auto brackets
    -- NOTE: some LSPs may add auto brackets themselves anyway
    accept = { auto_brackets = { enabled = true } },

    -- Don't select by default, auto insert on selection
    list = { selection = { preselect = true, auto_insert = true } },
    -- or set via a function
    menu = {
      -- Don't automatically show the completion menu
      auto_show = true,

      -- nvim-cmp style menu
      draw = {
        columns = {
          { 'label', 'label_description', gap = 1 },
          { 'kind_icon', 'kind' },
        },
      },
    },

    -- Show documentation when selecting a completion item
    documentation = { auto_show = true, auto_show_delay_ms = 1000 },

    -- Display a preview of the selected item on the current line
    ghost_text = { enabled = true },
  },

  sources = {
    -- Remove 'buffer' if you don't want text completions, by default it's only enabled when LSP returns no items
    default = { 'lsp', 'path', 'snippets', 'buffer' },
  },

  -- Use a preset for snippets, check the snippets documentation for more information
  snippets = { preset = 'default' },

  -- Experimental signature help support
  signature = { enabled = true },
  fuzzy = { implementation = 'lua' },
})
