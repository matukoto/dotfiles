-- dot_config/nvim/lua/plugins/quicker.lua
return {
  'stevearc/quicker.nvim',
  -- Load lazily, triggered by command or keymap
  cmd = { 'QuickerToggle' },
  event = 'VeryLazy',
  -- opts table passes configuration directly to setup()
  opts = {
    -- Keymaps specific to the quickfix buffer
    keys = {
      {
        '>',
        function()
          require('quicker').expand({ before = 2, after = 2, add_to_existing = true })
        end,
        desc = 'Expand quickfix context',
      },
      {
        '<',
        function()
          require('quicker').collapse()
        end,
        desc = 'Collapse quickfix context',
      },
      -- Add other quickfix-specific keymaps here if needed
    },
    -- Local options for the quickfix buffer
    opts = {
      buflisted = false,
      number = false,
      relativenumber = false,
      signcolumn = 'auto',
      winfixheight = true,
      wrap = false,
    },
    use_default_opts = true, -- Use the default options defined above
    on_qf = function(bufnr) end, -- Callback for custom logic/keymaps in qf buffer
    edit = {
      enabled = true, -- Allow editing quickfix buffer
      autosave = 'unmodified', -- Autosave unmodified buffers after edits
    },
    constrain_cursor = true, -- Keep cursor on editable parts
    highlight = {
      treesitter = true, -- Use Treesitter highlighting
      lsp = true, -- Use LSP semantic token highlighting
      load_buffers = false, -- Don't load referenced buffers for highlighting (faster)
    },
    follow = {
      enabled = false, -- Don't scroll quickfix to follow cursor
    },
    type_icons = { -- Icons for diagnostic types
      E = '󰅚 ', -- Error
      W = '󰀪 ', -- Warning
      I = ' ', -- Info
      N = ' ', -- Note (using Info icon)
      H = ' ', -- Hint (using Info icon)
    },
    borders = { -- Border characters for context lines
      vert = '┃',
      strong_header = '━',
      strong_cross = '╋',
      strong_end = '┫',
      soft_header = '╌',
      soft_cross = '╂',
      soft_end = '┨',
    },
    trim_leading_whitespace = 'common', -- Trim common leading whitespace
    max_filename_width = function()
      return math.floor(math.min(95, vim.o.columns / 2))
    end,
    header_length = function(type, start_col)
      return vim.o.columns - start_col
    end,
  },
  -- Define global keymaps using the 'keys' table
  keys = {
    {
      '<leader>q',
      function()
        require('quicker').toggle()
      end,
      desc = 'Toggle Quickfix List (Quicker)',
    },
    -- Example for loclist (uncomment if needed)
    -- {
    --   "<leader>Q", -- Use Shift+Q for loclist example
    --   function() require("quicker").toggle({ loclist = true }) end,
    --   desc = "Toggle Location List (Quicker)",
    -- },
  },
  -- No explicit config function needed if opts and keys are sufficient
  -- config = function(_, opts)
  --   require('quicker').setup(opts)
  --   -- Global keymaps could also be defined here
  -- end,
}
