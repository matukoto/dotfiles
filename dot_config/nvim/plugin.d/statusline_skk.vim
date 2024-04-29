let g:lightline_skk_announce = v:true

call statusline_skk#option('display', {
  \ 'hiragana': 'あ',
  \ 'katakana': 'ア',
  \ 'hankaku-katakana': 'ｱ',
  \ 'zenkaku-alphabet': 'Ａ',
  \ 'alphabet': 'A',
  \ })
call statusline_skk#option('enable_mode', {
  \ 'INSERT': v:true,
  \ 'COMMAND': v:false,
  \ })
