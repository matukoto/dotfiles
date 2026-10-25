# 全 Neovim プラグインの設定用途

調査日: 2026-09-08。**プラグインごとに、この dotfiles で何のために設定しているか**をまとめた一覧。
一般的な全機能紹介ではなく、個別設定・キー・呼び出し元を根拠にしている。
設定があることと、日常的に利用していること・実行時に正常動作することは区別する。

## 対象と状態

- `lua/plugins/*.lua` の **74ファイルすべて**（読み込み対象66、未読込8）。
- `lua/config/lazy.lua` の直接登録17件、管理ツール1件。
- 設定内の依存専用15件、nvim-java 側の追加依存2件、未読込設定の依存専用2件。
- `lua/plugins/snacks/sources/kensaku.lua` と、init/ftplugin 等の補助設定。

「読込対象」は spec に含まれるという意味で、起動時ロード済みとは限らない。
「条件付き」は `PRIVATE_PLUGIN_ENABLED` の存在で判定する Aibo / Sidekick / WakaTime。
「未読込」は import がないため、この設定のままではそのプラグインの用途・競合は発生しない。
ただし Aibo のキー定義には import 時の副作用がある。
`<leader>` は Space。キーは指定がなければ主に normal、画面専用キーはそのバッファ内の操作。

重複欄では **機能の重なり、キーの競合、依存による連携**を区別した。
「同じ分野」だけで削減可能とは判断していない。
[LSP の機能別照合・削減案](PLUGIN_DUPLICATION_REVIEW.md) と
[件数・登録全体の棚卸し](PLUGIN_INVENTORY.md)も参照。

## 個別設定74ファイル（ファイル名順）

### A–F

