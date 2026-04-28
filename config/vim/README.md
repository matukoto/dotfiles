# Vim設定

`~/.config/vim` に配備する Vim 設定。  
Vim 本体の設定は `vimrc` に集約。
補助データは周辺ディレクトリへ分離。

## 構成

- `vimrc`: 基本設定、キーマップ、Jetpack の bootstrap、
  各プラグイン設定をまとめた中心ファイル。
- `pack/jetpack/`: `vim-jetpack` 本体。
  プラグインマネージャー本体の同梱先。
- `gitmessage`: Git のコミットテンプレート。
  `config/home-manager/modules/git.nix` から参照。
- `dadbod-ui/connections.json`:
  `vim-dadbod-ui` 用の接続情報。
- `sonictemplate/`: `vim-sonictemplate` で使うテンプレート。
  現在は `markdown` と `typescript` を配置。
- `cheatSheet/default.md`: エディタ内で参照する
  メモ・チートシート。

## プラグイン管理

- プラグインマネージャーは `vim-jetpack`。
- `vimrc` 起動時に
  `~/.vim/pack/jetpack/opt/vim-jetpack/plugin/jetpack.vim`
  を確認し、なければ自動取得。
- Vim の設定本体は `~/.config/vim` に置きつつ、
  Jetpack のベースディレクトリは `~/.vim` を使う構成。

## 主なプラグインと役割

- **日本語入力 / Denops**:
  `denops.vim`, `vim-kensaku`, `vim-kensaku-search`, `skkeleton`,
  `skkeleton-state-popup` が日本語検索と SKK 入力を担当。
  辞書・候補表示・Deno ベースの補助設定も `vimrc` 側で実施。
- **Git / 差分**:
  `vim-gin`, `nvim-gin-preview` が `GinStatus`, `GinLog`,
  patch preview などの Git 操作を Vim から扱う構成。
- **ファイラ**:
  `vim-fern`, `fern-preview.vim`, `vim-fern-git-status`,
  `vim-fern-hijack` がファイルツリー、Git 状態表示、
  プレビュー、`netrw` 代替を担当。
- **補完**:
  `ddc.vim`, `pum.vim`, `ddc-ui-pum`, `ddc-source-around`,
  `ddc-source-file`, `ddc-source-buffer`, `ddc-fuzzy` が
  補完 UI と候補ソースを構成。
  `buffer` `file` `around` を組み合わせた補完が中心。
- **編集補助**:
  `CamelCaseMotion`, `vim-surround`, `vim-asterisk`, `capture.vim`,
  `open-browser.vim`, `vim-suda` が移動、検索補助、
  ブラウザ連携、権限昇格保存を担当。
- **Copilot / UI**:
  `github/copilot.vim`, `vimdoc-ja`, `iceberg.vim`, `vim-guise` が
  補完提案、日本語ヘルプ、配色、UI 補助を担当。

## `vimrc` にまとまっている主要設定

- 基本オプション、キーマップ、タブ移動、検索設定
- `Gin` / `Fern` / `ddc` / `skkeleton` の詳細設定
- commit message 編集時のテンプレート補助
- `copilot.vim` のキーマップ
- `iceberg` カラースキームの適用

## 補足

- このディレクトリは Neovim 設定とは別系統で維持。
  Neovim 側の `lazy.nvim` 構成とは独立。
- `gitmessage` や `sonictemplate/` のように、
  プラグイン本体ではなく周辺データを
  同じディレクトリで管理している点が特徴。
