# Nushell 設定ファイル

# 補完に関する設定モジュール
module completions {
  # 外部コマンド（Nushell 外部のコマンド）のカスタム補完
  # 各補完は2つの部分から構成される: 外部コマンドの形式（フラグとパラメータを含む）
  # および、それらのフラグとパラメータの値を補完する方法を知っているヘルパーコマンド

  # nu コマンド自体の外部コマンド定義と補完設定
  export extern "nu" [
    --help(-h)                # Display this help message
    --stdin                   # redirect the stdin
    --login(-l)               # start as a login shell
    --interactive(-i)         # start as an interactive shell
    --version(-v)             # print the version
    --perf(-p)                # start and print performance metrics during startup
    --testbin:string          # run internal test binary
    --commands(-c):string     # run the given commands and then exit
    --config:string           # start with an alternate config file
    --env-config:string       # start with an alternate environment config file
    --log-level:string        # log level for performance logs
    --threads:int             # threads to use for parallel commands
    --table-mode(-m):string   # the table mode to use. rounded is default.
  ]
}

# 補完モジュールからカスタム補完コマンドを除いた extern 定義のみを使用する
use completions *

# テーマに関する詳細はこちらを参照:
# https://www.nushell.sh/book/coloring_and_theming.html
# デフォルトのテーマ設定
let default_theme = {
    # Nushell のプリミティブ型に対する色設定
    separator: white
    leading_trailing_space_bg: { attr: n } # no fg, no bg, attr none effectively turns this off
    header: green_bold
    empty: blue
    bool: white
    int: white
    filesize: white
    duration: white
    date: white
    range: white
    float: white
    string: white
    nothing: white
    binary: white
    cellpath: white
    row_index: green_bold
    record: white
    list: white
    block: white
    hints: dark_gray # ヒントの色

    # シェイプは CLI のシンタックスハイライトを変更するために使用される
    shape_garbage: { fg: "#FFFFFF" bg: "#FF0000" attr: b} # 不正な構文
    shape_binary: purple_bold # バイナリ
    shape_bool: light_cyan # 真偽値
    shape_int: purple_bold # 整数
    shape_float: purple_bold # 浮動小数点数
    shape_range: yellow_bold # 範囲
    shape_internalcall: cyan_bold # 内部コマンド呼び出し
    shape_external: cyan # 外部コマンド
    shape_externalarg: green_bold # 外部コマンド引数
    shape_literal: blue # リテラル
    shape_operator: yellow # 演算子
    shape_signature: green_bold # シグネチャ
    shape_string: green # 文字列
    shape_string_interpolation: cyan_bold # 文字列補間
    shape_datetime: cyan_bold # 日時
    shape_list: cyan_bold # リスト
    shape_table: blue_bold # テーブル
    shape_record: cyan_bold # レコード
    shape_block: blue_bold # ブロック
    shape_filepath: cyan # ファイルパス
    shape_globpattern: cyan_bold # グロブパターン
    shape_variable: purple # 変数
    shape_flag: blue_bold # フラグ
    shape_custom: green # カスタムコマンド
    shape_nothing: light_cyan # Null/Nothing
}

# pet search を実行し、選択されたコマンドをコマンドラインに挿入する関数
def "exec_pet_search" [] {
  wtype (pet search)
}