| 設定・プラグイン | 状態 | この設定での用途・具体的な操作 | 重複・連携・注意点 |
| --- | --- | --- | --- |
| [aerial.lua](lua/plugins/aerial.lua)<br>stevearc/aerial.nvim | 読込対象 | コードの階層・シンボルを左寄りのツリーで見て移動。`<leader>aa`、分割ジャンプ、Tree-sitter 優先。`open_automatic=false` だが Markdown ftplugin に `FileType markdown AerialOpen` がある。 | Lspsaga outline / Snacks symbols と一覧用途が重複。`<leader>aa` は Sidekick と衝突。Markdown の自動表示入口も削除時に確認。 |
| [aibo.lua](lua/plugins/aibo.lua)<br>lambdalisue/nvim-aibo | 条件付き | opencode を `--continue` でタブ/縦分割起動（normal `<leader>at/av`）、Visual `<leader>as` で選択送信。専用入力欄で送信・上下移動・Esc を中継。 | Sidekick と AI CLI 操作・文脈送信が重複。normal `<leader>at` が衝突。`opts.keys` 内の keymap 呼び出しは import 時に実行される。 |
| [aider.lua](lua/plugins/aider.lua)<br>nekowasabi/aider.vim | 未読込 | Aider を自動コミットなし、100×20 の float で使用する設定。ファイル・読み取り専用ファイル・URL・Visual 選択を追加。 | 未読込。Aibo / Sidekick と AI 操作用途が重複する旧設定。同じ `<leader>aI` を ignore 表示と paste に二度設定。 |
| [auto-session.lua](lua/plugins/auto-session.lua)<br>rmagatti/auto-session | 読込対象 | 作業セッションを自動作成・保存・復元。Git ブランチ別に保存しブランチ変更でも復元。cwd 変更への自動追従はオフ、Snacks dashboard から検索入口あり。 | Lastplace / mkview と復元の一部が重なるが、セッション全体と単一ファイルの表示状態は別対象。session_lens の delete_session キーは同じフィールドを二度定義。 |
| [blink.lua](lua/plugins/blink.lua)<br>saghen/blink.cmp | 読込対象 | LSP・パス・全バッファ・スニペット・Lua 型情報の補完、コマンドライン補完。SKK 中は専用ソースだけを使用。候補自動挿入、`<C-j>` 確定、説明を1秒後表示、signature 有効。 | Noice と signature 自動表示が重複。ddc は未読込なので現在の二重補完ではない。Lexima とは括弧を扱うが補完確定/文字入力でトリガーが違う。 |
| [bufferline.lua](lua/plugins/bufferline.lua)<br>akinsho/bufferline.nvim | 読込対象 | バッファをタブラインに常時表示し `<C-h>/<C-l>` で巡回。LSP 診断・アイコンを表示し Gin URI バッファを一覧から除外。 | Snacks buffers とバッファ選択の用途が重複。Lualine と診断情報は重なるが表示位置が違う。Scope はタブ別のバッファ管理として補完。 |
| [bufterm.lua](lua/plugins/bufterm.lua)<br>boltlessengineer/bufterm.nvim | 読込対象 | 標準 `:terminal` も管理対象にし、挿入モードで開始、終了後のバッファ処理を設定。モード記憶と端末内 Ctrl-w 拡張はオフ。 | Termite / 標準端末起動関数と挿入モード移行が重なる。端末起動キー自体はこのファイルにない。 |
| [camelcasemotion.lua](lua/plugins/camelcasemotion.lua)<br>bkad/CamelCaseMotion | 読込対象 | camelCase 等の構成単語単位で移動するため、キー prefix を `[` に指定。通常の `w/b/e` を置き換える例はコメントのまま。 | Jab / Edgemotion と移動補助という目的は近いが、対象は単語内部。標準単語移動を無条件に置き換えてはいない。 |
| [ccc.lua](lua/plugins/ccc.lua)<br>uga-rosa/ccc.nvim | 読込対象 | 色コードを自動ハイライトし LSP の色情報も使用。`<leader>ccp` で色選択、`ccc` で表記変換、`cct` で強調切り替え。 | 他に色選択・変換の同一設定なし。Rainbow CSV / テーマとは色を付ける対象が異なる。 |
| [chowcho.lua](lua/plugins/chowcho.lua)<br>tkmpypy/chowcho.nvim | 読込対象 | `<leader><leader>` でウィンドウをラベル選択。A/S/D/F…を使い、一部 nofile 画面を除外。 | init.lua の方向別ウィンドウ移動と目的は同じだが選択方法が違う。Winresizer はサイズ調整で別用途。 |
| [claudecode.lua](lua/plugins/claudecode.lua)<br>coder/claudecode.nvim | 未読込 | Claude Code の起動・再開・選択/ファイル送信と、`claudecode://prompt` の独自 Markdown 入力欄を設定。 | 未読込。Aibo / Sidekick と CLI 統合、Sidekick と専用入力欄が類似。`config` が `setup()` に opts を渡しておらず、記載した右分割等の opts はこの呼び出しでは適用されない。 |
| [codecompanion.lua](lua/plugins/codecompanion.lua)<br>olimorris/codecompanion.nvim | 未読込 | Copilot adapter で chat/inline 編集。`<leader>ca/cc/ci`、設定上のモデルは claude-3.7-sonnet。DEBUG ログを指定。 | 未読込。AI 対話・選択編集は他の AI 系と重なるが、CLI 起動ではなく adapter 経由の方式。 |
| [colorscheme.lua](lua/plugins/colorscheme.lua)<br>sainnhe/edge | 読込対象 | edge を明示適用。neon スタイル、italic、非アクティブウィンドウの減光を設定。 | neko-night は追加テーマ登録。減光は未読込の Tint と用途が重なるが、現在の二重稼働ではない。 |
| [conform.lua](lua/plugins/conform.lua)<br>stevearc/conform.nvim | 読込対象 | 保存時整形と `<leader>cf` の手動整形。JS 系は Biome→ESLint→Prettier の設定ファイル判定、TS 系は package.json がなければ deno_fmt。Markdown はコードブロック・typos・markdownlint。Java は LSP fallback、`:w!` は整形省略。 | LSP 整形と連携するが既定は lsp_format=never で二重実行ではない。typos_lsp と指摘対象は重なるが診断/修正の違い。nvim-lint は未読込。 |
| [ddc.lua](lua/plugins/ddc.lua)<br>shougo/ddc.vim | 未読込 | SKK 候補専用の補完設定。pum UI、最大10件、1文字から候補表示。挿入時 `<C-n/p/y/e>` を候補移動/確定/中止に割り当て。 | 未読込。Blink の SKK 補完と用途重複。再有効化すると候補キーも競合し得る。 |
| [denops.lua](lua/plugins/denops.lua)<br>vim-denops/denops.vim | 読込対象 | SKK・Gin・Kensaku・Guise の Deno 実行基盤。起動時に読み込み、FFI/KV とファイル・環境・ネットワーク・git/delta 実行権限を指定。 | 依存するプラグインとの重複ではなく共通基盤。1個の利用元削除だけでは除去できない。 |
| [dial.lua](lua/plugins/dial.lua)<br>monaqa/dial.nvim | 読込対象 | normal `<C-a>/<C-x>` の増減を Dial に委譲。独自の増減対象グループや Visual 用設定は追加していない。 | 標準の増減操作を置換。ほかの増減専用プラグインなし。 |
| [diffview.lua](lua/plugins/diffview.lua)<br>sindrets/diffview.nvim | 読込対象 | `<C-g>d` で差分画面。ファイルパネルはリスト表示、差分/履歴パネルの j/k で対象差分も切り替え。 | Gin / Gitui / Lazygit と差分閲覧が重複。Gitgraph のコミット・範囲選択先なので両者は連携。 |
| [dmacro.lua](lua/plugins/dmacro.lua)<br>tani/dmacro.nvim | 読込対象 | normal/insert `<C-y>` で繰り返し編集を再実行するための動的マクロ。 | 標準マクロと繰り返し用途は近いが、明示録画ではない。ddc の確定キーは同じ insert `<C-y>` だが現在未読込。 |
| [fern.lua](lua/plugins/fern.lua)<br>lambdalisue/vim-fern | 読込対象 | 隠しファイルを表示するファイラ。既定キーを無効にし、作成・削除・rename・分割/タブで開く・パスコピー・プレビューを個別設定。Git 状態と Nerd Font 表示も使用。 | Snacks explorer / Fyler / Yazi と重複。`<leader>e` は Snacks と同じ。専用依存5件を伴う。 |
| [flash.lua](lua/plugins/flash.lua)<br>folke/flash.nvim | 未読込 | f で jump、F で構文選択、operator の r で remote、t/T の char mode を有効にする設定。通常検索 mode はオフ。 | 未読込。Jab の f/F/t/T とキー・移動用途が重複。構文選択は Treemonkey と重なる。 |
| [fm-nvim.lua](lua/plugins/fm-nvim.lua)<br>matukoto/fm-nvim | 読込対象 | Gitui と Lazygit を画面全体サイズの float で起動。`:G` を Gitui に展開。ほかのファイラ用コマンドはコメント。 | Gin と Git 操作、Diffview/Gitgraph と差分・履歴閲覧が重なる。この設定で Yazi 等のファイラとして使う指定はない。 |
| [full_visual_line.lua](lua/plugins/full_visual_line.lua)<br>0xAdk/full_visual_line.nvim | 読込対象 | 行単位 Visual 選択を全幅ハイライトするため、空 opts で setup。 | 専用の同一機能はなし。通常 Visual 選択の見た目を変える用途。 |
| [fyler.lua](lua/plugins/fyler.lua)<br>A7Lavinraj/fyler.nvim | 読込対象 | ファイルツリーの閲覧・編集のため stable branch と mini.icons、空 opts で setup。独自キーなし。 | Fern / Snacks explorer / Yazi とファイラ用途が重複。具体的な使用入口は設定から確認できない。 |

