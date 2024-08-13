require('persistence').setup({
  dir = vim.fn.stdpath('state') .. '/sessions/', -- directory where session files are saved
  -- minimum number of file buffers that need to be open to save
  -- Set to 0 to always save
  need = 1,
  branch = true, -- use git branch to save session
})

require('dashboard').setup()

vim.api.nvim_create_autocmd('VimEnter', {
  callback = function()
    require('persistence').load()
  end,
})
