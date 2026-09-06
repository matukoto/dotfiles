# Neovim プラグイン棚卸し

調査日: 2026-09-06。リポジトリの設定を静的に調査した一覧。
実際の利用頻度・起動時のロード成功・各コマンドの動作は測定していない。
「登録」は利用中という断定ではなく、読み込み対象の spec に含まれることを指す。
設定変更・削除は行っていない。

## 件数と対象

| 区分 | 件数 | 数え方 |
| --- | ---: | --- |
| 直接登録 | 83 | import 66ファイルの主プラグイン + lazy.lua 直書き17件。条件付き3件を含む |
| 設定内で依存としてのみ登録 | 15 | 同じリポジトリの重複を除外 |
| プラグイン側で宣言する追加依存 | 2 | ローカルの nvim-java/lazy.lua で確認 |
| 管理ツール | 1 | lazy.nvim |
| lockfile のエントリ | 101 | 上記83 + 15 + 2 + 1 と一致。実行時ロード数ではない |
| 未 import の設定ファイル | 8 | 上記の登録数には含めない |

読み込み元: [lazy.lua](lua/config/lazy.lua)、[個別設定](lua/plugins/)、
[lockfile](lazy-lock.json)。`lua/plugins/` の全ファイルを一括 import する構成ではない。
`<leader>` は Space。以下のキーは設定上の割り当てで、重複がある場合の実効キーとは限らない。
AI・作業計測の3件は `PRIVATE_PLUGIN_ENABLED` が存在する場合のみ有効
（値の真偽ではなく `os.getenv(...) ~= nil` を判定）。

## 直接登録の一覧（管理ツールを含む）

### 基盤・日本語入力

| プラグイン | 設定から分かる用途・入口 |
| --- | --- |
| [folke/lazy.nvim](lua/config/lazy.lua) | プラグインの導入・依存解決・遅延読み込み。bootstrap で管理。 |
| [vim-denops/denops.vim](lua/config/lazy.lua) | Deno 上で動くプラグインの実行基盤。SKK・Gin・Kensaku・Guise が利用。 |
| [vim-skk/skkeleton](lua/plugins/skkeleton.lua) | SKK 日本語入力。挿入・コマンドライン・端末で `<C-k>` 切り替え。 |
| [delphinus/skkeleton_indicator.nvim](lua/plugins/skkeleton_indicator.lua) | SKK の入力モードをカーソル付近に表示。Sidekick 用の調整あり。 |
| [vim-jp/vimdoc-ja](lua/config/lazy.lua) | 日本語ヘルプ。`init.lua` で日本語を優先。 |
| [shougo/pum.vim](lua/config/lazy.lua) | 補完ポップアップ UI。登録はあるが、使用する ddc 設定は未 import。 |
### 検索・移動・編集

| プラグイン | 設定から分かる用途・入口 |
| --- | --- |
| [folke/snacks.nvim](lua/plugins/snacks.lua) | ファイル・grep・バッファ・診断・LSP シンボル等の検索、ファイラ、端末、画像、インデント、ダッシュボード、バッファ削除。`<leader>f/g/b/e/u` 等。 |
| [lambdalisue/vim-kensaku](lua/config/lazy.lua) | 日本語をローマ字等で検索するための正規表現生成。Snacks の独自ソースが使用。 |
| [lambdalisue/vim-kensaku-search](lua/config/lazy.lua) | Kensaku を検索に連携。登録のみで専用キーマップは未設定。 |
| [kevinhwang91/nvim-hlslens](lua/plugins/hlslens.lua) | 検索結果の位置・件数を表示。`n/N/*/#` に組み込み。 |
| [haya14busa/vim-asterisk](lua/config/lazy.lua) | カーソル下・選択文字列の検索を拡張。hlslens の `*` / `#` が利用。 |
| [atusy/jab.nvim](lua/plugins/jab.lua) | インクリメンタル検索と `f/F/t/T` の移動補助。 |
| [bkad/CamelCaseMotion](lua/plugins/camelcasemotion.lua) | camelCase / snake_case の構成単語単位で移動。 |
| [haya14busa/vim-edgemotion](lua/plugins/vim-edgemotion.lua) | テキストの境界へ上下移動。ノーマルモードの `<C-j>/<C-k>`。 |
| [atusy/treemonkey.nvim](lua/plugins/treemonkey.lua) | Tree-sitter の構文ブロック選択。Visual / operator-pending の `m`。 |
| [cohama/lexima.vim](lua/plugins/lexima.lua) | 括弧・引用符などの自動補完。 |
| [tpope/vim-surround](lua/config/lazy.lua) | 括弧・引用符・タグなどの囲みを追加・変更・削除。 |
| [machakann/vim-sandwich](lua/config/lazy.lua) | 囲みの追加・変更・削除とテキストオブジェクト。 |
| [monaqa/dial.nvim](lua/plugins/dial.lua) | 数値等の増減操作を拡張。`<C-a>/<C-x>`。 |
| [tani/dmacro.nvim](lua/plugins/dmacro.lua) | 繰り返し操作を検出して再実行。`<C-y>`。 |
| [gbprod/yanky.nvim](lua/plugins/yanky.lua) | ヤンク履歴と貼り付け。履歴10件を shada に保存、`<leader>P` で選択。 |
| [mattn/vim-sonictemplate](lua/plugins/vim-sonictemplate.lua) | テンプレート挿入。`:Template` / `:tp`、テンプレートは `~/.config/vim/sonictemplate/`。 |
| [tyru/open-browser.vim](lua/plugins/open-browser.lua) | URL を開く・文字列を Web 検索。`gx`。 |
### LSP・補完・構文解析

