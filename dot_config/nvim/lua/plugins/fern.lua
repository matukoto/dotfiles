-- dot_config/nvim/lua/plugins/fern.lua
-- Configuration for fern.vim file explorer
return {
  'lambdalisue/vim-fern', -- Core fern plugin
  -- Explicitly define dependencies here
  dependencies = {
    'yuki-yano/fern-preview.vim',
    'lambdalisue/vim-fern-git-status',
    'lambdalisue/vim-fern-hijack',
    'lambdalisue/vim-nerdfont', -- Required by renderer
    'lambdalisue/vim-fern-renderer-nerdfont',
  },
  -- Load fern itself early to ensure its variables are set for dependencies
  cmd = { 'Fern' }, -- Can still be triggered by command
  lazy = false, -- Ensure fern loads before dependencies try to access its vars
  -- init function to set global variables before fern or its dependencies load
  init = function()
    -- Show hidden files by default
    vim.g['fern#default_hidden'] = 1
    -- Disable default keymappings
    vim.g['fern#disable_default_mappings'] = 1
  end,
  -- Define global keymaps using the 'keys' table
  keys = {
    { '<Leader>E', '<Cmd>Fern . -drawer<CR>', desc = 'Open Fern Drawer' },
    { '<Leader>e', '<Cmd>Fern . -reveal=%<CR>', desc = 'Open Fern (Reveal Current)' },
    { '<Leader>ce', '<Cmd>Fern %:h<CR>', desc = 'Open Fern (Current Dir)' },
  },
  -- config function to define autocmds after loading
  config = function()
    -- Define the function for fern buffer settings
    local function fern_settings()
      local map = vim.keymap.set
      local buffer_opts = { silent = true, buffer = true }

      -- File operations
      map('n', '<C-d>', '<Plug>(fern-action-remove=)y<CR>', buffer_opts) -- Delete (confirm with y)
      map('n', 'F', '<Plug>(fern-action-new-file)', buffer_opts) -- New file
      map('n', 'D', '<Plug>(fern-action-new-dir)', buffer_opts) -- New directory
      map('n', 'R', '<Plug>(fern-action-rename:vsplit)', buffer_opts) -- Rename

      -- Navigation
      map('n', 'h', '<Plug>(fern-action-leave)', buffer_opts) -- Go up
      map('n', 'l', '<Plug>(fern-action-expand)', buffer_opts) -- Go down/expand

      -- Open files
      map('n', '<CR>', '<Plug>(fern-action-open)', buffer_opts) -- Open in current window
      map('n', '<C-v>', '<Plug>(fern-action-open:vsplit)', buffer_opts) -- Open in vsplit
      map('n', '<C-l>', '<Plug>(fern-action-open:split)', buffer_opts) -- Open in split (Note: <C-l> might conflict)
      map('n', '<C-t>', '<Plug>(fern-action-open:tabedit)', buffer_opts) -- Open in tab

      -- View settings
      map('n', '!', '<Plug>(fern-action-hidden:toggle)', buffer_opts) -- Toggle hidden files

      -- Preview
      map('n', 'p', '<Plug>(fern-action-preview:toggle)', buffer_opts) -- Toggle preview
      map('n', '<C-p>', '<Plug>(fern-action-preview:auto:toggle)', buffer_opts) -- Toggle auto preview

      -- Clipboard
      map('n', 'yp', '<Plug>(fern-action-yank:path)', buffer_opts) -- Yank path
      map('n', 'yf', '<Plug>(fern-action-yank:label)', buffer_opts) -- Yank filename

      -- Quit/Close
      -- Use pcall for safety as fern_preview might not be loaded
      local quit_expr = function()
        local ok, fp = pcall(require, 'fern_preview')
        if ok and fp then
          return fp.smart_preview('<Plug>(fern-action-preview:close)', ':q<CR>')
        else
          -- Fallback if preview plugin isn't available
          return ':q<CR>'
        end
      end
      map('n', '<ESC>', quit_expr, { buffer = true, expr = true, silent = true })
      map('n', 'q', quit_expr, { buffer = true, expr = true, silent = true })
    end

    -- Apply settings to fern buffers
    vim.api.nvim_create_autocmd('FileType', {
      pattern = 'fern',
      callback = fern_settings,
      group = vim.api.nvim_create_augroup('FernSettings', { clear = true }),
    })
  end,
}