### G–M

| 設定・プラグイン | 状態 | この設定での用途・具体的な操作 | 重複・連携・注意点 |
| --- | --- | --- | --- |
| [gin.lua](lua/plugins/gin.lua)<br>lambdalisue/vim-gin | 読込対象 | status/log/branch を85%サイズの float で操作。add/commit/push/patch を `<C-g>…` に割り当て。delta があれば差分処理に使用し、status は独自プレビュー、log は fixup/reword、patch は diffput/get を設定。 | Gitui/Lazygit・Diffview・Gitgraph と操作/閲覧が重なる。Snacks dashboard と gin_preview.lua からも参照される。 |
| [gitgraph.lua](lua/plugins/gitgraph.lua)<br>isakbm/gitgraph.nvim | 読込対象 | `<C-g>g` で全ブランチ最大5000コミットをグラフ表示。単一/範囲コミット選択で Diffview を開く。 | Gin log / Gitui/Lazygit と履歴閲覧が重複。Diffview は描画先として必要。 |
| [gitsigns.lua](lua/plugins/gitsigns.lua)<br>lewis6991/gitsigns.nvim | 読込対象 | 行末に1秒遅延で blame、変更行の印と hunk 移動・stage/取り消し、削除行表示、`ih` の hunk 選択。 | Snacks blame と情報が重複（自動/手動）。Gin patch/stage と変更操作が近いが、編集中の hunk 操作として役割がある。 |
| [hlslens.lua](lua/plugins/hlslens.lua)<br>kevinhwang91/nvim-hlslens | 読込対象 | n/N と * / # / g* / g# の検索時に結果位置・件数を表示。最寄りの結果だけ表示。 | vim-asterisk は検索語生成として連携。Snacks grep/Jab は検索の入口が異なり、同じ表示を二重設定していない。 |
| [jab.lua](lua/plugins/jab.lua)<br>atusy/jab.nvim | 読込対象 | normal/Visual/operator の `<C-f>` でインクリメンタル検索、f/F/t/T を Jab に委譲。 | Flash の設定と直接重なるが Flash は未読込。CamelCaseMotion/Edgemotion は移動する単位が違う。 |
| [lazydev.lua](lua/plugins/lazydev.lua)<br>folke/lazydev.nvim | 読込対象 | Lua の型情報・補完支援。vim.uv を含む場合に luv library を追加、Blink の lazydev source と lua_ls の library 管理で利用。 | Blink / lua_ls と補完関係。削除時に Blink 側の provider 参照も変更が必要。 |
| [lexima.lua](lua/plugins/lexima.lua)<br>cohama/lexima.vim | 読込対象 | 括弧・引用符補完に加え、Svelte/TypeScript/TSX の `>` 入力でアロー関数の `=> {}` を作る5ルール。Ctrl-h を backspace 扱い。 | Blink の確定時括弧補完と対象は一部重なるが入力経路は別。Autotag はタグ閉じ/rename、Surround/Sandwich は既存範囲の囲み編集。 |
| [lspconfig.lua](lua/plugins/lspconfig.lua)<br>neovim/nvim-lspconfig | 読込対象 | 17サーバーの有効化、Blink capabilities、診断の sign/下線/float、LspAttach のバッファローカルキーと inlay hints を設定。 | LSP UI の依存元。K/gd/gr 等は Lspsaga/Snacks の global キーを隠す。サーバー設定と UI は別責務。 |
| [lspsaga.lua](lua/plugins/lspsaga.lua)<br>nvimdev/lspsaga.nvim | 読込対象 | 診断 float・移動、hover、peek、rename、code action、outline、階層表示を設定。電球/自身の winbar/実装表示はオフ。Lualine はシンボル取得 API を参照。 | LspUI / Snacks / Tiny Code Action / Aerial と重複。K/gd/gr は LspAttach 後に隠れる。gh の lsp_finder は固定版のコマンドと不整合。 |
| [lspui.lua](lua/plugins/lspui.lua)<br>jinzhongjia/LspUI.nvim | 読込対象 | 接続後 K/gr/gl/gt と診断 g[/g] の操作画面。rename/hover/code action/電球/call hierarchy 有効、signature 無効。 | Lspsaga と操作 UI、Snacks と参照系、Tiny Code Action と action が重複。gf の finder ref は固定版では不整合。signature は重複対象外。 |
| [lualine.lua](lua/plugins/lualine.lua)<br>nvim-lualine/lualine.nvim | 読込対象 | statusline ではなく winbar に mode・branch・診断・差分・Saga シンボル・filetype・位置/割合を表示。tabline は空。 | Bufferline と診断情報が重なるが表示場所は別。Saga の winbar API に依存。progress は LSP 進捗ではなくファイル内位置。 |
| [mini-test.lua](lua/plugins/mini-test.lua)<br>echasnovski/mini.test | 読込対象 | Neovim Lua のテスト用フレームワークを空 opts で setup。独自テスト対象・キー設定なし。 | Neotest/Plenary と Lua テスト用途が近いが異なるフレームワーク。実際の利用先はこの設定では不明。 |

