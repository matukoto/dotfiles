call ddc#custom#patch_global('ui', 'pum')
call ddc#custom#patch_global('sources', ['skkeleton','lsp','file'])
call ddc#custom#patch_global('sourceOptions', {
      \ '_': {
      \   'matchers': ['matcher_fuzzy'],
      \   'sorters': ['sorter_fuzzy'],
      \   'converters': ['converter_fuzzy']
      \ },
      \ 'skkeleton': {
      \   'isVolatile': v:true,
      \   'mark': 'skk',
      \   'matchers': ['skkeleton'],
      \   'sorters': ['sorter_rank'],
      \   'minAutoCompleteLength': 2,
      \ },
      \ 'lsp': {
      \   'isVolatile': v:true,
      \   'mark': 'lsp',
      \   'forceCompletionPattern': '\.\w*|:\w*|->\w*',
      \   'minAutoCompleteLength': 2,
      \ },
      \ 'file': {
      \   'mark': 'F',
      \   'isVolatile': v:true,
      \   'forceCompletionPattern': '\S/\S*',
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

call ddc#enable()
inoremap <C-n>   <Cmd>call pum#map#insert_relative(+1)<CR>
inoremap <C-p>   <Cmd>call pum#map#insert_relative(-1)<CR>
inoremap <C-y>   <Cmd>call pum#map#confirm()<CR>
inoremap <C-e>   <Cmd>call pum#map#cancel()<CR>
