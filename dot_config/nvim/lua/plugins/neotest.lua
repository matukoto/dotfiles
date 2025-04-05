-- dot_config/nvim/lua/plugins/neotest.lua
return {
  'nvim-neotest/neotest',
  -- Dependencies listed in the main plugins.lua are automatically handled by lazy.nvim
  -- but listing them here can improve clarity and ensure correct loading order if needed.
  dependencies = {
    'nvim-neotest/nvim-nio', -- Required
    'antoinemadec/FixCursorHold.nvim', -- Recommended for stability
    'marilari88/neotest-vitest', -- Vitest adapter
    -- 'mfussenegger/nvim-jdtls', -- Uncomment if Java testing is needed
    -- 'rcasia/neotest-java', -- Uncomment if Java testing is needed
    -- 'mfussenegger/nvim-dap', -- Uncomment if DAP integration is needed
    -- 'rcarriga/nvim-dap-ui', -- Uncomment if DAP integration is needed
  },
  -- Load lazily, triggered by commands or keymaps
  cmd = { 'Neotest' },
  event = 'VeryLazy',
  -- opts table passes configuration directly to setup()
  opts = {
    -- IMPORTANT: Ensure adapters are required *within* the opts table or config function
    -- as they might not be loaded when the opts table is initially defined.
    -- Using a function for adapters ensures they are required at setup time.
    adapters = function()
      -- Use pcall to safely require adapters, in case they aren't installed
      local adapters = {}
      local vitest_ok, vitest_adapter = pcall(require, 'neotest-vitest')
      if vitest_ok then
        table.insert(adapters, vitest_adapter)
      else
        vim.notify('neotest-vitest adapter not found.', vim.log.levels.WARN)
      end

      -- Example for Java adapter (uncomment if needed)
      -- local java_ok, java_adapter = pcall(require, 'neotest-java')
      -- if java_ok then
      --   table.insert(adapters, java_adapter({
      --     -- junit_jar = "path/to/your/junit.jar", -- Specify if needed
      --     -- incremental_build = true,
      --     -- root_dir = function(bufnr) ... end, -- Function to find root dir
      --   }))
      -- else
      --   -- vim.notify("neotest-java adapter not found.", vim.log.levels.WARN)
      -- end
      return adapters
    end,
    -- discovery = { enabled = false }, -- Disable auto-discovery (as per original config)
    output = {
      open_on_run = false, -- Don't open output window automatically
    },
    diagnostic = {
      enabled = true,
      severity = vim.diagnostic.severity.ERROR,
    },
    status = {
      enabled = true,
      signs = true,
      virtual_text = true,
    },
    summary = {
      enabled = true,
      expand_errors = true,
      mappings = {
        expand = { 'o', '<2-LeftMouse>' },
        expand_all = 'O',
        output = 'o', -- Note: 'o' is used for both expand and output, might conflict
        jumpto = '<CR>',
        run = 'r',
        stop = 's',
        mark = 'm', -- Add mark mapping if needed
        -- Add other mappings like attach, watch, etc.
      },
    },
    icons = {
      running = '⟳',
      passed = '✓',
      failed = '✗',
      skipped = '↷',
      unknown = '?',
      -- Add other icons if needed (e.g., watching, marked)
    },
    floating = {
      border = 'rounded',
      max_height = 0.6,
      max_width = 0.6,
    },
    -- Add other neotest options if needed
    -- quickfix = { enabled = true, open = false },
    -- consumers = {},
  },
  -- Define keymaps using the 'keys' table
  keys = {
    {
      '<leader>tt',
      function()
        require('neotest').run.run()
      end,
      desc = 'Run Nearest Test',
    },
    {
      '<leader>tf',
      function()
        require('neotest').run.run(vim.fn.expand('%'))
      end,
      desc = 'Run Current File',
    },
    {
      '<leader>ta',
      function()
        require('neotest').run.run(vim.loop.cwd())
      end,
      desc = 'Run All Tests (Directory)',
    },
    {
      '<leader>tS',
      function()
        require('neotest').run.stop()
      end,
      desc = 'Stop Test Run',
    },
    {
      '<leader>ts',
      function()
        require('neotest').summary.toggle()
      end,
      desc = 'Toggle Test Summary',
    }, -- Use toggle instead of open
    {
      '<leader>to',
      function()
        require('neotest').output.open({ enter = true, auto_close = true })
      end,
      desc = 'Show Test Output',
    },
    {
      '<leader>tO',
      function()
        require('neotest').output.open({ enter = true, auto_close = false, last_run = true })
      end,
      desc = 'Show Last Test Output (Keep Open)',
    },
    {
      '<leader>tw',
      function()
        require('neotest').watch.toggle(vim.fn.expand('%'))
      end,
      desc = 'Toggle Watch Mode (File)',
    },
    {
      '[t',
      function()
        require('neotest').jump.prev({ status = 'failed' })
      end,
      desc = 'Prev Failed Test',
    },
    {
      ']t',
      function()
        require('neotest').jump.next({ status = 'failed' })
      end,
      desc = 'Next Failed Test',
    },
  },
  -- config function can be used for more complex setup logic
  config = function(_, opts)
    -- Ensure adapters are resolved correctly before setup
    if type(opts.adapters) == 'function' then
      opts.adapters = opts.adapters()
    end
    require('neotest').setup(opts)
  end,
}