### N–R

| 設定・プラグイン | 状態 | この設定での用途・具体的な操作 | 重複・連携・注意点 |
| --- | --- | --- | --- |
| [neotest.lua](lua/plugins/neotest.lua)<br>nvim-neotest/neotest | 読込対象 | Vitest（coverage 指定、node_modules 除外）と Plenary テストを実行。最寄り/ファイル/全体・summary・output のキー、virtual text の状態表示。 | QuickRun/Overseer と実行用途は近いがテスト UI が固有。mini.test の runner ではない。Java adapter も設定していない。 |
| [noice.lua](lua/plugins/noice.lua)<br>folke/noice.nvim | 読込対象 | コマンドラインを中央寄りの popup、長いメッセージを split、メッセージを Notify へ表示。LSP progress の特定通知を除外し Markdown 表示を override。 | デフォルト有効の signature が Blink と重複。hover は LspUI/Saga と提供機能が近い。Notify は描画先として連携。 |
| [nvim-java.lua](lua/plugins/nvim-java.lua)<br>nvim-java/nvim-java | 読込対象 | jdtls を有効化し Lombok・Java test・Spring Boot を使用。debug adapter/JDK 自動導入はオフ。Java ftplugin の gTM/gTC/gTV からテスト/結果を操作。 | lspconfig と二重サーバーではなく Java 専用設定。Neotest は Java を扱っておらず代替済みではない。 |
| [nvim-lastplace.lua](lua/plugins/nvim-lastplace.lua)<br>ethanholz/nvim-lastplace | 読込対象 | 再オープン時に前の位置へ戻る。quickfix/nofile/help とコミット系を除外し、移動先の fold を開く。 | init.lua の mkview/loadview と位置復元が重なる。Auto Session はより広い作業状態の復元。 |
| [nvim-lint.lua](lua/plugins/nvim-lint.lua)<br>mfussenegger/nvim-lint | 未読込 | ghaction に actionlint を指定し、JSON 出力を診断へ変換。保存/読込/InsertLeave と :Lint で実行する設定。 | 未読込。LSP 診断と分野は近いが、現在の lint 二重実行ではない。 |
| [nvim-notify.lua](lua/plugins/nvim-notify.lua)<br>rcarriga/nvim-notify | 読込対象 | 通知を下から表示する設定で setup し、vim.notify を置換。 | Noice の messages.view=notify の描画先。Snacks notifier は明示有効化しておらず、3つの通知を二重実行する設定ではない。 |
| [nvim-ts-autotag.lua](lua/plugins/nvim-ts-autotag.lua)<br>windwp/nvim-ts-autotag | 読込対象 | タグを自動で閉じ、対になるタグ名も変更。slash 入力による close はオフ。 | Lexima/Blink と入力補助という分野は近いがタグ操作が固有。 |
| [octo.lua](lua/plugins/octo.lua)<br>pwntester/octo.nvim | 読込対象 | GitHub Issue/PR/Discussion/通知の一覧・検索。`<leader>oi/op/od/on/os`、Snacks picker を使用。 | Gin/Gitgraph はローカル Git 操作であり、GitHub 上の会話・PR 操作とは別用途。 |
| [open-browser.lua](lua/plugins/open-browser.lua)<br>tyru/open-browser.vim | 読込対象 | normal/Visual の gx で URL を開くか文字列を検索。netrw の gx は無効化。 | 標準 gx を置き換える。ほかに同じ Web 検索用グローバルキーなし。 |
| [overseer.lua](lua/plugins/overseer.lua)<br>stevearc/overseer.nvim | 読込対象 | `<leader>r/R` でタスク実行/一覧。下部にタスクリスト、出力を分割・タブ・float・quickfix に開き、編集/破棄/プレビューを設定。 | QuickRun/Neotest と実行目的が近い。特定の同一テストを二重起動する定義はない。キーは key フィールド内の即時 keymap 呼び出しで定義。 |
| [project.lua](lua/plugins/project.lua)<br>DrKJeff16/project.nvim | 読込対象 | .git/package.json からルートを検出し global cwd を自動変更。LSP によるルート検出は無効、通知せず変更。 | Snacks projects は選択 UI、こちらは cwd 自動管理。Auto Session の復元単位と関連するが同じ処理ではない。 |
| [quicker.lua](lua/plugins/quicker.lua)<br>stevearc/quicker.nvim | 読込対象 | quickfix を編集可能にし、未変更バッファの編集を自動保存。`<leader>q`、内部 >/< で前後2行の展開/縮小、構文/LSP 色付け。 | bqf/Trouble/Snacks qflist と閲覧が重複。編集と前後行展開は独自用途。 |
| [rainbow-csv.lua](lua/plugins/rainbow-csv.lua)<br>mechatroner/rainbow_csv | 読込対象 | csv/tsv/txt で読み込み、列の配色を9組指定して区切りデータを読みやすくする。CSV ftplugin では j/k を物理行移動へ戻す。 | Render Markdown の表装飾とは対象形式が違う。独自の同一列色分け設定なし。 |
| [render-markdown.lua](lua/plugins/render-markdown.lua)<br>MeanderingProgrammer/render-markdown.nvim | 読込対象 | Markdown の見出し・表等の装飾を空 opts で setup。Tree-sitter と devicons を利用。 | Snacks image と同じ Markdown 画面でも画像/本文装飾の違い。チェックボックスの編集は ftplugin の自作関数で担当。 |

