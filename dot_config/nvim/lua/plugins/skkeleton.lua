return {
  'vim-skk/skkeleton',
  dependencies = { 'vim-denops/denops.vim' },
  -- Load earlier to ensure Denops is ready
  event = { 'InsertEnter', 'CmdlineEnter' },
  keys = {
    { '<C-j>', '<Plug>(skkeleton-toggle)', mode = { 'i', 'c' }, desc = 'Toggle skk' },
  },
  init = function()
    vim.api.nvim_create_autocmd('User', {
      pattern = 'skkeleton-initialize-pre',
      callback = function()
        vim.fn['skkeleton#config']({
          globalDictionaries = {
            vim.fn.expand('~/.skk/SKK-JISYO.L'),
          },
          eggLikeNewline = true,
          keepState = true,
        })
      end,
      group = vim.api.nvim_create_augroup('skkelectonInitPre', { clear = true }),
    })
  end,
}
