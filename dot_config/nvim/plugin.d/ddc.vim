call ddc#custom#patch_global('ui', 'native')
call ddc#custom#patch_global('sources', ['skkeleton'])
call ddc#custom#patch_global('sourceOptions', {
      \ 'skkeleton': {
      \     'isVolatile': v:true,
      \     'mark': 'skkeleton',
      \     'matchers': ['skkeleton'],
      \     'sorters': [],
      \     'minAutoCompleteLength': 2,
      \   },
      \ })
call ddc#enable()