### S–Z

| 設定・プラグイン | 状態 | この設定での用途・具体的な操作 | 重複・連携・注意点 |
| --- | --- | --- | --- |
| [scope.lua](lua/plugins/scope.lua)<br>tiagovla/scope.nvim | 読込対象 | タブごとにバッファを分離し、タブ離脱前/進入後に User イベントを発行。 | Bufferline と補完関係。バッファ選択 UI を二重に提供するものではない。 |
| [sidekick.lua](lua/plugins/sidekick.lua)<br>folke/sidekick.nvim | 条件付き | AI CLI の選択/表示/切り離し、ファイル・選択・文脈送信。normal Tab で次の編集提案。端末の Ctrl-g で SKK 用 composer、Ctrl-s で送信。 | Aibo と CLI 操作/送信が重複、normal <leader>at が衝突。<leader>aa は Aerial と衝突。Claudecode の専用入力欄は未読込。 |
| [skkeleton.lua](lua/plugins/skkeleton.lua)<br>vim-skk/skkeleton | 読込対象 | insert/cmdline/terminal の Ctrl-k で SKK。5辞書、deno_kv・Google 日本語入力、ユーザー辞書/DB、候補数・句読点/括弧/丸数字の変換規則を設定。Markdown だけ keepState 有効。 | Blink の SKK source と Indicator は補完関係。ddc は未読込。normal Ctrl-k の Edgemotion はモードが異なる。 |
| [skkeleton_indicator.lua](lua/plugins/skkeleton_indicator.lua)<br>delphinus/skkeleton_indicator.nvim | 読込対象 | SKK の状態を A/あ/ア 等で表示。常時表示オフ、fade なし、zindex=210。sidekick_terminal では隠し composer の前面に表示できるよう調整。 | SKK 本体とは状態表示という別役割。同じ日本語入力モード表示の追加プラグインなし。 |
| [smoothcursor.lua](lua/plugins/smoothcursor.lua)<br>gen740/SmoothCursor.nvim | 読込対象 | カーソル移動の視覚効果を空 opts で setup。速度・形状・除外対象の例はコメント。 | Lspsaga beacon も位置を強調するが、ジャンプ時と通常移動時の違い。重複した同一設定はない。 |
| [snacks.lua](lua/plugins/snacks.lua)<br>folke/snacks.nvim | 読込対象 | ファイル/grep/バッファ/履歴/診断/LSP 検索、explorer、端末、画像、インデント、dashboard、buffer 削除。Gin/Session/Kensaku/Octo/Yanky/TODO の入口を統合。 | ファイラ・端末・LSP 一覧・quickfix・blame が他と重複。<leader>e/sl/sb/gd/gD/gr 等も競合。ファイル内で <leader>sb を二度定義。通知履歴等はコメントで無効。 |
| [term-edit.lua](lua/plugins/term-edit.lua)<br>chomosuke/term-edit.nvim | 読込対象 | 端末のコマンド行を Vim 操作で編集。プロンプト終端はドル記号＋空白に合わせた `%$ ` を指定。 | Termite/Bufterm は端末管理であり入力行編集とは別用途。 |
| [termite.lua](lua/plugins/termite.lua)<br>ruicsh/termite.nvim | 読込対象 | 下側の端末パネルを作成/切り替え。Ctrl-/ で toggle、Ctrl-t で create、端末内 Ctrl-n/p で巡回、Ctrl-z で最大化。自動挿入、winblend=20。 | Snacks terminal / :T/:Th と起動、Bufterm と自動挿入が重複。Term-edit は補完。 |
| [tint.lua](lua/plugins/tint.lua)<br>levouh/tint.nvim | 未読込 | 非アクティブ画面を tint=-45、彩度0.5 で暗くする設定。float や特定 filetype を除外する filter を定義。 | 未読込。edge の非アクティブ減光と用途が重なる。 |
| [tiny-code-action.lua](lua/plugins/tiny-code-action.lua)<br>rachartier/tiny-code-action.nvim | 読込対象 | normal ga で difftastic の差分プレビュー付き code action を Snacks picker に表示。 | Lspsaga normal ga とキー・機能が重複。LspUI も code action 有効。Visual ga はこのファイルに設定なし。 |
| [todo-comments.lua](lua/plugins/todo-comments.lua)<br>folke/todo-comments.nvim | 読込対象 | TODO/FIXME 等の強調と rg 検索。<leader>st は Snacks picker で結果表示、TodoTrouble も cmd 登録。 | Trouble の TODO 一覧と入口が重複。Snacks とは検索 UI とハイライト基盤の連携。 |
| [treemonkey.lua](lua/plugins/treemonkey.lua)<br>atusy/treemonkey.nvim | 読込対象 | Visual/operator の m で構文ブロックを選択。ignore_injections=false で埋め込み言語も対象にする。 | 未読込の Flash Treesitter 選択と重複。Aerial/UFO は同じ構文情報でも移動・折り畳みで用途が異なる。 |
| [treesitter.lua](lua/plugins/treesitter.lua)<br>nvim-treesitter/nvim-treesitter | 読込対象 | 各言語パーサーを導入し、FileType でハイライト・標準 foldexpr・インデントを設定。TSUpdate を build に指定。 | UFO と fold 設定が重複。他の構文利用プラグインは依存先/利用元であり代替ではない。 |
| [trouble.lua](lua/plugins/trouble.lua)<br>folke/trouble.nvim | 読込対象 | 診断/参照/quickfix/loclist/TODO を専用一覧で閲覧する設定。自動 open/close はオフ、preview はオン。 | Snacks/Lspsaga/Quicker/bqf と一覧用途が重複。全キーが旧 TroubleToggle を呼び固定版と不整合。 |
| [ufo.lua](lua/plugins/ufo.lua)<br>kevinhwang91/nvim-ufo | 読込対象 | Tree-sitter/indent を provider にした折り畳みと zR/zM/zr/zm の拡張。fold オプションを init でも設定。 | treesitter.lua の標準 foldexpr と競合。LSP provider はこの設定では使わない。 |
| [vim-dadbod-ui.lua](lua/plugins/vim-dadbod-ui.lua)<br>kristijanhusak/vim-dadbod-ui | 読込対象 | DB 接続・クエリ管理 UI。DBUI 系コマンド、<leader>w のクエリ保存、保存先 ~/.config/vim/dadbod-ui を指定。 | Dadbod は実行基盤で補完関係。sqls は言語支援で別役割。 |
| [vim-edgemotion.lua](lua/plugins/vim-edgemotion.lua)<br>haya14busa/vim-edgemotion | 読込対象 | normal Ctrl-j/Ctrl-k でテキスト境界へ上下移動。 | Jab/CamelCaseMotion と移動用途は近いが境界・方向が違う。Blink/SKK の同名キーはモードが違う。 |
| [vim-quickrun.lua](lua/plugins/vim-quickrun.lua)<br>thinca/vim-quickrun | 読込対象 | 現在のコードを単発実行するため QuickRun と略語 :qr を用意。runner 等の独自設定なし。 | Overseer はタスク管理、Neotest はテスト UI。単発実行の入口として必要か確認対象。 |
| [vim-sonictemplate.lua](lua/plugins/vim-sonictemplate.lua)<br>mattn/vim-sonictemplate | 読込対象 | ~/.config/vim/sonictemplate/ のテンプレートを Template / :tp で挿入。 | Blink のスニペットと定型文挿入は近いが、テンプレートファイルをコマンドで選ぶ方式。 |
| [waitevent.lua](lua/plugins/waitevent.lua)<br>notomo/waitevent.nvim | 未読込 | GIT_EDITOR は既存 Neovim の分割で開いて終了を待ち、EDITOR は done/cancel イベントを空にして開く設定。 | 未読込。Guise の既存インスタンス接続と用途が重複する旧設定。 |
| [wakatime.lua](lua/plugins/wakatime.lua)<br>wakatime/vim-wakatime | 条件付き | 編集作業時間を記録するため条件付きで VeryLazy 登録。独自オプションなし。 | 同じ作業時間計測プラグインなし。 |
| [which-key.lua](lua/plugins/which-key.lua)<br>folke/which-key.nvim | 読込対象 | キー候補を案内し、<leader>? でバッファローカルキーを表示。空 opts で setup。 | Snacks <leader>sK のキー検索と一覧用途は重なるが、入力途中の案内と検索という違い。 |
| [yanky.lua](lua/plugins/yanky.lua)<br>gbprod/yanky.nvim | 読込対象 | y/p/P/gp/gP を置換し、ヤンク/貼り付けを50ms強調。履歴10件を shada 保存、OS clipboard と同期、CR を除去。<leader>P で履歴選択。 | Snacks は履歴 picker として連携。init.lua の Visual p/P 入れ替えとキーが重なる。 |
| [yazi.lua](lua/plugins/yazi.lua)<br>mikavilpas/yazi.nvim | 読込対象 | <leader>y で外部 Yazi。分割/タブで開く、ディレクトリ grep/置換、相対パスコピー、quickfix 送信、cwd 変更のキーを設定。 | Fern/Fyler/Snacks explorer とファイラ用途が重複。外部 CLI の Yazi を使う点が違う。 |

