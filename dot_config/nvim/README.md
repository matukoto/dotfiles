# Neovim

私のNeovim設定です。プラグイン管理には`lazy.nvim`を使用しています。

## プラグイン一覧

### 必須プラグイン (Core Plugins)
| Plugin | Description |
| --- | --- |
| [denops.vim](https://github.com/vim-denops/denops.vim) | DenoランタイムでVim/Neovimプラグインを開発するためのエコシステム |

### UI/UX
#### 全体 (Overall)
| Plugin | Description |
| --- | --- |
| [bufferline.nvim](https://github.com/akinsho/bufferline.nvim) | タブやバッファをUI上部に表示し、管理を容易にする |
| [lualine.nvim](https://github.com/nvim-lualine/lualine.nvim) | 高速かつカスタマイズ性の高いステータスライン |
| [which-key.nvim](https://github.com/folke/which-key.nvim) | 次に入力可能なキーマップのヒントを表示する |
| [styler.nvim](https://github.com/folke/styler.nvim) | テキストのスタイルやハイライトをカスタマイズする |

#### 情報表示 (Information Display)
| Plugin | Description |
| --- | --- |
| [fidget.nvim](https://github.com/j-hui/fidget.nvim) | LSPの読み込み状況などを右下に表示する |
| [nvim-notify](https://github.com/rcarriga/nvim-notify) | Neovimの通知機能をモダンなUIで表示する |
| [aerial.nvim](https://github.com/stevearc/aerial.nvim) | シンボルツリーをサイドバーに表示し、コードのアウトラインを可視化する |
| [todo-comments.nvim](https://github.com/folke/todo-comments.nvim) | `TODO`, `FIXME` などのコメントをハイライトして一覧表示する |
| [rainbow-csv](https://github.com/mechatroner/rainbow-csv) | CSVファイルの各列を異なる色でハイライトする |
| [render-markdown.nvim](https://github.com/MeoBeoI/render-markdown.nvim) | Markdownファイルの一部をリアルタイムでレンダリング表示する |

#### カーソル・ハイライト (Cursor & Highlight)
| Plugin | Description |
| --- | --- |
| [flash.nvim](https://github.com/folke/flash.nvim) | 画面内の任意の位置へ高速にジャンプするためのカーソル移動プラグイン |
| [hlslens.nvim](https://github.com/kevinhwang91/hlslens.nvim) | 検索にマッチした箇所をハイライトし、視覚的に分かりやすくする |
| [smoothcursor.nvim](https://github.com/gen740/smoothcursor.nvim) | カーソル移動をスムーズなアニメーションで表示する |

### ファイル・プロジェクト管理 (File & Project Management)
| Plugin | Description |
| --- | --- |
| [fern.vim](https://github.com/lambdalisue/fern.vim) | 高機能なファイルエクスプローラー |
| [fyler.vim](https://github.com/Pocco81/fyler.vim) | ファイル操作を補助するユーティリティ |
| [yazi.nvim](https://github.com/mikavilpas/yazi.nvim) | 高速なターミナルベースのファイルマネージャー`yazi`との連携 |
| [project.nvim](https://github.com/ahmedkhalf/project.nvim) | プロジェクトごとの設定管理や切り替えを容易にする |
| [auto-session](https://github.com/rmagatti/auto-session) | Neovim終了時のセッションを自動で保存・復元する |
| [nvim-lastplace](https://github.com/ethanholz/nvim-lastplace) | ファイルを再度開いたときに、最後のカーソル位置に移動する |

### 編集支援 (Editing Support)
#### 入力補完 (Completion)
| Plugin | Description |
| --- | --- |
| [lexima.vim](https://github.com/cohama/lexima.vim) | `(`, `[` などの括弧や引用符を自動で補完する |
| [nvim-ts-autotag](https://github.com/windwp/nvim-ts-autotag) | Treesitterを利用してHTML/XMLタグの閉じタグを自動で挿入・変更する |
| [vim-sonictemplate](https://github.com/mattn/vim-sonictemplate) | ファイルタイプに応じたテンプレートを挿入する |
| [snacks.nvim](https://github.com/pocco81/snacks.nvim) | ddc.vimと連携して動作するスニペットプラグイン |

#### テキスト操作 (Text Manipulation)
| Plugin | Description |
| --- | --- |
| [yanky.nvim](https://github.com/gbprod/yanky.nvim) | 高機能なヤンク（コピー）履歴管理 |
| [dial.nvim](https://github.com/monaqa/dial.nvim) | 数値、日付、定数などをインクリメント・デクリメントする |
| [dmacro.vim](https://github.com/monaqa/dmacro.vim) | マクロの記録と再生を強化する |
| [vim-full-visual-line](https://github.com/kana/vim-full-visual-line) | `V`による行選択の挙動を改善する |
| [ccc.nvim](https://github.com/uga-rosa/ccc.nvim) | カラーコードをプレビュー・変換する |

#### カーソル移動 (Motion)
| Plugin | Description |
| --- | --- |
| [fuzzy-motion.vim](https://github.com/yuki-yano/fuzzy-motion.vim) | ファジー検索を用いてカーソルを高速に移動する |
| [vim-camelcasemotion](https://github.com/bkad/vim-camelcasemotion) | CamelCase/snake_caseでの単語単位のカーソル移動を可能にする |
| [vim-edgemotion](https://github.com/mattn/vim-edgemotion) | 画面の端でカーソルが止まらず、上下に移動し続けられるようにする |

### LSP・静的解析 (LSP & Static Analysis)
#### LSP
| Plugin | Description |
| --- | --- |
| [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig) | LSPサーバーの設定を簡単に行うためのヘルパー |
| [lspsaga.nvim](https://github.com/glepnir/lspsaga.nvim) | LSPの機能を強化し、UIをリッチにする |
| [lspui.nvim](https://github.com/jin-yijian/lspui.nvim) | LSPの情報を表示するためのUIコンポーネント |
| [tiny-code-action.nvim](https://github.com/yuki-yano/tiny-code-action.nvim) | コードアクションをシンプルに実行するためのUI |

#### リンター・フォーマッター (Linter & Formatter)
| Plugin | Description |
| --- | --- |
| [conform.nvim](https://github.com/stevearc/conform.nvim) | 高速で拡張性の高いフォーマットプラグイン |
| [nvim-lint](https://github.com/mfussenegger/nvim-lint) | 非同期で動作するリンタープラグイン |

#### コード診断 (Diagnostics)
| Plugin | Description |
| --- | --- |
| [trouble.nvim](https://github.com/folke/trouble.nvim) | LSPの診断情報（エラーや警告）を分かりやすく一覧表示する |
| [quicker.nvim](https://github.com/yuki-yano/quicker.nvim) | quickfixやlocation listの操作を改善する |

### シンタックス (Syntax)
| Plugin | Description |
| --- | --- |
| [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) | 高速で正確なシンタックスハイライトを提供する |
| [nvim-ufo](https://github.com/kevinhwang91/nvim-ufo) | コードの折りたたみ機能を強化し、LSPと連携させる |

### Git
| Plugin | Description |
| --- | --- |
| [gin.vim](https://github.com/lambdalisue/gin.vim) | Git操作をNeovim内で完結させるためのインターフェース |
| [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim) | 左端のサインカラムに変更・追加・削除のGitステータスを表示する |
| [GitGraph.nvim](https://github.com/rbong/GitGraph.nvim) | Gitのコミットグラフを視覚的に表示する |

### タスク実行・テスト (Task Runner & Testing)
| Plugin | Description |
| --- | --- |
| [vim-quickrun](https://github.com/thinca/vim-quickrun) | 現在のバッファのコードを素早く実行して結果を表示する |
| [overseer.nvim](https://github.com/stevearc/overseer.nvim) | ビルドやテストなどのタスクを管理・実行する |
| [neotest](https://github.com/nvim-neotest/neotest) | TreesitterとLSPを利用したモダンなテストランナー |
| [mini.test](https://github.com/echasnovski/mini.test) | Neovimプラグインのテストを作成・実行するためのユーティリティ |

### 外部ツール連携 (External Tool Integration)
#### AI
| Plugin | Description |
| --- | --- |
| [copilot.lua](https://github.com/github/copilot.vim) | GitHub Copilotの公式クライアント |
| [copilot-chat.nvim](https://github.com/CopilotC-Nvim/copilot-chat.nvim) | GitHub Copilot Chatと対話するためのインターフェース |
| [aibo.nvim](https://github.com/andy/aibo.nvim) | 様々なAIモデル（GPTなど）と連携するためのクライアント |
| [Aider.nvim](https://github.com/joshuavial/Aider.nvim) | AIペアプログラミングツール`Aider`との連携 |
| [claudecode.nvim](https://github.com/matukoto/claudecode.nvim) | AnthropicのClaudeモデルと連携するためのクライアント |
| [codecompanion.nvim](https://github.com/yonst/codecompanion.nvim) | AIアシスタント機能を提供する |

#### その他 (Others)
| Plugin | Description |
| --- | --- |
| [vim-dadbod-ui](https://github.com/kristijanhusak/vim-dadbod-ui) | Neovimからデータベースを操作するためのUI |
| [open-browser.vim](https://github.com/tyru/open-browser.vim) | カーソル下のURLをブラウザで開く |
| [term-edit.nvim](https://github.com/deris/term-edit.nvim) | ターミナルバッファの内容を通常のバッファで編集する |
| [bufterm.nvim](https://github.com/pocco81/bufterm.nvim) | ターミナルセッションをバッファとして管理する |

### 日本語入力 (Japanese Input)
| Plugin | Description |
| --- | --- |
| [skkeleton](https://github.com/vim-skk/skkeleton) | Neovim上でSKKによる日本語入力を実現する |
| [skkeleton_indicator.nvim](https://github.com/pocco81/skkeleton_indicator.nvim) | SKKの入力モードをステータスラインに表示する |
| [chowcho.nvim](https://github.com/yuki-yano/chowcho.nvim) | SKK辞書の管理を補助する |