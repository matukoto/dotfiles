# Mise設定

このディレクトリには[mise](https://mise.jdx.dev/)（開発ツールのバージョン管理ツール）の設定ファイルが含まれています。

## ファイル構成

- `config.toml`: miseのメイン設定ファイル

## 概要

miseは、プログラミング言語のランタイムや開発ツールのバージョンを管理するツールです。
asdfやnvm、rbenvなどの複数のツールを統一的に管理できます。

## 管理されているツール

### 言語ランタイム

- **Java**: Corretto 17.0.14.7
- **Rust**: 1.93.0
- **Go**: 1.25.6
- **Node.js**: 24.13.0
- **Lua**: 5.4.8
- **.NET**: 10.0.102

### NPMパッケージ

- vite: 7.3.1
- vitest: 4.0.18
- zenn-cli: 0.4.1
- @marp-team/marp-cli: latest
- sv: 0.11.3
- tsx: 4.21.0
- playwright: 1.57.0
- @modelcontextprotocol/inspector: 0.18.0
- @openapitools/openapi-generator-cli: latest

### その他のツール

- gemini-cli: 0.25.1
- spring-boot: 3.5.3

## 設定

- `experimental`: false（実験的機能は無効）

## 参考資料

- [mise 公式サイト](https://mise.jdx.dev/)
- [mise ドキュメント](https://mise.jdx.dev/getting-started.html)
