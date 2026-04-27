# Neovim設定

`~/.config/nvim` に配備する Neovim 設定。  
設定ファイル本体はこのディレクトリで管理。
LSP / formatter / CLI バイナリ本体は
主に `config/home-manager/home.nix` から導入。

## 構成

- `init.lua`: 基本オプション、キーマップ、autocmd、
  `lazy.nvim` の起動処理。
- `lua/config/lazy.lua`: `lazy.nvim` の bootstrap と、
  `lua/plugins/*.lua` の読み込み一覧。
- `lua/plugins/`: プラグインごとの spec と設定。
  カテゴリ単位ではなく 1 ファイル 1 プラグイン寄りの分割。
- `after/lsp/`: `gopls`、`nixd`、`denols` などの
  LSP 個別設定。
- `after/ftplugin/`: `markdown`、`csv`、`java` など
  filetype ごとの追加設定。
- `plugin/`: 起動時に読み込む軽量スクリプト。
  略語展開や WSL クリップボード連携の置き場。
- `queries/`: Tree-sitter の追加 query。

## プラグイン管理

- プラグインマネージャーは `lazy.nvim`。
- `lua/config/lazy.lua` で stable ブランチの `lazy.nvim` を
  bootstrap し、`lua/plugins/*.lua` を import。
- プラグイン設定の実体は `lua/plugins/` 側。使うものだけを `spec` で読み込み。

## 主なプラグインと役割

- **LSP / 補完**:
  `lspconfig.lua`, `blink.lua`, `lspsaga.lua`, `lspui.lua`, `lazydev.lua`
  を中心に、Nix で導入した LSP を Neovim から有効化。
  補完 UI と参照 UI の集約。
- **Formatter / Lint**:
  `conform.lua` が `stylua` `nixfmt` `yamlfmt`
  `sql_formatter` `markdownlint-cli2` などを
  filetype ごとに切り替え。
  Mason 前提ではなく外部 CLI 利用。
- **Tree-sitter / 編集補助**:
  `treesitter.lua`, `ufo.lua`, `lexima.lua`, `yanky.lua`,
  `dial.lua`, `tiny-code-action.lua` が
  構文解析、fold、補助編集を担当。
- **日本語入力 / Denops**:
  `skkeleton.lua`, `skkeleton_indicator.lua`, `denops.lua` が
  SKK ベースの日本語入力を担当。
  `markdown` のときだけ `keepState` を有効にする挙動もここ。
- **Git / レビュー**:
  `gitsigns.lua`, `diffview.lua`, `gitgraph.lua`, `octo.lua` が
  差分表示、履歴確認、GitHub 上のレビュー補助を担当。
- **ファイラ / ターミナル / セッション**:
  `fern.lua`, `fyler.lua`, `yazi.lua`, `bufterm.lua`,
  `termite.lua`, `auto-session.lua`, `project.lua` が
  ファイル移動、端末操作、セッション復元を担当。
- **UI / 表示**:
  `bufferline.lua`, `lualine.lua`, `noice.lua`, `nvim-notify.lua`,
  `render-markdown.lua`, `colorscheme.lua`, `which-key.lua`,
  `snacks.lua` が表示と操作導線を担当。
- **テスト / 実行**:
  `neotest.lua`, `mini-test.lua`, `overseer.lua`,
  `vim-quickrun.lua` がテスト実行やタスクランナー用途を担当。
- **AI / 補助エージェント**:
  `aibo.lua`, `sidekick.lua` と Copilot LSP が
  チャットや補助提案系の導線を担当。
  Copilot 自体はプラグインより LSP 側の統合を重視。

## 外部ツールとの関係

- LSP サーバーは `config/home-manager/home.nix` で
  `nixd`, `bash-language-server`, `lua-language-server`, `vtsls`,
  `svelte-language-server`, `sqls` などを導入。
- `conform.nvim` から呼ぶ formatter も、同じく Home Manager 側で入れた
  `stylua`, `nixfmt`, `shellcheck`, `shfmt`, `yamlfmt`, `taplo`,
  `typos` などを利用。
- そのため、このディレクトリは
  「Neovim 側の結線と UI 設定」、
  `config/home-manager/` は
  「実行バイナリの配布」を担当。

## 補足

- `after/lsp/` と `after/ftplugin/` を見ると、
  共通設定から外した個別調整の意図を追いやすい構成。
- Neovim の LSP は Mason 前提ではなく Nix / Home Manager 管理。
  新しい LSP を増やすときは、Neovim 側の設定だけでなく
  `config/home-manager/home.nix` も合わせて更新。
