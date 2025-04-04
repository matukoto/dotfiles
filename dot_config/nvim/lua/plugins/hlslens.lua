-- dot_config/nvim/lua/plugins/hlslens.lua
return {
  'kevinhwang91/nvim-hlslens',
  -- Dependencies: Integrates with vim-asterisk
  dependencies = { 'haya14busa/vim-asterisk' },
  -- Load lazily, triggered by search keymaps
  event = 'VeryLazy',
  -- opts table for hlslens specific configuration (using defaults here)
  opts = {
    -- Default options are generally good, customize if needed
    -- nearest_only = true,
    -- nearest_float_when = 'always', -- 'always', 'auto', 'never'
    -- calced_window_vivibility = true,
    -- build_position_cb = function(lens, nearest, idx, rel_idx) ... end,
  },
  -- Define keymaps using the 'keys' table
  -- These keymaps will automatically load the plugin when triggered
  keys = {
    {
      'n',
      -- Execute normal mode 'n' command and then start hlslens
      function()
        vim.cmd('execute("normal! " .. v:count1 .. "n")')
        -- Use pcall for safety in keymaps
        local ok, hlslens = pcall(require, 'hlslens')
        if ok then
          hlslens.start()
        end
      end,
      desc = 'Next Search Result (Hlslens)',
    },
    {
      'N',
      -- Execute normal mode 'N' command and then start hlslens
      function()
        vim.cmd('execute("normal! " .. v:count1 .. "N")')
        local ok, hlslens = pcall(require, 'hlslens')
        if ok then
          hlslens.start()
        end
      end,
      desc = 'Previous Search Result (Hlslens)',
    },
    -- vim-asterisk integration mappings
    {
      '*',
      -- Trigger asterisk search and then start hlslens
      function()
        vim.cmd([[normal! <Plug>(asterisk-z*)]])
        local ok, hlslens = pcall(require, 'hlslens')
        if ok then
          hlslens.start()
        end
      end,
      mode = 'n',
      desc = 'Search Word Forward (Hlslens)',
    },
    {
      '#',
      function()
        vim.cmd([[normal! <Plug>(asterisk-z#)]])
        local ok, hlslens = pcall(require, 'hlslens')
        if ok then
          hlslens.start()
        end
      end,
      mode = 'n',
      desc = 'Search Word Backward (Hlslens)',
    },
    {
      'g*',
      function()
        vim.cmd([[normal! <Plug>(asterisk-gz*)]])
        local ok, hlslens = pcall(require, 'hlslens')
        if ok then
          hlslens.start()
        end
      end,
      mode = 'n',
      desc = 'Search Word Forward (Partial) (Hlslens)',
    },
    {
      'g#',
      function()
        vim.cmd([[normal! <Plug>(asterisk-gz#)]])
        local ok, hlslens = pcall(require, 'hlslens')
        if ok then
          hlslens.start()
        end
      end,
      mode = 'n',
      desc = 'Search Word Backward (Partial) (Hlslens)',
    },
    -- Visual mode mappings
    {
      '*',
      function()
        vim.cmd([[<Plug>(asterisk-z*)]]) -- Let vim-asterisk handle visual selection
        local ok, hlslens = pcall(require, 'hlslens')
        if ok then
          hlslens.start()
        end
      end,
      mode = 'x',
      desc = 'Search Visual Selection Forward (Hlslens)',
    },
    {
      '#',
      function()
        vim.cmd([[<Plug>(asterisk-z#)]])
        local ok, hlslens = pcall(require, 'hlslens')
        if ok then
          hlslens.start()
        end
      end,
      mode = 'x',
      desc = 'Search Visual Selection Backward (Hlslens)',
    },
    {
      'g*',
      function()
        vim.cmd([[<Plug>(asterisk-gz*)]])
        local ok, hlslens = pcall(require, 'hlslens')
        if ok then
          hlslens.start()
        end
      end,
      mode = 'x',
      desc = 'Search Visual Selection Forward (Partial) (Hlslens)',
    },
    {
      'g#',
      function()
        vim.cmd([[<Plug>(asterisk-gz#)]])
        local ok, hlslens = pcall(require, 'hlslens')
        if ok then
          hlslens.start()
        end
      end,
      mode = 'x',
      desc = 'Search Visual Selection Backward (Partial) (Hlslens)',
    },
  },
  -- config function can be used if setup needs more complex logic
  config = function(_, opts)
    require('hlslens').setup(opts)
    -- Additional configuration or setup steps can go here
  end,
}
