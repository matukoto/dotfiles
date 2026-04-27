# WezTerm設定

`~/.config/wezterm` に配備する WezTerm 設定。
外観、leader key、workspace / pane 操作の定義。

## 主要ファイル

- `wezterm.lua`: 外観、イベント、タブ表示の基本設定。
- `keybinds.lua`: キーバインドと key table 定義。

## 構成

- `HackGen Console NF` と `Eva Dim (base16)` の組み合わせ。
- 透過背景、スクロールバー、IME、有効化済みタブバー設定。
- `ALT-j` を leader key とする構成。
- タブタイトルは
  `プロセス名 + カレントディレクトリ名` で整形。
- bell 発生時は toast notification を表示。

## キーバインド

- workspace launcher / rename / create。
- tab の移動、並べ替え、追加、削除。
- pane の分割、移動、zoom、選択。
- `copy_mode` key table による
  Vim ライクな移動と選択。
- command palette、設定再読み込み、
  pane resize table の定義。

## 補足

- プラグイン構成はなし。
- キーバインドの責務を `keybinds.lua` へ分離した構成。
