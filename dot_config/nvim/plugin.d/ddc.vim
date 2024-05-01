call ddc#custom#patch_global('ui', 'native')
call ddc#custom#patch_global('sources', ['skkeleton','lsp'])
call ddc#custom#patch_global('sourceOptions', {
      \ 'skkeleton': {
      \     'isVolatile': v:true,
      \     'mark': 'skk',
      \     'matchers': ['skkeleton'],
      \     'sorters': [],
      \     'minAutoCompleteLength': 2,
      \   },
      \ 'lsp': {
      \     'isVolatile': v:true,
      \    'mark': 'lsp',
      \    'forceCompletionPattern': '\.\w*|:\w*|->\w*',
      \     'matchers': [],
      \     'sorters': [],
      \     'minAutoCompleteLength': 2,
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