## lazy.lua で直接登録する17件と管理ツール

設定元はすべて [lua/config/lazy.lua](lua/config/lazy.lua)。個別ファイルがなくても一覧から除外していない。

| プラグイン | この設定での用途・入口 | 重複・連携・設定の有無 |
| --- | --- | --- |
| folke/lazy.nvim | stable branch を bootstrap し、import・依存・遅延ロードを管理。`:Lazy` は dashboard からも起動 | 管理ツール。同じマネージャーの二重設定なし |
| vim-jp/vimdoc-ja | 日本語ヘルプ。init.lua で `helplang=ja,en`、Snacks の help picker から検索もできる | 翻訳データと検索 UI の補完関係 |
| lambdalisue/vim-guise | 端末/ジョブからの Vim/Neovim 起動を既存インスタンスのタブへ接続 | Denops 依存。waitevent と用途は重なるが後者は未読込。個別オプションなし |
| rachartier/tiny-inline-diagnostic.nvim | 行内の診断表示用として登録 | `opts/config/setup` がなく、現在の表示担当と断定できない。診断内容は LSP UI 各種と共通 |
| shougo/pum.vim | 補完候補 popup 用として登録 | 具体的な pum API 呼び出しは未読込の ddc.lua にある。現在の Blink は自身の補完 UI を使う |
| nvim-treesitter/nvim-treesitter-context | 現在位置を囲む関数等のコード行を上部に表示 | プラグイン側の自動 setup。Aerial/Saga のシンボル表示と位置把握の目的は近いが、実際のコード行表示という違い |
| lambdalisue/vim-kensaku | 日本語検索向けに入力を正規表現化。Snacks の独自 grep source が `kensaku#query` を使用 | Snacks と連携。通常 grep と検索対象は重なるが日本語の検索語展開が固有 |
| lambdalisue/vim-kensaku-search | Kensaku を通常検索へ接続するための登録 | 個別の検索キー設定はない。Snacks Kensaku は別経路で、こちらを必須とする呼び出しではない |
| kevinhwang91/nvim-bqf | quickfix プレビュー等の操作補助。VeryLazy 登録、個別 opts なし | Quicker と同じ quickfix 上で働く。Snacks/Trouble と一覧閲覧は重なるが編集・プレビューは異なる |
| haya14busa/vim-asterisk | 単語/Visual 選択検索の拡張。hlslens の */#/g*/g# が Plug を呼ぶ | hlslens の依存にもあり、同じ登録の重複。インストール数は1件で、検索と結果表示の連携 |
| tyru/capture.vim | Ex コマンドの出力を取得。init.lua の `cm` 略語で `Capture message` を呼ぶ設定 | Noice のメッセージ表示/履歴と対象が一部重なるが、任意コマンド出力取得という用途 |
| itchyny/vim-cursorword | カーソル下と同じ単語を強調。個別設定なし | hlslens は検索結果表示なので、自動の同一語強調とはトリガーが違う |
| lambdalisue/vim-suda | `SudaWrite` で権限付き書き込みを行うための補助 | command で遅延ロード。同じ用途の追加設定なし |
| simeji/winresizer | ウィンドウサイズを対話的に調整。個別キー/opts なし | Chowcho は移動先選択なので別用途。標準ウィンドウリサイズの操作補助 |
| tpope/vim-surround | デフォルトの ys/ds/cs、Visual S/gS 等で囲みを編集 | Sandwich と追加・削除・変更が直接重複。Lexima は文字入力時の自動補完 |
| machakann/vim-sandwich | デフォルトの sa/sd/sr と囲みテキストオブジェクトを使用可能にする | Surround と編集目的が重複するが、キー体系とテキストオブジェクトが異なる |
| tpope/vim-dadbod | DB 接続・SQL 実行。Dadbod UI の実行基盤 | UI の依存でも登録されるが同一プラグイン1件。sqls の言語支援とは別用途 |
| neko-night/nvim | 追加のカラースキーム候補 | 適用する指定なし。現在明示適用しているテーマは edge |

