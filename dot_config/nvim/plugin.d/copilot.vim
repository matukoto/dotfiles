" imap <expr> <C-Space> copilot#expand()
" imap <C-]> <plug>(copilot-dismiss)
let g:copilot_no_tab_map = v:true
let g:copilot_no_maps = v:true
let g:copilot_filetypes = {
      \ '*': v:true,
      \ 'java': v:false,
      \ }
