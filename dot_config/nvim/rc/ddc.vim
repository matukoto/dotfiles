" ddc.vim（Deno powered completion framework）の設定

" 補完UIとしてpum（popup menu）を使用
call ddc#custom#patch_global('ui', 'pum')

" 補完ソースの設定
" skkeleton: 日本語入力
" file: ファイルパス
" around: カーソル周辺の単語
" buffer: バッファ内の単語
" lsp: Language Server
" cmdline: コマンドライン補完
" cmdline_history: コマンドライン履歴
call ddc#custom#patch_global('sources', ['skkeleton','file','around','buffer','lsp','cmdline','cmdline_history'])

" 全ソース共通のデフォルト設定
call ddc#custom#patch_global('sourceOptions', {
      \ '_': {
      \   'matchers': ['matcher_fuzzy'],    
      \   'sorters': ['sorter_fuzzy'],      
      \   'converters': ['converter_fuzzy'], 
      \   'maxItems': [50],                 
      \ }
      \ })

" skkeletonソースの設定
call ddc#custom#patch_global('sourceOptions', {
      \ 'skkeleton': {
      \   'mark': 'skk',                  
      \   'isVolatile': v:true,           
      \   'matchers': [],                 
      \   'sorters': [],                  
      \   'converters': [],               
      \   'minAutoCompleteLength': 1,     
      \ },
      \ })

" aroundソースの設定（カーソル周辺の単語を補完）
call ddc#custom#patch_global('sourceOptions', {
      \ 'around': {
      \ 'mark': 'A',                       
      \ 'minAutoCompleteLength': 2,        
      \ },
      \ })

" LSPソースの設定
call ddc#custom#patch_global('sourceOptions', {
      \ 'lsp': {
      \   'mark': 'lsp',                  
      \   'isVolatile': v:true,           
      \   'forceCompletionPattern': '\.\w*|:\w*|->\w*',
      \   'minAutoCompleteLength': 2,    
      \ },
      \ })

" バッファソースの設定
call ddc#custom#patch_global('sourceOptions', {
      \ '_': {'matchers': ['matcher_head']},
    \ 'buffer': {'mark': 'B'},             
    \ })

" バッファソースのパラメータ設定
call ddc#custom#patch_global('sourceParams', {
    \ 'buffer': {
    \   'requireSameFiletype': v:false,   
    \   'limitBytes': 5000000,            
    \   'fromAltBuf': v:true,             
    \   'forceCollect': v:true,           
    \ },
    \ })

" ファイルパス補完の設定
call ddc#custom#patch_global('sourceOptions', {
      \ 'file': {
      \   'mark': 'F',                     
      \   'isVolatile': v:true,            
      \   'forceCompletionPattern': '\S/\S*',
      \   'minAutoCompleteLength': 1,       
      \ },
      \ })

" LSPソースのスニペット設定
call ddc#custom#patch_global('sourceParams', #{
      \   lsp: #{
      \     snippetEngine: denops#callback#register({
      \           body -> vsnip#anonymous(body)
      \     }),
      \     enableResolveItem: v:true,      
      \     enableAdditionalTextEdit: v:true, 
      \   }
      \ })

" コマンドライン補完の設定
call ddc#custom#patch_global('sourceOptions', #{
      \   cmdline: #{
      \     mark: 'cmdline', 
      \   }
      \ })

" コマンドライン履歴の設定
call ddc#custom#patch_global('sourceOptions', #{
      \   cmdline_history: #{ mark: 'history' },  
      \ })

" ddc.vimを有効化
call ddc#enable()

" 補完メニューのキーマッピング
inoremap <C-n>   <Cmd>call pum#map#insert_relative(+1)<CR>  " 次の候補を選択
inoremap <C-p>   <Cmd>call pum#map#insert_relative(-1)<CR>  " 前の候補を選択
inoremap <C-y>   <Cmd>call pum#map#confirm()<CR>           " 候補を確定
inoremap <C-e>   <Cmd>call pum#map#cancel()<CR>            " 補完をキャンセル

" コマンドライン補完の詳細設定
call ddc#custom#patch_global(#{
        \   ui: 'pum',
        \   autoCompleteEvents: [ 
        \     'InsertEnter',      
        \     'TextChangedI',     
        \     'TextChangedP',     
        \     'CmdlineChanged',   
        \   ],
        \   cmdlineSources: {
        \     ':': ['cmdline', 'cmdline_history', 'around']  
        \   },
        \ })

" コマンドラインモード開始のマッピング
nnoremap ;       <Cmd>call CommandlinePre()<CR>:

" コマンドラインモード開始時の設定
function! CommandlinePre() abort
    " コマンドラインモードでのキーマッピング
    cnoremap <C-n>   <Cmd>call pum#map#insert_relative(+1)<CR>  " 次の候補を選択
    cnoremap <C-p>   <Cmd>call pum#map#insert_relative(-1)<CR>  " 前の候補を選択
    cnoremap <C-y>   <Cmd>call pum#map#confirm()<CR>           " 候補を確定
    cnoremap <C-e>   <Cmd>call pum#map#cancel()<CR>            " 補完をキャンセル

    " コマンドラインモード終了時に後処理を実行
    autocmd User DDCCmdlineLeave ++once call CommandlinePost()

    " コマンドライン補完を有効化
    call ddc#enable_cmdline_completion()
endfunction

" コマンドラインモード終了時の後処理
function! CommandlinePost() abort
    " キーマッピングを解除
    silent! cunmap <C-n>
    silent! cunmap <C-p>
    silent! cunmap <C-y>
    silent! cunmap <C-e>
endfunction
