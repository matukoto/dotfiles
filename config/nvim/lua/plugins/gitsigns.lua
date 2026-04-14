-- dot_config/nvim/lua/plugins/gitsigns.lua
return {
  'lewis6991/gitsigns.nvim',
  event = { 'BufReadPre', 'BufNewFile' }, -- Load when opening a file or creating a new one
  opts = {
    -- signs = { ... }, -- Default signs are usually fine
    -- signcolumn = true, -- Show signs in the signcolumn
    -- numhl = false, -- Don't highlight line number
    -- linehl = false, -- Don't highlight the entire line
    -- word_diff = false,
    -- watch_gitdir = { interval = 1000 },
    -- attach_to_untracked = true,
    current_line_blame = true, -- Enable current line blame
    current_line_blame_opts = {
      virt_text = true,
      virt_text_pos = 'eol', -- Show blame at the end of the line
      delay = 1000, -- Delay in ms
      ignore_whitespace = false,
    },
    current_line_blame_formatter = '<author> <author_time:%Y-%m-%d> <summary>', -- Blame format
    -- sign_priority = 6,
    -- update_debounce = 100,
    -- status_formatter = nil, -- Use default formatter
    -- max_file_length = 40000,
    -- preview_config = { ... },
    -- yadm = { enable = false },

    -- Attach function to set keymaps locally in git-controlled buffers
    on_attach = function(bufnr)
      local gs = require('gitsigns')

      local function map(mode, l, r, opts)
        opts = opts or {}
        opts.buffer = bufnr
        vim.keymap.set(mode, l, r, opts)
      end

      -- Actions
      map('n', '<C-g><', function()
        gs.stage_hunk()
      end, { desc = 'GitSigns Stage Hunk' })
      map('n', '<C-g>>', function()
        gs.undo_stage_hunk()
      end, { desc = 'GitSigns Undo Stage Hunk' })
      -- map('v', '<C-g><', function() gs.stage_hunk({vim.fn.line("."), vim.fn.line("v")}) end, { desc = 'GitSigns Stage Hunk (Visual)'}) -- Example visual mode mapping

      -- Optional mappings (uncomment if needed)
      -- map('n', '<leader>hs', gs.stage_buffer, { desc = 'GitSigns Stage Buffer' })
      -- map('n', '<leader>hu', gs.undo_stage_hunk, { desc = 'GitSigns Undo Stage Hunk' }) -- Already mapped to <C-g>>
      -- map('n', '<leader>hr', gs.reset_hunk, { desc = 'GitSigns Reset Hunk' })
      -- map('n', '<leader>hR', gs.reset_buffer, { desc = 'GitSigns Reset Buffer' })
      -- map('n', '<leader>hp', gs.preview_hunk, { desc = 'GitSigns Preview Hunk' })
      -- map('n', '<leader>hb', function() gs.blame_line({ full = true }) end, { desc = 'GitSigns Blame Line (Full)' })
      -- map('n', '<leader>tb', gs.toggle_current_line_blame, { desc = 'GitSigns Toggle Blame' })
      -- map('n', '<leader>hd', gs.diffthis, { desc = 'GitSigns Diff This' })
      -- map('n', '<leader>hD', function() gs.diffthis('~') end, { desc = 'GitSigns Diff This (~)' })
      map('n', '<leader>td', gs.toggle_deleted, { desc = 'GitSigns Toggle Deleted' })

      -- Text object
      map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>', { desc = 'GitSigns Select Hunk' })
    end,
  },
  -- Define global keymaps using the 'keys' table
  keys = {
    -- Navigation between hunks
    {
      '<C-g>j',
      function()
        if vim.wo.diff then
          return ']c'
        end
        vim.schedule(function()
          require('gitsigns').next_hunk()
        end)
        return '<Ignore>'
      end,
      expr = true,
      desc = 'GitSigns Next Hunk',
    },
    {
      '<C-g>k',
      function()
        if vim.wo.diff then
          return '[c'
        end
        vim.schedule(function()
          require('gitsigns').prev_hunk()
        end)
        return '<Ignore>'
      end,
      expr = true,
      desc = 'GitSigns Prev Hunk',
    },
  },
  -- config function to set up autocmd after plugin loads
  config = function(_, opts)
    require('gitsigns').setup(opts)

    -- Autocmd to set blame highlight color when colorscheme changes
    vim.api.nvim_create_autocmd('ColorScheme', {
      pattern = '*',
      callback = function()
        -- Ensure the highlight group exists before setting it
        if vim.fn.hlexists('GitSignsCurrentLineBlame') == 1 then
          vim.api.nvim_set_hl(0, 'GitSignsCurrentLineBlame', {
            fg = '#888888', -- Darker grey foreground for blame text
            -- bold = true, -- Optional: make it bold
            nocombine = true, -- Don't combine with other highlights
          })
        else
          -- Fallback or notification if the group doesn't exist yet
          -- vim.notify("GitSignsCurrentLineBlame highlight group not found yet.", vim.log.levels.WARN)
        end
      end,
    })
    -- Initial highlight setting in case ColorScheme event doesn't fire immediately
    if vim.fn.hlexists('GitSignsCurrentLineBlame') == 1 then
      vim.api.nvim_set_hl(0, 'GitSignsCurrentLineBlame', { fg = '#888888', nocombine = true })
    end
  end,
}
