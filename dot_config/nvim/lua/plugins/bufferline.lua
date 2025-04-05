-- dot_config/nvim/lua/plugins/bufferline.lua
return {
  'akinsho/bufferline.nvim',
  -- Load after UI elements are ready or when a buffer is opened
  event = 'VeryLazy',
  -- Dependencies like devicons should be listed elsewhere but good to note
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  -- opts table passes configuration directly to setup()
  opts = {
    options = {
      -- 'buffers' | 'tabs'
      mode = 'buffers',
      -- style_preset = bufferline.style_preset.default, -- Use default preset
      -- themable = true, -- Allow highlight groups to be overriden
      -- numbers = "none" | "ordinal" | "buffer_id" | "both" | function({ ordinal, id, lower }): string,
      -- close_command = "bdelete! %d", -- Command to close buffer
      -- right_mouse_command = "bdelete! %d", -- Command for right mouse button
      -- left_mouse_command = "buffer %d", -- Command for left mouse button
      -- middle_mouse_command = nil, -- Command for middle mouse button
      indicator = {
        -- icon = '▎', -- Indicator icon
        style = 'underline', -- 'icon' | 'underline' | 'none'
      },
      -- buffer_close_icon = '󰅖',
      -- modified_icon = '●',
      -- close_icon = '',
      -- left_trunc_marker = '',
      -- right_trunc_marker = '',
      -- max_name_length = 18,
      -- max_prefix_length = 15, -- prefix used when a buffer is de-duplicated
      -- truncate_names = true, -- Truncate buffer names
      -- tab_size = 18,
      diagnostics = 'nvim_lsp', -- "nvim_lsp" | "coc" | false
      diagnostics_update_in_insert = false,
      -- diagnostics_indicator = function(count, level, diagnostics_dict, context) ... end,
      -- offsets = { { filetype = "NvimTree", text = "File Explorer", text_align = "left" } }, -- Example offset
      show_buffer_icons = true, -- Show devicons
      show_buffer_close_icons = true,
      show_close_icon = true,
      show_tab_indicators = true,
      show_duplicate_prefix = true, -- Show prefix for duplicated file names
      -- persist_buffer_sort = true, -- Preserve buffer sorting order
      -- separator_style = "thin" | "thick" | "slant" | "padded_slant"
      separator_style = 'slant',
      enforce_regular_tabs = false, -- Disallow irregular tab widths
      always_show_bufferline = true, -- Keep bufferline visible even with only one buffer
      -- hover = { enabled = true, delay = 200, reveal = {'close'} },
      -- sort_by = 'id' | 'extension' | 'relative_directory' | 'directory' | 'tabs' | function(buffer_a, buffer_b) ... end,
    },
  },
  -- Define keymaps using the 'keys' table
  keys = {
    -- Navigate buffers
    { '[b', '<cmd>BufferLineCyclePrev<cr>', desc = 'Prev Buffer' },
    { ']b', '<cmd>BufferLineCycleNext<cr>', desc = 'Next Buffer' },
    { '<leader>bp', '<cmd>BufferLineTogglePin<cr>', desc = 'Toggle Pin Buffer' },
    { '<leader>bP', '<cmd>BufferLineGroupClose ungrouped<cr>', desc = 'Close Unpinned Buffers' },
    { '<leader>bo', '<cmd>BufferLineCloseOthers<cr>', desc = 'Close Other Buffers' },
    { '<leader>br', '<cmd>BufferLineCloseRight<cr>', desc = 'Close Buffers to the Right' },
    { '<leader>bl', '<cmd>BufferLineCloseLeft<cr>', desc = 'Close Buffers to the Left' },
    -- You can also map buffer numbers directly if desired
    -- { "<leader>1", "<cmd>BufferLineGoToBuffer 1<cr>", desc = "Go to Buffer 1" },
    -- { "<leader>2", "<cmd>BufferLineGoToBuffer 2<cr>", desc = "Go to Buffer 2" },
    -- ... and so on
  },
  -- No explicit config function needed if opts and keys are sufficient
  -- config = function(_, opts)
  --   require('bufferline').setup(opts)
  --   -- Keymaps could also be defined here
  -- end,
}
