call popup_preview#enable()

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

call signature_help#enable()

