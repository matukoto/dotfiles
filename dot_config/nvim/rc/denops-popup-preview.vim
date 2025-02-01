" Denopsベースのポップアッププレビュープラグインの設定

" ポップアッププレビュー機能を有効化
call popup_preview#enable()

" シグネチャヘルプ（関数の引数情報など）の設定
let g:signature_help_config = {
      \ 'border': v:true,              
      \ 'maxWidth': 80,                
      \ 'maxHeight': 30,               
      \ 'contentsStyle': 'full',       
      \ 'viewStyle': 'floating',       
      \ 'onTriggerChar': v:false,      
      \ 'multiLabel': v:false,         
      \ 'fallbackToBelow': v:true,     
      \ }

" シグネチャヘルプ機能を有効化
call signature_help#enable()
