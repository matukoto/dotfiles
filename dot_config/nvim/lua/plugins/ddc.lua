-- dot_config/nvim/lua/plugins/ddc.lua
-- Configuration for ddc.vim and related plugins
return {
  -- Main ddc plugin
  'shougo/ddc.vim',
  -- Dependencies: Denops, UI (pum), sources (skkeleton)
  dependencies = {
    'vim-denops/denops.vim',
    'shougo/pum.vim', -- UI for ddc
    'shougo/ddc-ui-pum', -- UI for ddc
    'vim-skk/skkeleton', -- Source for Japanese input
  },
  -- Load earlier to ensure Denops is ready
  event = { 'InsertEnter', 'CmdlineEnter' },
  config = function()
    vim.cmd([[
      call ddc#custom#patch_global('ui', 'pum')
      call ddc#custom#patch_global('sources', ['skkeleton'])
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
      call ddc#enable()

      inoremap <C-n>   <Cmd>call pum#map#insert_relative(+1)<CR>
      inoremap <C-p>   <Cmd>call pum#map#insert_relative(-1)<CR>
      inoremap <C-y>   <Cmd>call pum#map#confirm()<CR>
      inoremap <C-e>   <Cmd>call pum#map#cancel()<CR>
    ]])
  end,
}
