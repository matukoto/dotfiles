# gitui設定

`~/.config/gitui/key_bindings.ron` に配備する
gitui のキーバインド設定。

## 主要ファイル

- `key_bindings.ron`: gitui キーバインド上書き。

## 構成

- `h/j/k/l` による移動。
- `Ctrl-b` / `Ctrl-f` のページ移動。
- `I` によるファイル編集、
  `U` による status reset、
  `u` / `s` による diff 単位の reset / stage。
- `w` / `m` の stash 操作、
  `M` の merge 中断。

## 補足

- プラグイン構成はなし。
- Vim ライクな操作へ寄せるための上書きが中心。
