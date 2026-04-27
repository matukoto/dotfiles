# AeroSpace設定

`~/.config/aerospace/aerospace.toml` に配備する
macOS 用タイル型ウィンドウマネージャ設定。

## 主要ファイル

- `aerospace.toml`: 設定本体。

## 構成

- `start-at-login = true` による常駐前提の構成。
- `workspace 1` をメイン表示用、
  `workspace 0` を待避用にした運用。
- `alt-h/j/k/l` の移動、
  `alt-shift-h/j/k/l` のウィンドウ移動、
  `alt-f` のフルスクリーンなど、
  Vim ライク寄りのキーバインド。
- `ctrl-alt-*` から `~/.local/bin/app-toggle` を呼び出し、
  WezTerm / Chrome / Obsidian のトグル起動。
- `on-focus-changed` から
  `~/.local/bin/aerospace-focus-handler` を呼び出し。
- `on-window-detected` で Finder、Slack、Bitwarden、
  Ghostty などをフローティング扱い。

## 関連設定

- `config/sketchybar/` から workspace 表示を受ける前提。
- `config/borders/` と合わせて macOS のウィンドウ外観を構成。
