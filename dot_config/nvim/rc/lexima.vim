let s:rules = [
\ { 'filetype': ['svelte','typescript', 'typescriptreact'], 'char': '>', 'at': '\s([a-zA-Z, ]*\%#)',            'input': '<Left><C-o>f)<Right>a=> {}<Esc>',                 },
\ { 'filetype': ['svelte','typescript', 'typescriptreact'], 'char': '>', 'at': '\s([a-zA-Z]\+\%#)',             'input': '<Right> => {}<Left>',              'priority': 10 },
\ { 'filetype': ['svelte','typescript', 'typescriptreact'], 'char': '>', 'at': '[a-z]((.*\%#.*))',              'input': '<Left><C-o>f)a => {}<Esc>',                       },
\ { 'filetype': ['svelte','typescript', 'typescriptreact'], 'char': '>', 'at': '[a-z]([a-zA-Z]\+\%#)',          'input': ' => {}<Left>',                                    },
\ { 'filetype': ['svelte','typescript', 'typescriptreact'], 'char': '>', 'at': '(.*[a-zA-Z]\+<[a-zA-Z]\+>\%#)', 'input': '<Left><C-o>f)<Right>a=> {}<Left>',                },
\ ]

let g:lexima_ctrlh_as_backspace = 1

function! s:add_lexima_rules()
  for rule in s:rules
    call lexima#add_rule(rule)
  endfor
endfunction