| プラグイン | 設定から分かる用途・入口 |
| --- | --- |
| [neovim/nvim-lspconfig](lua/plugins/lspconfig.lua) | LSP サーバーの設定・有効化。LspUI / Lspsaga / Blink に依存し、LspAttach 時にキーを設定。 |
| [saghen/blink.cmp](lua/plugins/blink.lua) | LSP・パス・バッファ・スニペット・コマンドライン補完。SKK 中は専用ソースに切り替え。 |
| [folke/lazydev.nvim](lua/plugins/lazydev.lua) | Neovim Lua 設定の型情報・補完支援。Blink と連携。 |
| [nvimdev/lspsaga.nvim](lua/plugins/lspsaga.lua) | LSP の hover・定義・rename・診断・アウトライン・パンくず表示。Lualine もシンボル表示を参照。 |
| [jinzhongjia/LspUI.nvim](lua/plugins/lspui.lua) | LSP 操作 UI。LspAttach 後の `K/gr/gf/gl/gt` などから利用。signature は無効。 |
| [rachartier/tiny-code-action.nvim](lua/plugins/tiny-code-action.lua) | コードアクションの差分を difftastic でプレビューし、Snacks で選択。`ga`。 |
| [rachartier/tiny-inline-diagnostic.nvim](lua/config/lazy.lua) | 行内診断表示用として登録。`opts/config` がなく、setup 呼び出しは設定内に見当たらない。 |
| [folke/trouble.nvim](lua/plugins/trouble.lua) | 診断・参照・quickfix・TODO の一覧。`<leader>x…` / `gR` に設定あり。 |
| [stevearc/aerial.nvim](lua/plugins/aerial.lua) | 関数・クラス・Markdown 見出しなどのアウトライン。`<leader>aa`。 |
| [nvim-treesitter/nvim-treesitter](lua/plugins/treesitter.lua) | 構文パーサーの導入、ハイライト、インデント、標準 foldexpr の設定。 |
| [nvim-treesitter/nvim-treesitter-context](lua/config/lazy.lua) | 現在位置を囲む関数等の構文コンテキスト表示用として登録。個別設定なし。 |
| [kevinhwang91/nvim-ufo](lua/plugins/ufo.lua) | Tree-sitter / indent による折り畳み、`zR/zM/zr/zm` の拡張。 |
| [windwp/nvim-ts-autotag](lua/plugins/nvim-ts-autotag.lua) | HTML 等のタグの自動閉じ・連動変更。 |
| [stevearc/conform.nvim](lua/plugins/conform.lua) | filetype・プロジェクト設定に応じた整形。保存時と手動の format。 |
| [nvim-java/nvim-java](lua/plugins/nvim-java.lua) | Java / JDTLS 統合。Lombok・Java test・Spring Boot 有効、Java debug adapter と JDK 自動導入は無効。 |
### ファイル・ウィンドウ・セッション

