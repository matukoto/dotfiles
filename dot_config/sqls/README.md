# sqls設定

このディレクトリには[sqls](https://github.com/sqls-server/sqls)（SQL Language Server）の設定ファイルが含まれています。

## ファイル構成

- `config.yml`: sqlsのメイン設定ファイル

## 主な設定内容

### データベース接続

設定ファイルには、以下のデータベース接続情報が含まれています：

- **エイリアス**: my-postgresql-server
- **ドライバー**: postgresql
- **接続先**: localhost:5432
- **ユーザー**: postgres
- **データベース**: postgres

### その他の設定

- `lowercaseKeywords`: false（SQLキーワードを小文字にしない）

## 概要

sqlsは、SQLのためのLanguage Serverで、補完、定義へのジャンプ、リンティングなどの機能を提供します。
PostgreSQL、MySQL、SQLiteなどの主要なデータベースに対応しています。

## 参考資料

- [sqls GitHub リポジトリ](https://github.com/sqls-server/sqls)
