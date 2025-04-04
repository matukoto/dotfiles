-- dot_config/nvim/lua/plugins/vim-sonictemplate.lua
-- Configuration for mattn/vim-sonictemplate
return {
  'mattn/vim-sonictemplate',
  -- Load lazily, triggered by command or potentially on InsertEnter if used often
  cmd = { "Template" },
  event = "VeryLazy",
  -- init function to set global variables before loading
  init = function()
    -- Set the template directory path
    -- Use vim.fn.expand to correctly handle $HOME or ~
    vim.g.sonictemplate_vim_template_dir = vim.fn.expand('~/.config/vim/sonictemplate/')
  end,
  -- No specific opts needed for default behavior
  opts = {},
  -- config function to define command abbreviation after loading
  config = function()
    -- Define command abbreviation 'tp' for 'Template'
    vim.cmd('cabbrev tp Template')
  end,
}
