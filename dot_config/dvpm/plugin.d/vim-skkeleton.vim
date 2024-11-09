call skkeleton#config({
      \ 'globalDictionaries': ['~/.skk/SKK-JISYO.L','~/.skk/SKK-JISYO.emoji.utf8', '~/.skk/SKK-JISYO.geo', '~/.skk/SKK-JISYO.jinmei', '~/.skk/SKK-JISYO.propernoun'],
      \ 'sources': ['deno_kv', 'google_japanese_input'],
      \ 'databasePath': '~/.skk/skkeleton.db',
      \ 'eggLikeNewline': v:false,
      \ 'immediatelyCancel': v:false,
      \ 'registerConvertResult': v:true,
      \ 'showCandidatesCount': 2,
      \ 'debug': v:false,
      \ 'keepState': v:false,
      \ 'userDictionary': '~/.skk/userdict.txt'
      \})

call skkeleton#register_kanatable('rom', {
      \   '--': ['-',''],
      \   '-': ['ー',''],
      \   '..': ['.',''],
      \   '.': ['。',''],
      \   ',,': [',',''],
      \   '/': ['/',''],
      \   '//': ['・',''],
      \   '[': ['[',''],
      \   '[[': ['「',''],
      \   ']': [']',''],
      \   ']]': ['」',''],
      \ })

" skkeleton がモードの状態を保持しないように修正
function! s:skkeleton_init() abort
  call skkeleton#config({
    \ 'keepState': v:false
    \ })
endfunction
augroup skkeleton-enable-previous
  autocmd!
  autocmd User skkeleton-enable-pre call s:skkeleton_init()
augroup END

imap <C-j> <Plug>(skkeleton-enable)
cmap <C-j> <Plug>(skkeleton-enable)