| プラグイン | 設定から分かる用途・入口 |
| --- | --- |
| [lambdalisue/vim-fern](lua/plugins/fern.lua) | ツリー型ファイラ。`<leader>e/E/ce`、プレビュー・Git 状態・アイコン拡張あり。 |
| [A7Lavinraj/fyler.nvim](lua/plugins/fyler.lua) | ファイルツリーの閲覧・編集。`opts = {}`、独自キー設定なし。 |
| [mikavilpas/yazi.nvim](lua/plugins/yazi.lua) | 外部ファイラ Yazi の統合。`<leader>y`。 |
| [tkmpypy/chowcho.nvim](lua/plugins/chowcho.lua) | ラベルを使ったウィンドウ選択。 |
| [simeji/winresizer](lua/config/lazy.lua) | ウィンドウサイズ変更。個別設定なし。 |
| [akinsho/bufferline.nvim](lua/plugins/bufferline.lua) | バッファ一覧のタブライン。`<C-h>/<C-l>` で移動、Gin バッファを除外。 |
| [tiagovla/scope.nvim](lua/plugins/scope.lua) | タブページごとにバッファの範囲を分離。 |
| [DrKJeff16/project.nvim](lua/plugins/project.lua) | `.git` / `package.json` からプロジェクトルートを検出し、cwd を変更。 |
| [rmagatti/auto-session](lua/plugins/auto-session.lua) | セッションの自動保存・復元。Git ブランチ別に保存・切り替え。 |
| [ethanholz/nvim-lastplace](lua/plugins/nvim-lastplace.lua) | ファイルを開き直したときのカーソル位置復元。 |
### Git・GitHub

| プラグイン | 設定から分かる用途・入口 |
| --- | --- |
| [lambdalisue/vim-gin](lua/plugins/gin.lua) | Git status・stage・commit・push・log・branch・patch。`<C-g>…`、独自のフローティングプレビューあり。 |
| [lewis6991/gitsigns.nvim](lua/plugins/gitsigns.lua) | 変更行の印、行 blame、hunk 移動・stage・選択。 |
| [sindrets/diffview.nvim](lua/plugins/diffview.lua) | Git 差分を専用画面で表示。`<C-g>d`。Gitgraph からも利用。 |
| [isakbm/gitgraph.nvim](lua/plugins/gitgraph.lua) | コミットグラフ表示。コミット選択時に Diffview を開く。 |
| [matukoto/fm-nvim](lua/plugins/fm-nvim.lua) | この設定では Gitui / Lazygit をフローティング起動。`:G` は Gitui の略語。 |
| [pwntester/octo.nvim](lua/plugins/octo.lua) | GitHub Issue / PR / Discussion / 通知の閲覧・操作。Snacks picker と連携。 |
### ターミナル・実行・テスト・DB

| プラグイン | 設定から分かる用途・入口 |
| --- | --- |
| [boltlessengineer/bufterm.nvim](lua/plugins/bufterm.lua) | 標準 `:terminal` を含む端末バッファ管理。挿入モード移行・終了時の処理を設定。 |
| [ruicsh/termite.nvim](lua/plugins/termite.lua) | 端末パネルの作成・切り替え・最大化・編集。`<C-/>`、`<C-t>` 等。 |
| [chomosuke/term-edit.nvim](lua/plugins/term-edit.lua) | 端末のコマンド行をノーマルモードの編集操作で扱う。プロンプト末尾を `%$ ` と指定。 |
| [lambdalisue/vim-guise](lua/config/lazy.lua) | 端末・ジョブから起動する Vim/Neovim を、既存インスタンスの新しいタブで開く。 |
| [stevearc/overseer.nvim](lua/plugins/overseer.lua) | ビルド等のタスク実行・出力管理。`<leader>r/R`。 |
| [thinca/vim-quickrun](lua/plugins/vim-quickrun.lua) | 現在のコードを手軽に実行。`:QuickRun` / `:qr`。 |
| [nvim-neotest/neotest](lua/plugins/neotest.lua) | テスト実行・結果表示。Vitest と Plenary adapter、`<leader>tn/tf/ta/ts/to`。 |
| [echasnovski/mini.test](lua/plugins/mini-test.lua) | Neovim Lua 向けテストフレームワーク。デフォルト setup、独自テスト設定なし。 |
| [tpope/vim-dadbod](lua/config/lazy.lua) | DB 接続・SQL 実行の基盤。 |
| [kristijanhusak/vim-dadbod-ui](lua/plugins/vim-dadbod-ui.lua) | DB 接続・クエリ・結果の UI。`:DBUI`、クエリ保存 `<leader>w`。 |
### 表示・補助機能