# デフォルトの設定レコード。グローバル設定の多くはここでセットアップされる。
$env.config = {
  color_config: $default_theme # カラー設定 (上で定義した default_theme を使用)
  footer_mode: never # フッターの表示モード: always, never, number_of_rows, auto 
  float_precision: 2 # 浮動小数点数の表示精度
  # buffer_editor: "emacs" # Ctrl+o で現在の行バッファを編集するコマンド。未設定の場合は $env.EDITOR, $env.VISUAL にフォールバック
  use_ansi_coloring: true # ANSI カラーリングを使用するかどうか
  edit_mode: emacs # 行編集モード: emacs, vi
  # シェル統合設定 (ターミナルエミュレータとの連携機能) (wezterm で勝手に改行されてしまう問題の対処)
  shell_integration: {
    osc2: false, # OSC 2 (ウィンドウタイトル設定) を有効にするか
    osc7: false, # OSC 7 (カレントディレクトリ通知) を有効にするか
    osc8: false, # OSC 8 (ハイパーリンク) を有効にするか
    osc9_9: false, # OSC 9;9 (iTerm2 プロンプトマーク) を有効にするか
    osc133: false, # OSC 133 (VSCode ターミナルマーク) を有効にするか
    osc633: false, # OSC 633 (VSCode シェル統合) を有効にするか
    reset_application_mode: false, # アプリケーションモードをリセットするか
  }

  # ls コマンドの設定
  ls: {
    use_ls_colors: true # LS_COLORS 環境変数を使用して出力を色付けするかどうか
    clickable_links: true # クリック可能なリンクを有効にするか (ターミナルがリンクをサポートしている必要あり)
  }
  # rm コマンドの設定
  rm: {
    always_trash: true # 常にゴミ箱に移動するか (-t が指定されたかのように動作)。-p で上書き可能
  }
  # テーブル表示の設定
  table: {
    mode: rounded # テーブルの表示モード: basic, compact, compact_double, light, thin, with_love, rounded, reinforced, heavy, none, other
    index_mode: always # インデックスの表示モード: "always" (常に表示), "never" (表示しない), "auto" (テーブルに "index" 列がある場合に表示)
    # テーブルセルのトリミング設定
    trim: {
      methodology: wrapping # トリミング方法: wrapping (折り返し) または truncating (切り捨て)
      wrapping_try_keep_words: true # 'wrapping' 方法で使用される戦略 (単語を維持しようとするか)
      truncating_suffix: "..." # 'truncating' 方法で使用される接尾辞
    }
  }
  # 履歴の設定
  # history: {
  #   max_size: 10000 # 履歴の最大サイズ (反映にはセッションの再読み込みが必要)
  #   sync_on_enter: true # Enter キーを押したときに履歴を同期するか (複数セッション間で履歴を共有する場合に有効。無効の場合、セッション終了時にファイルに書き込み)
  #   file_format: "plaintext" # 履歴ファイルの形式: "sqlite" または "plaintext"
  # }
  # 補完機能の設定
  completions: {
    case_sensitive: false # 大文字小文字を区別する補完を有効にするか
    quick: true  # 候補が1つだけの場合に自動選択するかどうか
    partial: true  # プロンプトの部分的な補完を有効にするか
    algorithm: "prefix"  # 補完アルゴリズム: "prefix" (前方一致) または "fuzzy" (あいまい検索)
    # 外部コマンド補完の設定
    external: {
      enable: true # Nushell が $env.PATH を検索して候補を増やすことを許可するか (WSL ユーザーは検索が遅くなる可能性があるため `false` を推奨)
      max_results: 100 # 外部補完の最大結果数 (少なくするとパフォーマンスが向上する可能性があるが、一部のオプションが省略される)
      completer: null # 外部補完プログラム (例: 上記の 'carapace_completer')
    }
  }

  # # フックの設定 (特定のイベント発生時に実行されるコード)
  # hooks: {
  #   # プロンプトが表示される前に実行されるフック
  #   pre_prompt: [{||
  #     # direnv が存在しない場合は何もしない
  #     if (which direnv | is-empty) {
  #       return
  #     }
  #
  #     # direnv から環境変数を JSON 形式でエクスポートし、パースする (失敗した場合は空のレコード)
  #     mut envrc = (direnv export json | from json | default {})
  #     # 環境変数が空の場合は何もしない
  #     if ($envrc | is-empty) {
  #       return
  #     }
  #
  #     # Path が null の場合 (Windows 環境など)、PATH を ; で分割して Path に設定
  #     if ($envrc.Path == null) {
  #       $envrc.Path = ($envrc.PATH | split row ";")
  #     }
  #     # direnv から取得した環境変数をロードする
  #     $envrc | load-env
  #
  #   }]
  #   # REPL の入力が実行される前に実行されるフック
  #   pre_execution: [{||
  #     null  # ここに実行したいコードを記述
  #   }]
  # }
  # メニューの設定 (補完、履歴、ヘルプなどのインタラクティブメニュー)
  menus: [
      # デフォルトの Nushell メニューの設定
      # source パラメータがないことに注意
      # 補完メニューの設定
      {
        name: completion_menu # メニュー名
        only_buffer_difference: false # バッファとの差分のみを表示するか
        marker: "| " # メニューのマーカー
        # メニューのタイプ設定
        type: {
            layout: columnar # レイアウト: columnar (列形式)
            columns: 4 # 列数
            col_width: 20   # 列幅 (オプション。指定しない場合は画面幅全体を使用)
            col_padding: 2 # 列間のパディング
        }
        # メニューのスタイル設定
        style: {
            text: green # 通常テキストの色
            selected_text: green_reverse # 選択されたテキストの色
            description_text: yellow # 説明テキストの色
        }
      }
      # 履歴メニューの設定
      {
        name: history_menu # メニュー名
        only_buffer_difference: true # バッファとの差分のみを表示するか
        marker: "? " # メニューのマーカー
        # メニューのタイプ設定
        type: {
            layout: list # レイアウト: list (リスト形式)
            page_size: 10 # 1ページあたりの項目数
        }
        # メニューのスタイル設定
        style: {
            text: green # 通常テキストの色
            selected_text: green_reverse # 選択されたテキストの色
            description_text: yellow # 説明テキストの色
        }
      }
      # ヘルプメニューの設定
      {
        name: help_menu # メニュー名
        only_buffer_difference: true # バッファとの差分のみを表示するか
        marker: "? " # メニューのマーカー
        # メニューのタイプ設定
        type: {
            layout: description # レイアウト: description (説明付き)
            columns: 4 # 列数
            col_width: 20   # 列幅 (オプション)
            col_padding: 2 # 列間のパディング
            selection_rows: 4 # 選択項目の表示行数
            description_rows: 10 # 説明の表示行数
        }
        # メニューのスタイル設定
        style: {
            text: green # 通常テキストの色
            selected_text: green_reverse # 選択されたテキストの色
            description_text: yellow # 説明テキストの色
        }
      }
      # Nushell ソースを使用して作成された追加メニューの例
      # source フィールドを使用して、メニューを構成するレコードのリストを作成する
      # コマンドメニューの設定
      {
        name: commands_menu # メニュー名
        only_buffer_difference: false # バッファとの差分のみを表示するか
        marker: "# " # メニューのマーカー
        # メニューのタイプ設定
        type: {
            layout: columnar # レイアウト: columnar
            columns: 4 # 列数
            col_width: 20 # 列幅
            col_padding: 2 # 列間のパディング
        }
        # メニューのスタイル設定
        style: {
            text: green # 通常テキストの色
            selected_text: green_reverse # 選択されたテキストの色
            description_text: yellow # 説明テキストの色
        }
        # メニューのソース (コマンドとその使用法を表示)
        source: { |buffer, position|
            $nu.scope.commands # 現在のスコープのコマンドを取得
            | where command =~ $buffer # バッファの内容に一致するコマンドをフィルタリング
            | each { |it| {value: $it.command description: $it.usage} } # value と description を持つレコードに変換
        }
      }
      # 変数メニューの設定
      {
        name: vars_menu # メニュー名
        only_buffer_difference: true # バッファとの差分のみを表示するか
        marker: "# " # メニューのマーカー
        # メニューのタイプ設定
        type: {
            layout: list # レイアウト: list
            page_size: 10 # 1ページあたりの項目数
        }
        # メニューのスタイル設定
        style: {
            text: green # 通常テキストの色
            selected_text: green_reverse # 選択されたテキストの色
            description_text: yellow # 説明テキストの色
        }
        # メニューのソース (変数名とその型を表示)
        source: { |buffer, position|
            $nu.scope.vars # 現在のスコープの変数を取得
            | where name =~ $buffer # バッファの内容に一致する変数名をフィルタリング
            | sort-by name # 名前でソート
            | each { |it| {value: $it.name description: $it.type} } # value と description を持つレコードに変換
        }
      }
      # 説明付きコマンドメニューの設定
      {
        name: commands_with_description # メニュー名
        only_buffer_difference: true # バッファとの差分のみを表示するか
        marker: "# " # メニューのマーカー
        # メニューのタイプ設定
        type: {
            layout: description # レイアウト: description
            columns: 4 # 列数
            col_width: 20 # 列幅
            col_padding: 2 # 列間のパディング
            selection_rows: 4 # 選択項目の表示行数
            description_rows: 10 # 説明の表示行数
        }
        # メニューのスタイル設定
        style: {
            text: green # 通常テキストの色
            selected_text: green_reverse # 選択されたテキストの色
            description_text: yellow # 説明テキストの色
        }
        # メニューのソース (コマンドとその使用法を表示)
        source: { |buffer, position|
            $nu.scope.commands # 現在のスコープのコマンドを取得
            | where command =~ $buffer # バッファの内容に一致するコマンドをフィルタリング
            | each { |it| {value: $it.command description: $it.usage} } # value と description を持つレコードに変換
        }
      }
      # ghq リポジトリメニューの設定
      {
        name: ghq_repo_menu # メニュー名
        only_buffer_difference: true # バッファとの差分のみを表示するか
        marker: "# " # メニューのマーカー
        # メニューのタイプ設定
        type: {
            layout: list # レイアウト: list
            page_size: 10 # 1ページあたりの項目数
        }
        # メニューのスタイル設定
        style: {
            text: green # 通常テキストの色
            selected_text: green_reverse # 選択されたテキストの色
            description_text: yellow # 説明テキストの色
        }
        # メニューのソース (ghq で管理されているリポジトリのパスを表示し、選択すると cd する)
        source: { |buffer, position|
            ghq list --full-path # ghq で管理されているリポジトリのフルパスを取得
            | lines # 行ごとに分割
            | where { |it| $it =~ $buffer } # バッファの内容に一致するパスをフィルタリング
            | each { |it| {value: $"cd ($it)" } } # `cd (パス)` という文字列を value とするレコードに変換
        }
      }
  ]
  # キーバインディングの設定
  keybindings: [
    # 補完メニューの表示 (Tab)
    {
      name: completion_menu # キーバインディング名
      modifier: none # 修飾キー (none, control, alt, shift)
      keycode: tab # キーコード (tab, enter, esc, backspace, char_x など)
      mode: emacs # モード (emacs, vi_normal, vi_insert)
      # イベント (キーが押されたときに実行されるアクション)
      event: {
        # until: 複数のアクションを順番に試行し、成功した時点で停止
        until: [
          { send: menu name: completion_menu } # completion_menu を表示
          { send: menunext } # 次のメニュー項目へ移動
        ]
      }
    }
    # 前の補完候補へ移動 (Shift+Tab)
    {
      name: completion_previous # キーバインディング名
      modifier: shift # 修飾キー: Shift
      keycode: backtab # キーコード: Backtab (Shift+Tab)
      mode: [emacs, vi_normal, vi_insert] # 複数のモードに適用
      event: { send: menuprevious } # 前のメニュー項目へ移動
    }
    # 履歴メニュー (コメントアウト中)
    # {
      # name: history_menu
      # modifier: control
      # keycode: char_r
      # mode: emacs
      # event: { send: menu name: history_menu }
    # }
    # メニューの次のページへ (Ctrl+X)
    {
      name: next_page # キーバインディング名
      modifier: control # 修飾キー: Control
      keycode: char_x # キーコード: Ctrl+X
      mode: emacs # モード: emacs
      event: { send: menupagenext } # メニューの次のページへ移動
    }
    # メニューの前のページへ、または Undo (Ctrl+Z)
    {
      name: undo_or_previous_page # キーバインディング名
      modifier: control # 修飾キー: Control
      keycode: char_z # キーコード: Ctrl+Z
      mode: emacs # モード: emacs
      event: {
        until: [
          { send: menupageprevious } # メニューの前のページへ移動
          { edit: undo } # 編集操作を元に戻す (Undo)
        ]
       }
    }
    # ユーザー定義メニューをトリガーするキーバインディング
    # コマンドメニュー (Ctrl+T)
    {
      name: commands_menu # キーバインディング名
      modifier: control # 修飾キー: Control
      keycode: char_t # キーコード: Ctrl+T
      mode: [emacs, vi_normal, vi_insert] # 複数のモードに適用
      event: { send: menu name: commands_menu } # commands_menu を表示
    }
    # 変数メニュー (Ctrl+Y)
    {
      name: vars_menu # キーバインディング名
      modifier: control # 修飾キー: Control
      keycode: char_y # キーコード: Ctrl+Y
      mode: [emacs, vi_normal, vi_insert] # 複数のモードに適用
      event: { send: menu name: vars_menu } # vars_menu を表示
    }
    # 説明付きコマンドメニュー (Ctrl+U)
    {
      name: commands_with_description # キーバインディング名
      modifier: control # 修飾キー: Control
      keycode: char_u # キーコード: Ctrl+U
      mode: [emacs, vi_normal, vi_insert] # 複数のモードに適用
      event: { send: menu name: commands_with_description } # commands_with_description を表示
    }
  ]
}

