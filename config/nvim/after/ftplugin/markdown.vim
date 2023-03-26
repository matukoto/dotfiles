" 改行時に箇条書きを継続
setlocal comments=b:*,b:-,b:+,nb:>

" 改行時にチェックボックスを継続
setlocal comments=nb:>
        \ comments+=b:*\ [\ ],b:*\ [x],b:*
        \ comments+=b:+\ [\ ],b:+\ [x],b:+
        \ comments+=b:-\ [\ ],b:-\ [x],b:-
"        \ comments+=b:1.\ [\ ],b:1.\ [x],b:1.

" markdown は2
set tabstop=2
set shiftwidth=2
set softtabstop=2