| プラグイン | 設定から分かる用途・入口 |
| --- | --- |
| [nvim-lualine/lualine.nvim](lua/plugins/lualine.lua) | この設定では winbar に mode・branch・診断・差分・シンボル・位置を表示。statusline の sections は空。 |
| [folke/noice.nvim](lua/plugins/noice.lua) | コマンドライン・メッセージ・補完メニュー・LSP progress の表示を調整。 |
| [rcarriga/nvim-notify](lua/plugins/nvim-notify.lua) | 通知表示。`vim.notify` を差し替え。 |
| [folke/which-key.nvim](lua/plugins/which-key.lua) | キー入力候補・キーマップ一覧。`<leader>?`。 |
| [MeanderingProgrammer/render-markdown.nvim](lua/plugins/render-markdown.lua) | Markdown の見出し・表等をバッファ内で装飾。 |
| [mechatroner/rainbow_csv](lua/plugins/rainbow-csv.lua) | CSV の列を色分けし、表形式データを扱う。 |
| [uga-rosa/ccc.nvim](lua/plugins/ccc.lua) | カラーピッカー、色表記変換、色コードのハイライト。`<leader>ccp/ccc/cct`。 |
| [gen740/SmoothCursor.nvim](lua/plugins/smoothcursor.lua) | カーソル移動の視覚効果。 |
| [0xAdk/full_visual_line.nvim](lua/plugins/full_visual_line.lua) | 行単位 Visual モードのハイライトを行全幅に広げる。 |
| [itchyny/vim-cursorword](lua/config/lazy.lua) | カーソル下と同じ単語を強調。 |
| [folke/todo-comments.nvim](lua/plugins/todo-comments.lua) | TODO / FIXME 等を強調・検索。`<leader>st` で Snacks に表示。 |
| [stevearc/quicker.nvim](lua/plugins/quicker.lua) | quickfix の編集・前後行の展開・折り畳み。 |
| [kevinhwang91/nvim-bqf](lua/config/lazy.lua) | quickfix のプレビュー等の操作補助。個別設定なし。 |
| [tyru/capture.vim](lua/config/lazy.lua) | Ex コマンドの出力をバッファに取得。`init.lua` に `:cm` 略語設定。 |
| [lambdalisue/vim-suda](lua/config/lazy.lua) | 権限付きでファイルを書き込むための補助。`SudaWrite` で読み込み。 |
| [sainnhe/edge](lua/plugins/colorscheme.lua) | カラースキーム。`colorscheme edge` を明示的に適用。 |
| [neko-night/nvim](lua/config/lazy.lua) | 追加のカラースキーム。登録のみで適用指定なし。 |
### AI・作業計測（条件付き）

| プラグイン | 設定から分かる用途・入口 |
| --- | --- |
| [lambdalisue/nvim-aibo](lua/plugins/aibo.lua) | AI CLI を端末・プロンプトから操作。この設定では opencode の継続起動・選択送信。 |
| [folke/sidekick.nvim](lua/plugins/sidekick.lua) | AI CLI の切り替え・ファイル/選択範囲送信・次の編集提案。SKK 用の独自入力画面あり。 |
| [wakatime/vim-wakatime](lua/plugins/wakatime.lua) | 編集作業時間の記録。 |

## 依存プラグイン

以下15件は、この設定で主プラグインとしては登録されず、dependencies 経由で登録される。

