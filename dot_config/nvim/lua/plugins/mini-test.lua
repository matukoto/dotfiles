-- dot_config/nvim/lua/plugins/mini-test.lua
-- Configuration for mini.test - A minimal testing framework
return {
  'echasnovski/mini.test',
  -- Load lazily, perhaps only when running tests or specific commands
  cmd = { 'MiniTest' }, -- Expose the main command if needed
  event = 'VeryLazy',
  -- opts table passes configuration directly to setup()
  opts = {
    -- Configure test discovery, execution, reporting, etc.
    -- Example: Specify test file patterns
    -- files = { "%_spec%.lua$", "%_test%.lua$" },
    -- Example: Configure test runner options
    -- runner = { use_busted = false },
  },
  -- config function ensures setup is called after loading
  config = function(_, opts)
    require('mini.test').setup(opts)
  end,
}
