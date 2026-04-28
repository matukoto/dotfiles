# yamlfmt設定

`~/.config/yamlfmt/yamlfmt.yaml` に配備する
YAML formatter 設定。

## 主要ファイル

- `yamlfmt.yaml`: yamlfmt 設定本体。

## 構成

- `type: basic` の基本 formatter。
- 改行コードは `lf` 固定。
- 空行保持 (`retain_line_breaks`) を有効化。
- `include_document_start: false` による
  `---` の自動付与抑止。
- `eof_newline: true` による末尾改行維持。

## 関連設定

- `config/nvim/lua/plugins/conform.lua` から利用。
- 本体バイナリは `config/home-manager/home.nix` で導入。
