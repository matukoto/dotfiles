# mise設定

`~/.config/mise/config.toml` に配備する
ランタイム・CLI バージョン管理設定。

## 主要ファイル

- `config.toml`: mise 本体設定。

## 構成

- 言語ランタイム:
  `java`, `rust`, `go`, `node`, `lua`, `dotnet`。
- 補助ツール:
  `spring-boot`, `wrangler`。
- npm ベース CLI:
  `@marp-team/marp-cli`, `sv`,
  `@actions/languageserver`, `md-to-pdf`。
- `experimental = false` の安定寄り設定。

## 関連設定

- shell での有効化は
  `config/home-manager/fish/config.fish` 内の
  `mise activate fish` で実施。
- Nix で入れるツールと、mise で固定するツールの役割分担あり。
