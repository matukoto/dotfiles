" コメントで改行する際､コメントアウトをしないで改行する
au FileType * set fo-=cro
" マークダウン､Javaでコメントで改行する際､コメントアウトをして改行する
au FileType java setlocal fo+=jro
" - [Vimでmarkdownの箇条書き](https://zenn.dev/vim_jp/articles/4564e6e5c2866d)
" o, O で改行する際はコメントアウトをしない 
au FileType markdown setlocal fo+=jr