| プラグイン | 用途・設定内の参照元 |
| --- | --- |
| Xantibody/blink-cmp-skkeleton | Blink と SKK の補完連携。blink.lua |
| nvim-tree/nvim-web-devicons | ファイル種別アイコン。Aerial、Bufferline、LSP UI、Lualine、Markdown、Trouble、Octo |
| nvim-mini/mini.icons | アイコン。Fyler |
| nvim-lua/plenary.nvim | 共通 Lua ユーティリティ。Neotest、Yazi、Tiny Code Action、Octo |
| MunifTanjim/nui.nvim | UI 部品。Noice（nvim-java 側からも参照） |
| kevinhwang91/promise-async | 非同期処理。UFO |
| nvim-neotest/nvim-nio | 非同期処理。Neotest |
| antoinemadec/FixCursorHold.nvim | CursorHold イベント補助。Neotest |
| marilari88/neotest-vitest | Vitest のテスト実行 adapter。Neotest |
| nvim-neotest/neotest-plenary | Plenary のテスト実行 adapter。Neotest |
| yuki-yano/fern-preview.vim | Fern のファイルプレビュー |
| lambdalisue/vim-fern-hijack | ディレクトリを開く処理を Fern に接続 |
| lambdalisue/vim-nerdfont | Fern 用の Nerd Font アイコン基盤 |
| lambdalisue/vim-fern-git-status | Fern に Git 状態を表示 |
| lambdalisue/fern-renderer-nerdfont.vim | Fern の Nerd Font renderer |

追加の2件は dotfiles 内に有効な依存宣言がないが、インストール済みの
`~/.local/share/nvim/lazy/nvim-java/lazy.lua` に依存宣言があり、lockfile にも存在する。
残骸と判断して削除する対象ではない。

| プラグイン | 用途・参照元 |
| --- | --- |
| mfussenegger/nvim-dap | デバッグ用 DAP クライアント。nvim-java の依存。Java debug adapter の無効化とは別の登録 |
| JavaHello/spring-boot.nvim | Spring Boot の言語支援。nvim-java の依存 |

Denops、Tree-sitter、Snacks、Blink、SKK、Diffview、Dadbod、vim-asterisk、LSP UI 等は、
直接登録と依存登録の両方に現れるが、件数は重複させていない。

## 設定ファイルはあるが読み込まれていないもの

| 設定 | プラグイン | 用途 | 現状 |
| --- | --- | --- | --- |
| [aider.lua](lua/plugins/aider.lua) | nekowasabi/aider.vim | Aider 起動・ファイル/選択送信 | import なし。環境変数条件もあり |
| [claudecode.lua](lua/plugins/claudecode.lua) | coder/claudecode.nvim | Claude Code と選択・ファイル・端末を連携 | import なし。環境変数条件もあり |
| [codecompanion.lua](lua/plugins/codecompanion.lua) | olimorris/codecompanion.nvim | Copilot adapter によるチャット・インライン編集 | import なし。環境変数条件もあり |
| [ddc.lua](lua/plugins/ddc.lua) | shougo/ddc.vim | Denops 補完。pum UI と SKK を利用 | import なし |
| [flash.lua](lua/plugins/flash.lua) | folke/flash.nvim | ラベルジャンプ・構文選択 | import なし |
| [nvim-lint.lua](lua/plugins/nvim-lint.lua) | mfussenegger/nvim-lint | 外部 linter 実行 | import をコメントアウト |
| [tint.lua](lua/plugins/tint.lua) | levouh/tint.nvim | 非アクティブウィンドウを暗くする | import をコメントアウト |
| [waitevent.lua](lua/plugins/waitevent.lua) | notomo/waitevent.nvim | 外部 EDITOR / GIT_EDITOR を既存 Neovim に接続 | import をコメントアウト |

未 import の設定内には `zbirenbaum/copilot.lua`（CodeCompanion の依存）、
`shougo/ddc-ui-pum`（ddc の依存）もある。これらも現在の有効な登録には含まれない。
これら8ファイルの削除は設定整理にはなるが、現在のロード対象削減にはならない。

## 削減を検討するときの確認点

ここでは役割の重複・参照関係だけを示す。残すものは実際に使う操作に基づいて判断する。

