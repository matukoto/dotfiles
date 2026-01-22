return {
  'lambdalisue/nvim-aibo',
  config = function()
    require('aibo').setup({
      controller = {
        mappings = function(bufnr)
          local opts = { buffer = bufnr, nowait = true, silent = true }
          vim.keymap.set('i', '<C-Enter>', '<Plug>(aibo-submit)', opts)
        end,
      },
    })

    vim.keymap.set('n', '<leader>at', ':Aibo -opener=tabnew gemini<CR>', { desc = 'Aibo Gemini in Tab' })
    --選択範囲を Aibo に送信
    vim.keymap.set('v', '<leader>as', ':AiboSend -submit<CR>', { desc = 'Send selection to Aibo' })
  end,
}
