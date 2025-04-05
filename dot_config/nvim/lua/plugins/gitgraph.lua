-- dot_config/nvim/lua/plugins/gitgraph.lua
return {
  'isakbm/gitgraph.nvim',
  -- Dependencies: Uses Diffview for commit diffs
  dependencies = { 'sindrets/diffview.nvim' },
  -- Load lazily, triggered by the keymap or command
  cmd = { 'GitGraph' },
  event = 'VeryLazy',
  -- opts table passes configuration directly to setup()
  opts = {
    hooks = {
      format = {
        timestamp = '%Y-%m-%d %H:%M:%S',
        fields = { 'hash', 'timestamp', 'author', 'branch_name', 'tag' },
      },
      -- Ensure Diffview is loaded before calling its command
      on_select_commit = function(commit)
        local diffview_ok, _ = pcall(require, 'diffview.nvim')
        if diffview_ok then
          vim.cmd(':DiffviewOpen ' .. commit.hash .. '^!')
          vim.notify('DiffviewOpen ' .. commit.hash .. '^!') -- Optional notification
        else
          vim.notify('Diffview not loaded.', vim.log.levels.WARN)
        end
      end,
      on_select_range_commit = function(from, to)
        local diffview_ok, _ = pcall(require, 'diffview.nvim')
        if diffview_ok then
          vim.cmd(':DiffviewOpen ' .. from.hash .. '~1..' .. to.hash)
          vim.notify('DiffviewOpen ' .. from.hash .. '~1..' .. to.hash) -- Optional notification
        else
          vim.notify('Diffview not loaded.', vim.log.levels.WARN)
        end
      end,
    },
    symbols = {
      merge_commit = '○',
      commit = '●',
      merge_commit_end = '○',
      commit_end = '●',
      GVER = '│',
      GHOR = '─',
      GCLD = '╮',
      GCRD = '╭',
      GCLU = '╯',
      GCRU = '╰',
      GLRU = '┴',
      GLRD = '┬',
      GLUD = '┤',
      GRUD = '├',
      GFORKU = '┼',
      GFORKD = '┼',
      GRUDCD = '├',
      GRUDCU = '┡',
      GLUDCD = '┪',
      GLUDCU = '┩',
      GLRDCL = '┬',
      GLRDCR = '┬',
      GLRUCL = '┴',
      GLRUCR = '┴',
    },
    -- Other options like filetype, colors, etc. can be added here
  },
  -- Define keymaps using the 'keys' table
  keys = {
    {
      '<C-g>g', -- Original keymap
      function()
        -- Ensure gitgraph is loaded before drawing
        local ok, gitgraph = pcall(require, 'gitgraph')
        if ok then
          gitgraph.draw({}, { all = true, max_count = 5000 })
        else
          vim.notify('gitgraph.nvim not loaded.', vim.log.levels.WARN)
        end
      end,
      desc = 'Open Git Graph',
    },
  },
  -- No explicit config function needed if opts and keys are sufficient
  -- config = function(_, opts)
  --   require('gitgraph').setup(opts)
  --   -- Keymaps could also be defined here
  -- end,
}
