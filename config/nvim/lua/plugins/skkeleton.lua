return {
  'vim-skk/skkeleton',
  dependencies = { 'vim-denops/denops.vim' },
  -- Load earlier to ensure Denops is ready
  event = { 'InsertEnter', 'CmdlineEnter' },
  keys = {
    { '<C-k>', '<Plug>(skkeleton-toggle)', mode = { 'i', 'c', 't' }, desc = 'Toggle skk' },
  },
  init = function()
    vim.api.nvim_create_autocmd('User', {
      pattern = 'skkeleton-enable-pre',
      callback = function()
        vim.fn['skkeleton#config']({
          keepState = vim.bo.filetype == 'markdown',
        })
      end,
      group = vim.api.nvim_create_augroup('skkeletonKeepState', { clear = true }),
    })

    vim.api.nvim_create_autocmd('User', {
      pattern = 'skkeleton-initialize-pre',
      callback = function()
        vim.fn['skkeleton#config']({
          globalDictionaries = {
            vim.fn.expand('~/.skk/SKK-JISYO.L'),
            vim.fn.expand('~/.skk/SKK-JISYO.geo'),
            vim.fn.expand('~/.skk/SKK-JISYO.emoji.utf8'),
            vim.fn.expand('~/.skk/SKK-JISYO.propernoun'),
            vim.fn.expand('~/.skk/SKK-JISYO.jinmei'),
          },
          sources = { 'deno_kv', 'google_japanese_input' },
          databasePath = vim.fn.expand('~/.skk/skkeleton.db'),
          immediatelyCancel = false,
          registerConvertResult = true,
          showCandidatesCount = 2,
          userDictionary = vim.fn.expand('~/.skk/userdict.txt'),
          eggLikeNewline = false,
          keepState = false,
        })
        vim.fn['skkeleton#register_kanatable']('rom', {
          ['--'] = { '-', '' },
          ['-'] = { 'ー', '' },
          ['..'] = { '.', '' },
          ['.'] = { '。', '' },
          [',,'] = { ',', '' },
          ['/'] = { '/', '' },
          ['//'] = { '・', '' },
          ['['] = { '[', '' },
          ['[['] = { '「', '' },
          [']'] = { ']', '' },
          [']]'] = { '」', '' },
          ['('] = { '（', '' },
          [')'] = { '）', '' },
          ['z '] = { '　', '' },
          ['z1'] = { '①', '' },
          ['z2'] = { '②', '' },
          ['z3'] = { '③', '' },
          ['z4'] = { '④', '' },
          ['z5'] = { '⑤', '' },
          ['z6'] = { '⑥', '' },
          ['z7'] = { '⑦', '' },
          ['z8'] = { '⑧', '' },
          ['z9'] = { '⑨', '' },
        })
      end,
      group = vim.api.nvim_create_augroup('skkelectonInitPre', { clear = true }),
    })
  end,
}
