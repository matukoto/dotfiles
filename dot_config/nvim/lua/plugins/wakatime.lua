return {
  'wakatime/wakatime-vimwakatime',
  cond = function()
    return os.getenv('PRIVATE_PLUGIN_ENABLED') ~= nil
  end,
  event = 'VeryLazy',
}