# PATH の設定
# $env.PATH = (
#   $env.PATH
#   | split row (char esep)
#   | prepend [
#     # ユーザーのバイナリディレクトリ
#     ($env.HOME | path join "bin")
#     ($env.HOME | path join ".local/bin")
#     # 開発言語関連のバイナリディレクトリ
#     ($env.HOME | path join "go/bin")
#     ($env.HOME | path join ".cargo/bin")
#     ($env.HOME | path join ".deno/bin")
#     # ツール関連のバイナリディレクトリ
#     ($env.HOME | path join ".local/share/nvim/mason/bin")
#     ($env.HOME | path join ".local/share/mise/shims")
#     ($env.HOME | path join ".local/share/aquaproj-aqua/bin")
#   ]
# )

# XDG Base Directory の設定
$env.XDG_CONFIG_HOME = ($env.HOME | path join ".config")
$env.XDG_CACHE_HOME = ($env.HOME | path join ".cache")
$env.XDG_DATA_HOME = ($env.HOME | path join ".local/share")
$env.XDG_STATE_HOME = ($env.HOME | path join ".local/state")
$env.INITVIM = ($env.XDG_CONFIG_HOME | path join "nvim/init.vim")
$env.VIMRC = ($env.HOME | path join ".vimrc")
$env.AQUA_GLOBAL_CONFIG = ($env.XDG_CONFIG_HOME | path join "aquaproj-aqua/aqua.yaml")

