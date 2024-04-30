imap <expr> <C-Space> copilot#expand()
imap <C-]> <plug>(copilot-dismiss)
let g:copilot_filetypes = {
      \ '*': v:true,
      \ 'java': v:false,
      \ }
