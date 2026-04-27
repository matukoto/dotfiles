# sqls設定

`~/.config/sqls/config.yaml` に配備する
SQL Language Server (`sqls`) 設定。

## 主要ファイル

- `config.yaml`: `sqls` の接続定義と表示設定。

## 構成

- `lowercaseKeywords: false` による
  SQL キーワードの大文字維持寄り設定。
- `my-postgresql-server` という alias の
  PostgreSQL 接続定義。

## 関連設定

- `sqls` 本体は `config/home-manager/home.nix` から導入。
- エディタ側では `config/nvim/` の LSP 設定と連携。