## 依存として設定しているプラグイン

ここでの「重複なし」は同じ用途のプラグインが世の中に存在しないという意味ではなく、
この設定に同一処理の二重指定を確認していないという意味。

| プラグイン | 用途・設定元 | 重複・連携 |
| --- | --- | --- |
| Xantibody/blink-cmp-skkeleton | [blink.lua](lua/plugins/blink.lua) の SKK 用補完 source。SKK 有効時はこの source のみ選択 | SKK/Blink の接続部。未読込 ddc の SKK source 設定と用途が重なる |
| nvim-tree/nvim-web-devicons | Aerial/Bufferline/LSP UI/Lualine/Markdown/Trouble/Octo にファイル等のアイコンを供給 | mini.icons・vim-nerdfont とアイコン用途は近いが利用元/API が別。単純置換できるとは限らない |
| nvim-mini/mini.icons | [fyler.lua](lua/plugins/fyler.lua) のアイコン依存 | 上記アイコン基盤と用途類似。この設定での明示利用元は Fyler |
| nvim-lua/plenary.nvim | Neotest/Yazi/Tiny Code Action/Octo の共通 Lua ユーティリティ | 複数参照でも1件。nui は UI、nio は非同期で責務が違う |
| MunifTanjim/nui.nvim | [noice.lua](lua/plugins/noice.lua) と nvim-java 側の UI 部品依存 | Noice の popupmenu backend にも nui を指定。単独の競合 UI ではない |
| kevinhwang91/promise-async | [ufo.lua](lua/plugins/ufo.lua) の非同期処理基盤 | nio と分野は近いが利用側の API が別。UFO とセットで必要性を確認 |
| nvim-neotest/nvim-nio | [neotest.lua](lua/plugins/neotest.lua) の非同期処理基盤 | promise-async と単純統合できる依存ではない |
| antoinemadec/FixCursorHold.nvim | [neotest.lua](lua/plugins/neotest.lua) の CursorHold イベント補助 | 独自 opts なし。同一補助を行う別依存の明示設定なし |
| marilari88/neotest-vitest | [neotest.lua](lua/plugins/neotest.lua) で Vitest、coverage 引数、node_modules 除外を設定 | Neotest の言語/runner 対応部分。Plenary adapter とは対象が違う |
| nvim-neotest/neotest-plenary | [neotest.lua](lua/plugins/neotest.lua) で Plenary テストを実行 | mini.test と Lua テスト用途は近いが対応フレームワークが異なる |
| yuki-yano/fern-preview.vim | [fern.lua](lua/plugins/fern.lua) の p/Ctrl-p による preview/auto-preview、終了時 smart_preview | Snacks/Yazi にもファイル preview 用途はあるが Fern 専用の実装 |
| lambdalisue/vim-fern-hijack | [fern.lua](lua/plugins/fern.lua) でディレクトリを開く処理を Fern に接続。lazy=false | 他のファイラの手動起動とは別に作用する。Fern 削除時の対象 |
| lambdalisue/vim-nerdfont | [fern.lua](lua/plugins/fern.lua) の Nerd Font アイコン基盤 | devicons/mini.icons と用途類似だが Fern renderer が利用 |
| lambdalisue/vim-fern-git-status | [fern.lua](lua/plugins/fern.lua) で Git 状態を表示。ignored/submodule は除外、untracked/directory は含める | Gitsigns は行単位、Gin は Git 操作画面。ファイラ内の状態表示として補完 |
| lambdalisue/fern-renderer-nerdfont.vim | [fern.lua](lua/plugins/fern.lua) が renderer=nerdfont を明示 | vim-nerdfont を使って Fern に描画する接続部。アイコン基盤との二重機能ではない |
| mfussenegger/nvim-dap | nvim-java の固定版 `lazy.lua` が宣言する DAP クライアント依存 | Java debug adapter はオフでも依存登録は残る。Neotest の DAP 依存例はコメント |
| JavaHello/spring-boot.nvim | nvim-java 側 `lazy.lua` の依存。Spring Boot Tools を有効にする設定がある | nvim-java の Java 拡張として連携。汎用 LSP UI の削減とは別対象 |
| zbirenbaum/copilot.lua | 未読込の [codecompanion.lua](lua/plugins/codecompanion.lua) だけが依存登録 | 現在の有効な依存数に含めない。Sidekick の copilot CLI 指定や、コメントアウトされた Copilot LSP 設定とは別の統合 |
| shougo/ddc-ui-pum | 未読込の [ddc.lua](lua/plugins/ddc.lua) の ddc→pum 接続 | 現在の有効な依存数に含めない。Blink 独自 UI と用途が重なる旧経路 |

