return {
  'rmagatti/auto-session',
  event = 'VeryLazy',
  keys = {
    -- Will use Telescope if installed or a vim.ui.select picker otherwise
    -- { '<leader>wr', '<cmd>SessionSearch<CR>', desc = 'Session search' },
    -- { '<leader>ws', '<cmd>SessionSave<CR>', desc = 'Save session' },
  },
  ---enables autocomplete for opts
  ---@module "auto-session"
  ---@type AutoSession.Config
  opts = {
    root_dir = vim.fn.stdpath('data') .. '/sessions/', -- Root dir where sessions will be stored
    auto_save = true,
    auto_restore = true,
    auto_create = true,
    suppressed_dirs = nil, -- Suppress session restore/create in certain directories
    allowed_dirs = nil, -- Allow session restore/create in certain directories
    auto_restore_last_session = false, -- On startup, loads the last saved session if session for cwd does not exist
    git_use_branch_name = true, -- Include git branch name in session name
    git_auto_restore_on_branch_change = true, -- Should we auto-restore the session when the git branch changes. Requires git_use_branch_name
    lazy_support = true,
    bypass_save_filetypes = { 'snacks_dashboard' }, -- List of filetypes to bypass auto save when the only buffer open is one of the file types listed, useful to ignore dashboards
    close_unsupported_windows = true, -- Close windows that aren't backed by normal file before autosaving a session
    args_allow_single_directory = true, -- Follow normal sesion save/load logic if launched with a single directory as the only argument
    args_allow_files_auto_save = false, -- Allow saving a session even when launched with a file argument (or multiple files/dirs). It does not load any existing session first. While you can just set this to true, you probably want to set it to a function that decides when to save a session when launched with file args. See documentation for more detail
    continue_restore_on_error = true, -- Keep loading the session even if there's an error
    show_auto_restore_notif = false, -- Whether to show a notification when auto-restoring
    cwd_change_handling = false, -- Follow cwd changes, saving a session before change and restoring after
    lsp_stop_on_restore = false, -- Should language servers be stopped when restoring a session. Can also be a function that will be called if set. Not called on autorestore from startup
    restore_error_handler = nil, -- Called when there's an error restoring. By default, it ignores fold errors otherwise it displays the error and returns false to disable auto_save
    purge_after_minutes = nil, -- Sessions older than purge_after_minutes will be deleted asynchronously on startup, e.g. set to 14400 to delete sessions that haven't been accessed for more than 10 days, defaults to off (no purging), requires >= nvim 0.10
    log_level = 'error', -- Sets the log level of the plugin (debug, info, warn, error).
    session_lens = {
      -- If load_on_setup is false, make sure you use `:SessionSearch` to open the picker as it will initialize everything first
      load_on_setup = false,
      previewer = true,
      mappings = {
        delete_session = { 'i', '<C-D>' },
        delete_session = { 'n', 'D' },
        alternate_session = { 'i', '<C-S>' },
        copy_session = { 'i', '<C-Y>' },
      },
    },
  },
}
