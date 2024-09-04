call ddc#custom#patch_global('ui', 'pum')
call ddc#custom#patch_global('sources', ['skkeleton','file','around','buffer','lsp','cmdline','cmdline-history'])
call ddc#custom#patch_global('sourceOptions', {
      \ '_': {
      \   'matchers': ['matcher_fuzzy'],
      \   'sorters': ['sorter_fuzzy'],
      \   'converters': ['converter_fuzzy'],
      \   'maxItems': [50],
      \ }
      \ })

call ddc#custom#patch_global('sourceOptions', {
      \ 'skkeleton': {
      \   'mark': 'skk',
      \   'isVolatile': v:true,
      \   'matchers': ['skkeleton'],
      \   'sorters': [],
      \   'converters': [],
      \   'minAutoCompleteLength': 1,
      \ },
      \ })

call ddc#custom#patch_global('sourceOptions', {
      \ 'around': {
      \ 'mark': 'A',
      \ 'minAutoCompleteLength': 2,
      \ },
      \ })

call ddc#custom#patch_global('sourceOptions', {
      \ 'lsp': {
      \   'mark': 'lsp',
      \   'isVolatile': v:true,
      \   'forceCompletionPattern': '\.\w*|:\w*|->\w*',
      \   'minAutoCompleteLength': 2,
      \ },
      \ })

call ddc#custom#patch_global('sourceOptions', {
    \ '_': {'matchers': ['matcher_head']},
    \ 'buffer': {'mark': 'B'},
    \ })

call ddc#custom#patch_global('sourceParams', {
    \ 'buffer': {
    \   'requireSameFiletype': v:false,
    \   'limitBytes': 5000000,
    \   'fromAltBuf': v:true,
    \   'forceCollect': v:true,
    \ },
    \ })

call ddc#custom#patch_global('sourceOptions', {
      \ 'file': {
      \   'mark': 'F',
      \   'isVolatile': v:true,
      \   'forceCompletionPattern': '\S/\S*',
      \   'minAutoCompleteLength': 1,
      \ },
      \ })

call ddc#custom#patch_global('sourceParams', #{
      \   lsp: #{
      \     snippetEngine: denops#callback#register({
      \           body -> vsnip#anonymous(body)
      \     }),
      \     enableResolveItem: v:true,
      \     enableAdditionalTextEdit: v:true,
      \   }
      \ })

call ddc#custom#patch_global('sourceOptions', #{
      \   cmdline: #{
      \     mark: 'cmdline',
      \   }
      \ })

call ddc#custom#patch_global('sourceOptions', #{
      \   cmdline-history: #{ mark: 'history' },
      \ })
call ddc#enable()
inoremap <C-n>   <Cmd>call pum#map#insert_relative(+1)<CR>
inoremap <C-p>   <Cmd>call pum#map#insert_relative(-1)<CR>
inoremap <C-y>   <Cmd>call pum#map#confirm()<CR>
inoremap <C-e>   <Cmd>call pum#map#cancel()<CR>

" cmdline 補完
call ddc#custom#patch_global(#{
        \   ui: 'pum',
        \   autoCompleteEvents: [
        \     'InsertEnter', 'TextChangedI', 'TextChangedP', 'CmdlineChanged',
        \   ],
        \   cmdlineSources: {
        \     ':': ['cmdline', 'cmdline-history', 'around']
        \   },
        \ })
nnoremap ;       <Cmd>call CommandlinePre()<CR>:

function! CommandlinePre() abort
    cnoremap <C-n>   <Cmd>call pum#map#insert_relative(+1)<CR>
    cnoremap <C-p>   <Cmd>call pum#map#insert_relative(-1)<CR>
    cnoremap <C-y>   <Cmd>call pum#map#confirm()<CR>
    cnoremap <C-e>   <Cmd>call pum#map#cancel()<CR>

    autocmd User DDCCmdlineLeave ++once call CommandlinePost()

    " Enable command line completion for the buffer
    call ddc#enable_cmdline_completion()
endfunction
function! CommandlinePost() abort
    silent! cunmap <C-n>
    silent! cunmap <C-p>
    silent! cunmap <C-y>
    silent! cunmap <C-e>
endfunction
