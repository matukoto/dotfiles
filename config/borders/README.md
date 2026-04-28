# borders設定

`~/.config/borders/bordersrc` に配備する
macOS 用 window border ツール設定。

## 主要ファイル

- `bordersrc`: `borders` コマンドに渡すオプション定義。

## 構成

- `style=round` による角丸表示。
- `active_color` / `inactive_color` による
  アクティブ状態の色分け。
- `hidpi=on` を含む単一スクリプト構成。

## 関連設定

- `config/aerospace/` と併用する前提の外観設定。
- インストール自体は
  `config/home-manager/darwin-homebrew.nix` の Homebrew 管理。
