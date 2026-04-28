# jdtls設定

`~/.config/jdtls` に配備する Java 関連設定。

## 主要ファイル

- `google-java-format.xml`: Google Java Style ベースの
  formatter プロファイル。

## 構成

- Eclipse / jdtls 系 formatter で読める XML 形式。
- 既存改行を潰さない `join_wrapped_lines = false` の調整あり。
- Java の整形方針を
  Google Style 寄りで固定する用途。

## 関連設定

- 実際の jdtls 本体は
  `config/home-manager/home.nix` から導入。
- Neovim 側では `config/nvim/` の Java / LSP 設定と連携。
