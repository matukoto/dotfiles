# Yazi設定

`~/.config/yazi` に配備する Yazi 設定。
レイアウト、open ルール、テーマ、追加キーマップの定義。

## 主要ファイル

- `yazi.toml`: manager / preview / opener / open rule 設定。
- `keymap.toml`: 追加キーマップ。
- `theme.toml`: 色、icon、preview theme 設定。

## 構成

- `layout = [1, 4, 3]` の 3 ペイン構成。
- hidden file 表示、symlink 表示、
  directory 優先ソートの有効化。
- opener として `nvim`, `vim`, `open`, `unar`,
  `exiftool`, `mediainfo`, `mpv` を使い分け。
- `Ctrl-s` で現在位置に shell を開く追加キーマップ。
- `theme.toml` では
  tab / status / selection / filetype 色と icon を定義。
- preview には
  `~/.config/bat/themes/Catppuccin-macchiato.tmTheme`
  を利用。

## 関連設定

- 外部コマンド依存が多いため、
  shell 環境や導入ツールとの連携前提。
- Neovim 側では `config/nvim/` の `yazi.lua` からも利用。
