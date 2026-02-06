# StyLua設定

このディレクトリには[StyLua](https://github.com/JohnnyMorganz/StyLua)（Luaコードフォーマッター）の設定ファイルが含まれています。

## ファイル構成

- `stylua.toml`: StyLuaのメイン設定ファイル

## 主な設定内容

### フォーマット設定

- **列幅**: 140文字
- **改行コード**: Unix (LF)
- **インデント**: スペース2つ
- **引用スタイル**: 自動（シングルクォート優先）
- **関数呼び出しの括弧**: 常に使用

## 概要

StyLuaは、一貫したコーディングスタイルを維持するためのLuaコードフォーマッターです。
この設定は、Neovim公式の`.stylua.toml`を参考にしています。

## 参考資料

- [StyLua GitHub リポジトリ](https://github.com/JohnnyMorganz/StyLua)
- [Neovim .stylua.toml](https://github.com/neovim/neovim/blob/master/.stylua.toml)
