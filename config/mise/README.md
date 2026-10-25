# mise設定

`~/.config/mise/config.toml` に配備する
ランタイム・CLI バージョン管理設定。

## 主要ファイル

- `config.toml`: mise 本体設定。

## 構成

- 言語ランタイム:
  `java`, `rust`, `go`, `node`, `lua`, `dotnet`。
- 補助ツール:
  `npm`, `pnpm`, `wrangler`。
- npm ベース CLI:
  `bash-language-server`, `vscode-langservers-extracted`,
  `yaml-language-server`, `fixjson`, `markdownlint-cli2`, `sql-formatter`。
- Go backend: `github.com/sqls-server/sqls`。
  Apple Silicon では Go からビルドし、Rosetta に依存せず導入する。
- 追加した LSP / formatter は 2026-10-25 に公式配布元の最新安定版を確認して固定。
- GitHub backend は使用しない。
- `typos-lsp`、LemMinX、jdtls、Lombok の追加は保留。
- `experimental = false` の安定寄り設定。

## 運用

`config.toml` を `~/.config/mise/config.toml` に配備した後に実行:

```bash
mise install
```

npm 系 CLI の実行には Node.js、`sqls` のビルドには Go が必要。
どちらも同じ設定で管理する。
`sqls` の SQLite ドライバーを使う場合は C コンパイラも必要。
プロジェクト側で Node.js を切り替える場合は、利用する CLI の対応バージョンも確認する。

## 関連設定

- shell での有効化は
  `config/home-manager/fish/config.fish` 内の
  `mise activate fish` で実施。
- Nix で入れるツールと、mise で固定するツールの役割分担あり。
