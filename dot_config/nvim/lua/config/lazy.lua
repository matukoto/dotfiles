-- ~/.config/nvim/lua/config/lazy.lua
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  -- クローン時に安定版ブランチを指定
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  spec = {
    { import = "plugins.aerial" },
    { import = "plugins.blink" },
    { import = "plugins.bufferline" },
    { import = "plugins.camelcasemotion" },
    { import = "plugins.ccc" },
    { import = "plugins.chowcho" },
    { import = "plugins.codecompanion" },
    { import = "plugins.comment" },
    { import = "plugins.conform" },
    { import = "plugins.copilot-chat" },
    { import = "plugins.copilot" },
    { import = "plugins.ddc" },
    { import = "plugins.denops" },
    { import = "plugins.dial" },
    { import = "plugins.dmacro" },
    { import = "plugins.fern-git-status" },
    { import = "plugins.fern-renderer-nerdfont" },
    { import = "plugins.fern" },
    { import = "plugins.fidget" },
    { import = "plugins.flash" },
    { import = "plugins.fm-nvim" },
    { import = "plugins.full_visual_line" },
    { import = "plugins.fuzzy-motion" },
    { import = "plugins.gin" },
    { import = "plugins.gitgraph" },
    { import = "plugins.gitsigns" },
    { import = "plugins.hlchunk" },
    { import = "plugins.hlslens" },
    { import = "plugins.lazydev" },
    { import = "plugins.lexima" },
    { import = "plugins.lspconfig" },
    { import = "plugins.lspsaga" },
    { import = "plugins.lspui" },
    { import = "plugins.lualine" },
    { import = "plugins.markdown" },
    { import = "plugins.mini-test" },
    { import = "plugins.neotest" },
    { import = "plugins.nvim-lastplace" },
    { import = "plugins.nvim-lint" },
    { import = "plugins.nvim-ts-autotag" },
    { import = "plugins.oil" },
    { import = "plugins.open-browser" },
    { import = "plugins.project" },
    { import = "plugins.quicker" },
    { import = "plugins.rainbow-csv" },
    { import = "plugins.scope" },
    { import = "plugins.skkeleton_indicator" },
    { import = "plugins.skkeleton" },
    { import = "plugins.smartbufs" },
    { import = "plugins.smoothcursor" },
    { import = "plugins.snacks" },
    { import = "plugins.styler" },
    { import = "plugins.telescope" },
    { import = "plugins.term-edit" },
    { import = "plugins.tiny-code-action" },
    { import = "plugins.todo-comments" },
    { import = "plugins.toggleterm" },
    { import = "plugins.treesitter" },
    { import = "plugins.trouble" },
    { import = "plugins.ufo" },
    { import = "plugins.vim-cheatsheet" },
    { import = "plugins.vim-dadbod-ui" },
    { import = "plugins.vim-edgemotion" },
    { import = "plugins.vim-quickrun" },
    { import = "plugins.vim-sonictemplate" },
    { import = "plugins.waitevent" },
    { import = "plugins.which-key" },
    { import = "plugins.yazi" },
    -- 必要に応じて他のプラグインや設定をここに追加
  },
  -- 必要に応じて他の lazy.nvim の設定をここに追加できます
  -- 例: change_detection = { notify = false }
})
