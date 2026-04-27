# SketchyBar設定

`~/.config/sketchybar` に配備する SketchyBar 設定。
AeroSpace の workspace 表示に特化した最小構成。

## 主要ファイル

- `sketchybarrc`: bar 本体設定。
- `plugins/aerospace.sh`: workspace の選択状態表示用 script。

## 構成

- bar の高さ、blur、フォント、padding などの基本外観設定。
- `aerospace_workspace_change` イベントを登録。
- `space.1`, `space.2` の indicator を left 側へ追加。
- click で `aerospace workspace <id>` を実行。
- `plugins/aerospace.sh` から
  `FOCUSED_WORKSPACE` と比較して背景表示を切り替え。

## 関連設定

- `config/aerospace/` から送る workspace 状態と連携。
- Homebrew 側の `sketchybar` 導入は
  `config/home-manager/darwin-homebrew.nix` で管理。
