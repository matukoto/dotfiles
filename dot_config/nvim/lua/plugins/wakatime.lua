return {
  'wakatime/vim-wakatime',
  cond = function()
    return os.getenv('PRIVATE_PLUGIN_ENABLED') ~= nil
  end,
  event = 'VeryLazy',
}
