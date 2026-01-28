# Atuin設定

このディレクトリには[Atuin](https://atuin.sh/)（シェル履歴管理ツール）の設定ファイルが含まれています。

## ファイル構成

- `atuin.nu`: Nushell用のAtuin統合スクリプト
- `atuin-receipt.json`: インストール情報

## 概要

Atuinは、シェルの履歴を改善し、より強力な検索と同期機能を提供するツールです。
このディレクトリには、Nushell向けのAtuin統合設定が含まれています。

## 主な機能

### 履歴管理

- セッション管理: 各シェルセッションに一意のIDを割り当て
- コマンド履歴の記録: 実行前と実行後にフックを使用して履歴を記録
- 終了コードの記録: コマンドの成功/失敗を履歴に保存

### Nushell統合

- `_atuin_pre_execution`: コマンド実行前に履歴記録を開始
- `_atuin_pre_prompt`: コマンド実行後に履歴記録を終了
- `_atuin_search_cmd`: Atuin検索機能とNushellの統合

### キーバインド

設定ファイル内でキーバインド用のトークンを使用し、履歴検索のトリガーを制御しています。

## 参考資料

- [Atuin 公式サイト](https://atuin.sh/)
- [Atuin GitHub リポジトリ](https://github.com/atuinsh/atuin)
- [Atuin ドキュメント](https://docs.atuin.sh/)
