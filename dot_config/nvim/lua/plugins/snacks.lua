-- dot_config/nvim/lua/plugins/snacks.lua
-- Enhanced buffer/process management with a picker UI
return {
  'folke/snacks.nvim',
  -- Dependencies: Telescope is often used as the picker backend
  dependencies = { 'nvim-telescope/telescope.nvim' },
  -- Load lazily, triggered by commands or keymaps
  cmd = { 'SnacksOpen', 'SnacksClose', 'SnacksHide', 'SnacksShow', 'SnacksPicker' },
  event = 'VeryLazy',
  -- opts table passes configuration directly to setup()
  opts = {
    -- Configure the picker UI (likely Telescope)
    picker = {
      layout = {
        preset = 'dropdown', -- Use dropdown layout
        layout = {
          width = 0.8,
          min_width = 100,
          height = 0.9,
        },
      },
      win = {
        input = {
          -- Customize keymaps within the picker input window
          keys = {
            ['<c-a>'] = false, -- Disable select all
            ['<c-b>'] = false,
            ['<c-d>'] = { 'preview_scroll_down', mode = { 'i', 'n' } },
            ['<c-f>'] = false,
            ['<c-u>'] = { 'preview_scroll_up', mode = { 'i', 'n' } },
            ['<c-s>'] = false,
            ['<c-x>'] = { 'edit_split', mode = { 'i', 'n' } }, -- Edit in split
            -- Add other picker keymaps if needed
          },
        },
        -- Configure other picker window aspects if needed
        -- results = { ... },
        -- preview = { ... },
        -- prompt = { ... },
      },
    },
    -- Configure other snacks options if needed
    -- e.g., process management, notifications
  },
  -- Define global keymaps using the 'keys' table
  keys = {
    {
      '<leader>b', -- Original keymap for buffer picker
      function()
        -- Ensure snacks is loaded before calling picker
        local ok, snacks = pcall(require, 'snacks')
        if ok then
          snacks.picker.buffers()
        else
          vim.notify('snacks.nvim not loaded.', vim.log.levels.WARN)
        end
      end,
      desc = 'Pick Buffers (Snacks)',
    },
    {
      '<leader>k', -- Original keymap for kensaku picker
      function()
        local snacks_ok, snacks = pcall(require, 'snacks')
        if not snacks_ok then
          vim.notify('snacks.nvim not loaded.', vim.log.levels.WARN)
          return
        end
        -- Attempt to load the custom kensaku source
        -- Assuming the path 'plugins/snacks/sources/kensaku' is relative to lua/
        local kensaku_source_ok, kensaku_source = pcall(require, 'plugins.snacks.sources.kensaku')
        if kensaku_source_ok then
          -- Register the source dynamically if needed (check snacks docs for best practice)
          -- This might need to be done in the config function instead for reliability
          local sources_ok, sources = pcall(require, 'snacks.picker.config.sources')
          if sources_ok then
            sources.kensaku = kensaku_source
            snacks.picker.kensaku()
          else
            vim.notify('Failed to access snacks sources.', vim.log.levels.WARN)
          end
        else
          vim.notify('Failed to load custom kensaku source.', vim.log.levels.WARN)
        end
      end,
      desc = 'Pick Kensaku (Snacks)',
    },
  },
  -- config function can be used for setup that requires the plugin to be loaded
  -- config = function(_, opts)
  --   require('snacks').setup(opts)
  --   -- It might be more robust to register the kensaku source here:
  --   -- local kensaku_source_ok, kensaku_source = pcall(require, 'plugins.snacks.sources.kensaku')
  --   -- if kensaku_source_ok then
  --   --   require('snacks.picker.config.sources').kensaku = kensaku_source
  --   -- end
  -- end,
}
