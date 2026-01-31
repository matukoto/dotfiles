-- dot_config/nvim/lua/plugins/image.lua
-- Neovimで画像を表示するためのプラグイン
return {
  '3rd/image.nvim',
  -- 依存関係
  dependencies = {
    'nvim-treesitter/nvim-treesitter',
  },
  -- 遅延読み込み: ファイルタイプに応じて読み込む
  ft = { 'markdown', 'norg', 'html' },
  event = 'VeryLazy',
  -- 設定オプション
  opts = {
    -- バックエンドの設定
    -- WeztermはKittyプロトコルの部分的なサポートがあるが、完全対応ではない
    -- 最良の体験にはKittyターミナルの使用を推奨
    -- Weztermを使用する場合: 'kitty' を試すか、'ueberzug' または将来的に 'sixel' を検討
    backend = 'kitty',
    -- バックエンドのフォールバック順序
    integrations = {
      -- markdownでの画像表示を有効化
      markdown = {
        enabled = true,
        clear_in_insert_mode = false,
        download_remote_images = true,
        only_render_image_at_cursor = false,
        filetypes = { 'markdown', 'vimwiki' },
      },
      -- neorgでの画像表示
      neorg = {
        enabled = true,
        clear_in_insert_mode = false,
        download_remote_images = true,
        only_render_image_at_cursor = false,
        filetypes = { 'norg' },
      },
      -- htmlでの画像表示
      html = {
        enabled = false,
      },
      -- cssでの画像表示
      css = {
        enabled = false,
      },
    },
    -- 最大サイズ設定
    max_width = nil,
    max_height = nil,
    max_width_window_percentage = nil,
    max_height_window_percentage = 50,
    -- ウィンドウの重なり設定
    window_overlap_clear_enabled = false,
    window_overlap_clear_ft_ignore = { 'cmp_menu', 'cmp_docs', '' },
    -- エディタのみの画像レンダリング
    editor_only_render_when_focused = false,
    -- tmux設定
    tmux_show_only_in_active_window = false,
    -- ハイジャック設定
    hijack_file_patterns = { '*.png', '*.jpg', '*.jpeg', '*.gif', '*.webp', '*.avif' },
  },
}
