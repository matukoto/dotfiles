local builtin = require('telescope.builtin')

local kensaku_actions = {}

kensaku_actions.live_grep = function()
  builtin.live_grep({
    ---@param prompt string
    ---@return { prompt?: string, updated_finder?: TelescopeFinder }
    on_input_filter_cb = function(prompt)
      return {
        prompt = vim.fn['kensaku#query'](prompt, {
          rxop = vim.g['kensaku#rxop#javascript'],
        }),
      }
    end,
  })
end

return require('telescope').register_extension({
  exports = {
    kensaku = kensaku_actions.live_grep,
  },
})