その他、直接登録と dependencies の両方に現れる SKK/Denops/Tree-sitter/Snacks/Blink/Diffview/Dadbod/LSP UI 等は、
上の個別項目に記載済み。同じリポジトリを2個導入する意味ではない。

## 個別プラグインファイル外で設定している用途

| ファイル | 実際の用途・プラグインとの関係 |
| --- | --- |
| [snacks/sources/kensaku.lua](lua/plugins/snacks/sources/kensaku.lua) | 独自の Snacks grep source。Kensaku の正規表現を rg に渡し、パス・行・列を picker 結果へ変換。隠しファイル・ignore・glob 等も反映。追加プラグインではない |
| [markdown.vim](after/ftplugin/markdown.vim) | Markdown のリスト継続、conceal、チェックボックスの自作編集コマンド。AerialOpen の FileType autocmd も登録する。コメントに obsidian.nvim とあるがプラグイン登録はなく、自作処理を Obsidian の利用と数えない |
| [csv.vim](after/ftplugin/csv.vim) | j/k を物理行移動に戻し、CSV を行単位で移動する |
| [java.lua](after/ftplugin/java.lua) | gTM/gTC/gTV から nvim-java のメソッド/クラステスト・結果表示。keymap に buffer 指定がないので Java を開いた後は global キーとして定義される |
| [gin_preview.lua](lua/config/gin_preview.lua) | Gin status の独自プレビュー。Gin の削除時は関連実装・呼び出しを合わせて確認 |
| [init.lua](init.lua) | LSP 接続前の基本キー、mkview/loadview、標準端末 :T/:Th、clipboard、ヘルプ言語、Capture 等の略語。Yanky/Snacks/Lastplace と重なる操作もある |
| [after/lsp](after/lsp/) | 言語別の root/hints/format 等。詳細は LSP 整理文書。設定ファイルの存在だけで有効化済みサーバーとは扱わない |

## 再確認で補足した点

- **Lexima は単なる括弧補完ではなく、Svelte/TypeScript のアロー関数入力にも使用**している。
- **Aerial の利用はプラグイン内の手動キーだけではない**。Markdown ftplugin が自動表示の autocmd を登録している。
  イベント登録のタイミングもあるため、最初の Markdown を開いた瞬間の動作までは静的解析で断定しない。
- **edge に非アクティブウィンドウの減光設定がある**。Tint は同用途だが未読込。
- **Claudecode の opts は setup に渡されていない**。設定に値が書かれていても実効設定とは限らない。
- **キー/テーブルの同じ定義も残る**。Snacks の `<leader>sb`、Aider の `<leader>aI`、Auto Session の `delete_session` が該当。
- Markdown チェックボックス、標準端末、表示復元などの**自作処理も代替・重複の比較対象**に含めた。

74個別ファイルが一覧に過不足なく現れることと、17直接登録・依存プラグインの収録を機械的に照合した。
設定・プラグインは変更せず、文書のみ更新。通常設定での Neovim 起動・ロード成功・利用頻度の測定はしていない。
