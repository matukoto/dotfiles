-- dot_config/nvim/lua/plugins/lexima.lua
-- Configuration for cohama/lexima.vim auto-pairing plugin
return {
  'cohama/lexima.vim',
  -- Load when entering insert mode
  event = "InsertEnter",
  -- init function to set global variables before loading
  init = function()
    -- Treat Ctrl+H as Backspace
    vim.g.lexima_ctrlh_as_backspace = 1
  end,
  -- No opts needed
  -- config function to add custom rules after loading
  config = function()
    -- Define custom rules in Lua table format
    local rules = {
      { filetype = {'svelte','typescript', 'typescriptreact'}, char = '>', at = '\\s([a-zA-Z, ]*\\%#)',            input = '<Left><C-o>f)<Right>a=> {}<Esc>'                 },
      { filetype = {'svelte','typescript', 'typescriptreact'}, char = '>', at = '\\s([a-zA-Z]\\+\\%#)',             input = '<Right> => {}<Left>',              priority = 10 },
      { filetype = {'svelte','typescript', 'typescriptreact'}, char = '>', at = '[a-z]((.*\\%#.*))',              input = '<Left><C-o>f)a => {}<Esc>'                       },
      { filetype = {'svelte','typescript', 'typescriptreact'}, char = '>', at = '[a-z]([a-zA-Z]\\+\\%#)',          input = ' => {}<Left>'                                    },
      { filetype = {'svelte','typescript', 'typescriptreact'}, char = '>', at = '(.*[a-zA-Z]\\+<[a-zA-Z]\\+>\\%#)', input = '<Left><C-o>f)<Right>a=> {}<Left>'                },
    }

    -- Ensure lexima functions are available before adding rules
    if vim.fn.exists('*lexima#add_rule') == 2 then
      for _, rule in ipairs(rules) do
        vim.call('lexima#add_rule', rule)
      end
    else
      vim.notify("lexima.vim functions not found, cannot add custom rules.", vim.log.levels.WARN)
    end

    -- Enable lexima (usually done automatically, but can be explicit)
    -- vim.cmd('call lexima#enable()')
  end,
}