# 基本的な環境変数の設定
$env.BROWSER = "wslview"
$env.EDITOR = "nvim"
$env.SYSTEMD_EDITOR = $env.EDITOR
$env.TZ = "Asia/Tokyo"
# $env.GPG_TTY = (term size).tty

# エイリアスの設定
# 基本的なコマンドのエイリアス
alias ls = eza # ls を eza に置き換え
alias l = do { clear; eza } # クリアしてから eza を実行
alias ll = eza -alF --time-style "+%Y/%m/%d %H:%M" # 詳細なリスト表示
alias la = eza -A # 隠しファイルを含むリスト表示

# vim 関連のエイリアス
alias v = nvim # nvim のショートカット
alias va = nvim ~/work/workLog/a.md # 特定のファイルを開く
alias v. = nvim . # カレントディレクトリを開く
alias vr = nvim ./README.md # README.md を開く

# git 関連のエイリアス
alias s = git status # git status のショートカット
alias ga = git add # git add のショートカット
alias gc = git commit # git commit のショートカット
alias gp = git push # git push のショートカット
alias gpu = git push --upstream origin HEAD # 現在のブランチを origin にプッシュ
alias gl = git pull # git pull のショートカット
alias gs = git switch # git switch のショートカット
alias gd = git diff # git diff のショートカット
alias gsc = git switch -c # 新しいブランチを作成して切り替え
alias gcp = git cherry-pick # git cherry-pick のショートカット
alias groot = cd (git rev-parse --show-toplevel) # Git リポジトリのルートに移動

