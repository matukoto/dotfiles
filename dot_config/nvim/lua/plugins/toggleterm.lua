-- dot_config/nvim/lua/plugins/toggleterm.lua
return {
  'akinsho/toggleterm.nvim',
  -- version = "*", -- Uncomment and specify version if needed, e.g., version = "v2.9.0"
  -- opts will be passed to require('toggleterm').setup()
  opts = {
    size = function(term)
      if term.direction == 'horizontal' then
        return 15
      elseif term.direction == 'vertical' then
        return vim.o.columns * 0.4
      end
    end,
    open_mapping = [[<c-\>]], -- Use double brackets for control keys
    -- on_create = function(t) ... end,
    on_open = function(term) -- function to run when the terminal opens
      -- Set keymap specific to the terminal buffer
      vim.api.nvim_buf_set_keymap(
        term.bufnr,
        'n', -- Use 't' for terminal mode mapping if preferred, 'n' works too
        '<Esc>',
        '<cmd>close<CR>', -- Close the terminal window with Esc in normal mode
        { noremap = true, silent = true, desc = 'Close terminal window' }
      )
      -- Optional: Map Esc in terminal mode to exit insert and then close
      -- vim.api.nvim_buf_set_keymap(term.bufnr, 't', '<Esc>', '<C-\\><C-n><cmd>close<CR>', {noremap = true, silent = true})
    end,
    -- on_close = function(t) ... end,
    -- on_stdout = function(t, job, data, name) ... end,
    -- on_stderr = function(t, job, data, name) ... end,
    -- on_exit = function(t, job, exit_code, name) ... end,
    -- hide_numbers = true,
    -- shade_filetypes = {},
    -- autochdir = false,
    -- highlights = { Normal = { ... }, NormalFloat = { ... }, FloatBorder = { ... } },
    -- shade_terminals = true,
    -- shading_factor = -30,
    start_in_insert = true,
    -- insert_mappings = true, -- Open mapping applies in insert mode
    -- terminal_mappings = true, -- Open mapping applies in terminal mode
    persist_size = true,
    persist_mode = true, -- Remember previous terminal mode
    direction = 'float', -- Default direction
    close_on_exit = true, -- Close window when process exits
    -- clear_env = false,
    -- shell = vim.o.shell, -- Use default shell
    env = {
      TERM_PROGRAM = 'toggleterm', -- Identify the terminal program
    },
    auto_scroll = true, -- Scroll to bottom on output
    float_opts = {
      -- Border style for floating terminal
      border = 'single', -- 'double', 'rounded', 'shadow', 'curved'
      -- winblend = 3,
      -- width = <value>,
      -- height = <value>,
      -- row = <value>,
      -- col = <value>,
      -- zindex = <value>,
      -- title_pos = 'center',
    },
    -- winbar = { enabled = false, name_formatter = function(term) return term.name end },
  },
  -- Define keymaps using the 'keys' table for lazy.nvim
  keys = {
    -- Toggle terminal mapping
    { '<Leader>u', '<cmd>ToggleTerm<CR>', desc = 'Toggle Terminal' },
    -- You can add more terminal related mappings here
    -- Example: Toggle specific terminal types
    -- { "<leader>ut", "<cmd>ToggleTerm direction=tab<CR>", desc = "Toggle Terminal (Tab)" },
    -- { "<leader>uf", "<cmd>ToggleTerm direction=float<CR>", desc = "Toggle Terminal (Float)" },
    -- { "<leader>uv", "<cmd>ToggleTerm direction=vertical size=80<CR>", desc = "Toggle Terminal (Vertical)" },
    -- { "<leader>uh", "<cmd>ToggleTerm direction=horizontal size=15<CR>", desc = "Toggle Terminal (Horizontal)" },
  },
  -- No explicit config function needed if opts and keys are sufficient
  -- config = function(_, opts)
  --   require('toggleterm').setup(opts)
  --   -- Keymaps could also be defined here instead of using the 'keys' table
  --   -- vim.keymap.set('n', '<Leader>u', '<cmd>ToggleTerm<CR>', { desc = 'Toggle Terminal' })
  -- end,
}
