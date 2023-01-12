" 改行時に箇条書きを継続
setlocal comments=b:*,b:-,b:+,b:1.,nb:>

" 改行時にチェックボックスを継続
setlocal comments=nb:>
        \ comments+=b:*\ [\ ],b:*\ [x],b:*
        \ comments+=b:+\ [\ ],b:+\ [x],b:+
        \ comments+=b:-\ [\ ],b:-\ [x],b:-
        \ comments+=b:1.\ [\ ],b:1.\ [x],b:1.
