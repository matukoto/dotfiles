# Neovim設定

このディレクトリには[Neovim](https://neovim.io/)（高機能なテキストエディタ）の設定ファイルが含まれています。

## ファイル構成

- `init.lua`: Neovimのメイン設定ファイル
- `after/`: FileType別の設定やLSP設定
  - `ftplugin/`: ファイルタイプごとの設定
  - `lsp/`: LSP（Language Server Protocol）の各言語サーバー設定
- `lua/`: Lua設定モジュール
  - `config/`: 一般設定
  - `lsp/`: LSP関連設定
  - `plugins/`: プラグイン設定
- `plugin/`: プラグインスクリプト
  - `wsl-clipboard.lua`: WSLでのクリップボード連携
  - `abbr.lua`: 略語設定
- `queries/`: TreeSitterクエリ定義

## 主な設定内容

### エディタ設定

- ステータスラインとコマンドライン高さ: 0（tablineに表示）
- 文字コード: UTF-8
- 改行コード: Unix, DOS対応
- 新しいウィンドウ: 下と右に開く
- カーソル行ハイライト: 有効
- 折り畳み: 有効（レベル99）

### インデント設定

- タブ幅: 2スペース
- ソフトタブ: 2スペース
- インデント幅: 2スペース
- スペースでインデント: 有効
- 自動インデント: 有効
- スマートインデント: 有効

### Diff設定

- アルゴリズム: histogram
- インデントヒューリスティック: 有効

### キーマップ

- ビジュアルモードで`p`と`P`を入れ替え（無名レジスタへのコピーを防ぐ）

### LSP対応言語

- Java (jdtls)
- Lua (lua_ls)
- SQL (sqls)
- Go (gopls)
- Svelte
- TypeScript/JavaScript (vtsls, denols, eslint)
- Typos (typos_lsp)

## 参考資料

- [Neovim 公式サイト](https://neovim.io/)
- [Neovim ドキュメント](https://neovim.io/doc/)
- [Neovim GitHub リポジトリ](https://github.com/neovim/neovim)
