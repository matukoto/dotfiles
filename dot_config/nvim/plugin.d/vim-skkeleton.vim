call skkeleton#config({
      \ 'globalDictionaries': ['~/.skk/SKK-JISYO.L','~/.skk/SKK-JISYO.emoji.utf8', '~/.skk/SKK-JISYO.geo', '~/.skk/SKK-JISYO.jinmei', '~/.skk/SKK-JISYO.propernoun'],
      \ 'sources': ['deno_kv', 'google_japanese_input'],
      \ 'databasePath': '~/.skk/skkeleton.db',
      \ 'eggLikeNewline': v:true,
      \ 'immediatelyCancel': v:false,
      \ 'registerConvertResult': v:true,
      \ 'showCandidatesCount': 2,
      \})
imap <C-j> <Plug>(skkeleton-enable)
cmap <C-j> <Plug>(skkeleton-enable)