# github cli 関連のエイリアス
alias gas = gh auth switch # GitHub の認証切り替え

# chezmoi 関連のエイリアス
alias dot = chezmoi cd # chezmoi のディレクトリに移動
alias cu = do { pull_skk_dict; chezmoi update } # SKK辞書を更新して chezmoi update を実行
alias ca = chezmoi apply # chezmoi の変更を適用

# ディレクトリ移動のエイリアス
alias conf = cd ($env.HOME | path join ".config") # .config ディレクトリに移動
alias ob = cd ($env.HOME | path join "obsidian") # obsidian ディレクトリに移動

# その他のエイリアス
alias f = ghf # ghf コマンドのショートカット
alias ai = aqua i -a # aqua install のショートカット
alias ag = aqua g # aqua global のショートカット
alias a = aqua # aqua のショートカット
alias skkadd = update_skk_dict # SKK辞書の更新
alias skkpull = pull_skk_dict # SKK辞書の取得
alias skk = cd ~/.skk # SKKディレクトリに移動
alias fsi = dotnet fsi # F# インタラクティブ
alias lc = leetcode # leetcode コマンドのショートカット
alias startuptime = vim-startuptime -count 100 -vimpath nvim # nvim の起動時間計測

# 開発ディレクトリへの移動エイリアス（ホスト名に基づく条件分岐）
# work
alias work = cd ($env.HOME | path join "work/workLog")
alias snsd = cd ($env.HOME | path join "repo/local-dev-env/ut-tools")
# private
alias dia = cd ($env.HOME | path join "myself/diary")
alias shd = cd ($env.HOME | path join "work/sh-dev")
alias god = cd ($env.HOME | path join "work/go-dev")
alias vimd = cd ($env.HOME | path join "work/vim-dev")
alias dockerd = cd ($env.HOME | path join "work/docker-dev")
alias javad = cd ($env.HOME | path join "work/java-dev")
alias grpcd = cd ($env.HOME | path join "work/grpc-dev")
alias hobbyd = cd ($env.HOME | path join "myself/hobby")
alias techd = cd ($env.HOME | path join "myself/tech")

# 外部ツールの初期化
source ~/.config/atuin/atuin.nu
source ~/.config/zoxide/zoxide.nu

# 初期化スクリプトの読み込み
# if ("~/.cache/mise/init.nu" | path exists) { source ~/.cache/mise/init.nu }
# if ("~/.cache/zoxide/init.nu" | path exists) { source ~/.cache/zoxide/init.nu }
# if ("~/.cache/atuin/init.nu" | path exists) { source ~/.cache/atuin/init.nu }
# if ("~/.cache/starship/init.nu" | path exists) { source ~/.cache/starship/init.nu }

# モジュールの読み込み
# let modules_dir = "~/.config/nushell/my_modules"
# プロンプトの設定 (コメントアウト中)
# 左側プロンプトを作成する関数