| 対象 | 重複・確認事項 |
| --- | --- |
| Fern / Fyler / Yazi / Snacks explorer | ファイルの閲覧・移動が4系統。Fern は専用依存5件、Fyler は mini.icons を伴う。Yazi は外部 CLI との統合という違いがある |
| Lspsaga / LspUI / Tiny Code Action / Snacks LSP picker | hover・定義・参照・rename・code action が複数系統。lspconfig の dependencies と LspAttach、Lualine の参照も合わせて整理が必要 |
| Aerial / Lspsaga outline / Snacks symbols | シンボル一覧・アウトラインの入口が複数ある。常設ツリーが必要か、検索で足りるかを確認 |
| Trouble / Quicker / nvim-bqf / Snacks diagnostics・qflist | 診断・quickfix の閲覧が重複。一方 Quicker の編集・前後行表示と bqf のプレビューは役割が異なる |
| Termite / Snacks terminal / Bufterm | 端末の起動・切り替え・管理が重複。Bufterm は標準端末にも作用。Term-edit は入力編集、Guise は外部エディタ接続で別用途 |
| vim-surround / vim-sandwich | 囲みの追加・変更・削除が重複。使っているキーとテキストオブジェクトを確認 |
| Gin / fm-nvim（Gitui・Lazygit） / Diffview / Gitgraph | Git の操作・履歴・差分が複数系統。Gitgraph は Diffview に依存。Gin は独自プレビューの設定もある |
| UFO / 標準 Tree-sitter foldexpr | treesitter.lua ですでに標準折り畳みを設定。UFO 独自の折り畳み操作を使っているか確認 |
| nvim-lastplace / init.lua の mkview・loadview | ファイル再表示時の位置復元が重なる可能性。fold・表示状態も含めて比較 |
| QuickRun / Overseer / Neotest / mini.test | 単発実行・タスク管理・テスト結果 UI・テストフレームワークという違いがある。用途のないものを確認 |
| Aibo / Sidekick | AI CLI 起動・選択送信が重複。Aibo の opencode 操作と Sidekick の独自 SKK 入力画面を比較 |
| edge / neko-night/nvim | 明示的に適用するテーマは edge。追加テーマを切り替えて使っているか確認 |
| pum.vim | 有効な補完は Blink。設定内の pum API 呼び出しは未 import の ddc.lua にあるため、現在の必要性を確認する候補 |
| tiny-inline-diagnostic / treesitter-context | 登録のみで個別 setup 設定なし。登録されていることと期待する表示が有効であることを分けて確認 |
| SmoothCursor / full_visual_line / cursorword / ccc / WakaTime | 独立した視覚補助・計測。日常的に必要な機能かを判断しやすい |

### キーマップ上の重複

- `<leader>e`: Fern と Snacks explorer が同じノーマルモードのキーを登録。
- `ga`: Lspsaga が normal / visual に、Tiny Code Action が normal に登録。
- `K`, `gd`, `gr`: Lspsaga / Snacks のグローバル設定と、lspconfig のバッファローカル設定が重なる。
  LspAttach 後はバッファローカルの設定が優先される。
  特に `gr` は Snacks では参照、LspUI 側では rename。
- `gD`: Snacks では宣言へ移動、LspAttach 後は縦分割して定義へ移動。
- `<leader>p`: init.lua ではクリップボード貼り付け、Snacks ではプロジェクト選択。
- Visual の `p/P`: init.lua での入れ替えと Yanky の貼り付け割り当てが重なる。

### 削除時に一緒に確認する参照

- [lspconfig.lua](lua/plugins/lspconfig.lua): Lspsaga / LspUI は import だけ外しても dependencies 経由の登録が残る。
- [lualine.lua](lua/plugins/lualine.lua): Lspsaga のパンくず情報を取得している。
- [gitgraph.lua](lua/plugins/gitgraph.lua): Diffview の依存宣言と起動フックがある。
- [blink.lua](lua/plugins/blink.lua): SKK / Denops / blink-cmp-skkeleton の依存とソース切り替えがある。
- [gin_preview.lua](lua/config/gin_preview.lua) と [ADR](../../docs/adr/0001-neovim-gin-floating-preview.md): Gin 専用のフローティングプレビュー実装と設計記録。
- [snacks.lua](lua/plugins/snacks.lua): Gin・セッション復元・Kensaku 等を呼ぶ操作がある。
- [init.lua](init.lua): プラグイン設定外にもキー・略語・位置復元がある。

依存ライブラリは共有されているので、主プラグイン1件を消すとその依存も全部消せるとは限らない。
また、`event = 'VeryLazy'` が多数あるため、プラグイン数と起動コストは別途評価する必要がある。
