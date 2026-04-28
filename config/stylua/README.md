# StyLua設定

`~/.config/stylua/stylua.toml` に配備する
Lua formatter 設定。

## 主要ファイル

- `stylua.toml`: StyLua 設定本体。

## 構成

- `column_width = 140`。
- スペース 2 のインデント。
- `quote_style = "AutoPreferSingle"` による
  シングルクオート寄り設定。
- `call_parentheses = "Always"` の固定。

## 関連設定

- `config/nvim/lua/plugins/conform.lua` から利用。
- 本体バイナリは `config/home-manager/home.nix` で導入。
