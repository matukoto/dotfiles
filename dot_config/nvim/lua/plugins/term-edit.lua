-- dot_config/nvim/lua/plugins/term-edit.lua
-- Edit terminal commands in a separate buffer
return {
  'chomosuke/term-edit.nvim',
  -- Load when needed, likely triggered by a command or keymap
  cmd = { 'TermEdit' },
  event = 'VeryLazy',
  -- opts table passes configuration directly to setup()
  opts = {
    -- Prompt end pattern to detect command line end
    prompt_end = '%$ ', -- Default is '%# ', adjust if your shell prompt differs
    -- Other options can be added here if needed
    -- e.g., highlight = true, filetype = "sh"
  },
  -- Define keymaps using the 'keys' table (optional)
  -- keys = {
  --   { "<leader>te", "<cmd>TermEdit<cr>", desc = "Edit Terminal Command" },
  -- },
  -- No explicit config function needed if opts handles everything
  -- config = function(_, opts)
  --   require('term-edit').setup(opts)
  -- end,
}
