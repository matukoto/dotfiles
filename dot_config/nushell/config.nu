# Nushell 設定ファイル

# 補完に関する設定モジュール
module completions {
  # 外部コマンド（Nushell 外部のコマンド）のカスタム補完
  # 各補完は2つの部分から構成される: 外部コマンドの形式（フラグとパラメータを含む）
  # および、それらのフラグとパラメータの値を補完する方法を知っているヘルパーコマンド
  #
  # git ブランチと git リモートの補完の簡略版
  # git ブランチ名を補完する関数
  def "nu-complete git branches" [] {
    ^git branch | lines | each { |line| $line | str replace -r '[\*\+] ' '' | str trim }
  }

  # git リモート名を補完する関数
  def "nu-complete git remotes" [] {
    ^git remote | lines | each { |line| $line | str trim }
  }

  # make のターゲットを補完する関数
  def "nu-complete make" [] {
    open Makefile | lines | where $it =~ '^[^\.][^:^ ]+:' | each { |line| echo $line | str replace '([^:]+):.*' '${1}' }
  }


  # make コマンドの外部コマンド定義と補完設定
  export extern "make" [
    task?: string@"nu-complete make"
    -b                                          # Ignored for compatibility.
    -m                                          # Ignored for compatibility.
    --always-make(-B)                           # Unconditionally make all targets.
    --directory(-C): string                     # Change to DIRECTORY before doing anything.
    -d                                          # Print lots of debugging information.
    --debug: string                             # Print various types of debugging information.
    --environment-overrides(-e)                 # Environment variables override makefiles.
    --eval(-E): string                          # Evaluate STRING as a makefile statement.
    --file(-f): string                          # Read FILE as a makefile.
    --makefile: string                          # Read FILE as a makefile.
    --help(-h)                                  # Print this message and exit.
    --ignore-errors(-i)                         # Ignore errors from recipes.
    --include-dir(-I): string                   # Search DIRECTORY for included makefiles.
    --jobs(-j): int                             # Allow N jobs at once; infinite jobs with no arg. [=N]
    --jobserver-style: string                   # Select the style of jobserver to use.
    --keep-going(-k)                            # Keep going when some targets can't be made.
    --load-average(-l): int                     # Don't start multiple jobs unless load is below N.
    --max-load: int                             # Don't start multiple jobs unless load is below N.
    --check-symlink-times(-L)                   # Use the latest mtime between symlinks and target.
    --just-print(-n)                            # Don't actually run any recipe; just print them.
    --dry-run                                   # Don't actually run any recipe; just print them.
    --recon                                     # Don't actually run any recipe; just print them.
    --old-file(-o): string                      # Consider FILE to be very old and don't remake it.
    --assume-old: string                        # Consider FILE to be very old and don't remake it.
    --output-sync(-O)                           # Synchronize output of parallel jobs by TYPE.
    --print-data-base(-p)                       # Print make's internal database.
    --question(-q)                              # Run no recipe; exit status says if up to date.
    --no-builtin-rules(-r)                      # Disable the built-in implicit rules.
    --no-builtin-variables(-R)                  # Disable the built-in variable settings.
    --shuffle: string                           # Perform shuffle of prerequisites and goals. [={SEED|random|reverse|none}]
    --silent(-s)                                # Don't echo recipes.
    --quiet                                     # Don't echo recipes.
    --no-silent                                 # Echo recipes (disable --silent mode).
    --no-keep-going(-S)                         # Turns off -k.
    --stop                                      # Turns off -k.
    --touch(-t)                                 # Touch targets instead of remaking them.
    --trace                                     # Print tracing information.
    --version(-v)                               # Print the version number of make and exit.
    --print-directory(-w)                       # Print the current directory.
    --no-print-directory                        # Turn off -w, even if it was turned on implicitly.
    --what-if(-W): string                       # Consider FILE to be infinitely new.
    --new-file: string                          # Consider FILE to be infinitely new.
    --assume-new: string                        # Consider FILE to be infinitely new.
    --warn-undefined-variables                  # Warn when an undefined variable is referenced.
  ]

  # git fetch コマンドの外部コマンド定義と補完設定
  # 他のリポジトリからオブジェクトと参照をダウンロードする
  export extern "git fetch" [
    repository?: string@"nu-complete git remotes" # name of the branch to fetch
    --all                                         # Fetch all remotes
    --append(-a)                                  # Append ref names and object names to .git/FETCH_HEAD
    --atomic                                      # Use an atomic transaction to update local refs.
    --depth: int                                  # Limit fetching to n commits from the tip
    --deepen: int                                 # Limit fetching to n commits from the current shallow boundary
    --shallow-since: string                       # Deepen or shorten the history by date
    --shallow-exclude: string                     # Deepen or shorten the history by branch/tag
    --unshallow                                   # Fetch all available history
    --update-shallow                              # Update .git/shallow to accept new refs
    --negotiation-tip: string                     # Specify which commit/glob to report while fetching
    --negotiate-only                              # Do not fetch, only print common ancestors
    --dry-run                                     # Show what would be done
    --write-fetch-head                            # Write fetched refs in FETCH_HEAD (default)
    --no-write-fetch-head                         # Do not write FETCH_HEAD
    --force(-f)                                   # Always update the local branch
    --keep(-k)                                    # Keep dowloaded pack
    --multiple                                    # Allow several arguments to be specified
    --auto-maintenance                            # Run 'git maintenance run --auto' at the end (default)
    --no-auto-maintenance                         # Don't run 'git maintenance' at the end
    --auto-gc                                     # Run 'git maintenance run --auto' at the end (default)
    --no-auto-gc                                  # Don't run 'git maintenance' at the end
    --write-commit-graph                          # Write a commit-graph after fetching
    --no-write-commit-graph                       # Don't write a commit-graph after fetching
    --prefetch                                    # Place all refs into the refs/prefetch/ namespace
    --prune(-p)                                   # Remove obsolete remote-tracking references
    --prune-tags(-P)                              # Remove any local tags that do not exist on the remote
    --no-tags(-n)                                 # Disable automatic tag following
    --refmap: string                              # Use this refspec to map the refs to remote-tracking branches
    --tags(-t)                                    # Fetch all tags
    --recurse-submodules: string                  # Fetch new commits of populated submodules (yes/on-demand/no)
    --jobs(-j): int                               # Number of parallel children
    --no-recurse-submodules                       # Disable recursive fetching of submodules
    --set-upstream                                # Add upstream (tracking) reference
    --submodule-prefix: string                    # Prepend to paths printed in informative messages
    --upload-pack: string                         # Non-default path for remote command
    --quiet(-q)                                   # Silence internally used git commands
    --verbose(-v)                                 # Be verbose
    --progress                                    # Report progress on stderr
    --server-option(-o): string                   # Pass options for the server to handle
    --show-forced-updates                         # Check if a branch is force-updated
    --no-show-forced-updates                      # Don't check if a branch is force-updated
    -4                                            # Use IPv4 addresses, ignore IPv6 addresses
    -6                                            # Use IPv6 addresses, ignore IPv4 addresses
    --help                                        # Display this help message 
  ]

  # git checkout コマンドの外部コマンド定義と補完設定
  # git ブランチやファイルをチェックアウトする
  export extern "git checkout" [
    ...targets: string@"nu-complete git branches"   # name of the branch or files to checkout
    --conflict: string                              # conflict style (merge or diff3)
    --detach(-d)                                    # detach HEAD at named commit
    --force(-f)                                     # force checkout (throw away local modifications)
    --guess                                         # second guess 'git checkout <no-such-branch>' (default)
    --ignore-other-worktrees                        # do not check if another worktree is holding the given ref
    --ignore-skip-worktree-bits                     # do not limit pathspecs to sparse entries only
    --merge(-m)                                     # perform a 3-way merge with the new branch
    --orphan: string                                # new unparented branch
    --ours(-2)                                      # checkout our version for unmerged files
    --overlay                                       # use overlay mode (default)
    --overwrite-ignore                              # update ignored files (default)
    --patch(-p)                                     # select hunks interactively
    --pathspec-from-file: string                    # read pathspec from file
    --progress                                      # force progress reporting
    --quiet(-q)                                     # suppress progress reporting
    --recurse-submodules: string                    # control recursive updating of submodules
    --theirs(-3)                                    # checkout their version for unmerged files
    --track(-t)                                     # set upstream info for new branch
    -b: string                                      # create and checkout a new branch
    -B: string                                      # create/reset and checkout a branch
    -l                                              # create reflog for new branch
    --help                                          # Display this help message
  ]

  # git push コマンドの外部コマンド定義と補完設定
  # 変更をプッシュする
  export extern "git push" [
    remote?: string@"nu-complete git remotes",      # the name of the remote
    ...refs: string@"nu-complete git branches"      # the branch / refspec
    --all                                           # push all refs
    --atomic                                        # request atomic transaction on remote side
    --delete(-d)                                    # delete refs
    --dry-run(-n)                                   # dry run
    --exec: string                                  # receive pack program
    --follow-tags                                   # push missing but relevant tags
    --force-with-lease                              # require old value of ref to be at this value
    --force(-f)                                     # force updates
    --ipv4(-4)                                      # use IPv4 addresses only
    --ipv6(-6)                                      # use IPv6 addresses only
    --mirror                                        # mirror all refs
    --no-verify                                     # bypass pre-push hook
    --porcelain                                     # machine-readable output
    --progress                                      # force progress reporting
    --prune                                         # prune locally removed refs
    --push-option(-o): string                       # option to transmit
    --quiet(-q)                                     # be more quiet
    --receive-pack: string                          # receive pack program
    --recurse-submodules: string                    # control recursive pushing of submodules
    --repo: string                                  # repository
    --set-upstream(-u)                              # set upstream for git pull/status
    --signed: string                                # GPG sign the push
    --tags                                          # push tags (can't be used with --all or --mirror)
    --thin                                          # use thin pack
    --verbose(-v)                                   # be more verbose
    --help                                          # Display this help message
  ]

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
  # use_grid_icons: true # グリッドアイコンを使用するかどうか (新しい Nushell バージョンでは削除されたオプション)
  footer_mode: 25 # フッターの表示モード: always, never, number_of_rows, auto (文字列 "25" を整数 25 に変更)
  float_precision: 2 # 浮動小数点数の表示精度
  # buffer_editor: "emacs" # Ctrl+o で現在の行バッファを編集するコマンド。未設定の場合は $env.EDITOR, $env.VISUAL にフォールバック
  use_ansi_coloring: true # ANSI カラーリングを使用するかどうか
  edit_mode: emacs # 行編集モード: emacs, vi
  # シェル統合設定 (ターミナルエミュレータとの連携機能)
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
  history: {
    max_size: 10000 # 履歴の最大サイズ (反映にはセッションの再読み込みが必要)
    sync_on_enter: true # Enter キーを押したときに履歴を同期するか (複数セッション間で履歴を共有する場合に有効。無効の場合、セッション終了時にファイルに書き込み)
    file_format: "plaintext" # 履歴ファイルの形式: "sqlite" または "plaintext"
  }
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

  # フックの設定 (特定のイベント発生時に実行されるコード)
  hooks: {
    # プロンプトが表示される前に実行されるフック
    pre_prompt: [{||
      # direnv が存在しない場合は何もしない
      if (which direnv | is-empty) {
        return
      }

      # direnv から環境変数を JSON 形式でエクスポートし、パースする (失敗した場合は空のレコード)
      mut envrc = (direnv export json | from json | default {})
      # 環境変数が空の場合は何もしない
      if ($envrc | is-empty) {
        return
      }

      # Path が null の場合 (Windows 環境など)、PATH を ; で分割して Path に設定
      if ($envrc.Path == null) {
        $envrc.Path = ($envrc.PATH | split row ";")
      }
      # direnv から取得した環境変数をロードする
      $envrc | load-env

    }]
    # REPL の入力が実行される前に実行されるフック
    pre_execution: [{||
      null  # ここに実行したいコードを記述
    }]
  }
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
    # fzf を使用した履歴検索 (Ctrl+R)
    {
      name: fuzzy_history # キーバインディング名
      modifier: control # 修飾キー: Control
      keycode: char_r # キーコード: Ctrl+R
      mode: emacs # モード: emacs
      event: {
        send: executehostcommand # ホストコマンドを実行
        # 履歴を fzf でフィルタリングし、選択されたコマンドでコマンドラインを置換
        cmd: "commandline edit --replace (
                history |
                  each { |it| $it.command } |
                  uniq |
                  reverse |
                  str join (char -i 0) |
                  fzf --read0 --layout=reverse --height=40% -q (commandline) |
                  decode utf-8 |
                  str trim
            )"
      }
    }
    # fzf を使用した ghq リポジトリへの cd (コメントアウト中)
    # {
      # name: fuzzy_cd_ghq_repository
      # modifier: control
      # keycode: char_]
      # mode: emacs
      # event: [
        # # { edit: Clear }
        # { send: menu name: ghq_repo_menu }
        # # { send: Enter }
      # ]
    # }
    # fzf を使用した ghq リポジトリへの cd (Ctrl+])
    {
      name: fuzzy_cd_ghq_repository # キーバインディング名
      modifier: control # 修飾キー: Control
      keycode: char_] # キーコード: Ctrl+]
      mode: emacs # モード: emacs
      event: {
        send: executehostcommand # ホストコマンドを実行
        # ghq リストを fzf でフィルタリングし、選択されたリポジトリに cd
        cmd: "cd (ghq list --full-path | fzf --layout=reverse --height=40% -q (commandline) | decode utf-8 | str trim)"
      }
    }
    # pet search を実行してコマンドラインに挿入 (Ctrl+H)
    {
      name: pet_search # キーバインディング名
      modifier: control # 修飾キー: Control
      keycode: char_h # キーコード: Ctrl+H
      mode: emacs # モード: emacs
      event: [
        # pet search の結果をコマンドラインに挿入
        {
          edit: insertString,
          value: "commandline (pet search | decode utf-8 | str trim)"
        }
        { send: Enter } # Enter キーを送信 (コマンドを実行)
      ]
    }
    # 特定のファイルからユーザー名を fzf で検索してコマンドラインに挿入 (Ctrl+.)
    {
      name: connehito_db_user_search # キーバインディング名
      modifier: control # 修飾キー: Control
      keycode: char_. # キーコード: Ctrl+.
      mode: emacs # モード: emacs
      event: [
        # 指定された YAML ファイルからユーザーリストを取得し、fzf でフィルタリングしてコマンドラインに挿入
        {
          edit: insertString,
          value: "(commandline (open ~/ghq/github.com/Connehito/mamari-db/ansible/prd/roles/mamari/tasks/main.yml | get loop.12.user | to text | fzf --layout=reverse --height=40% -q (commandline) | decode utf-8 | str trim))"
        }
        { send: Enter } # Enter キーを送信 (コマンドを実行)
      ]
    }
  ]
}

# 環境変数の設定
$env.BAT_PAGER = 'never' # bat コマンドのページャーを無効化
$env.BAT_THEME = 'Nord' # bat コマンドのテーマを設定

# Path 環境変数にユーザーの bin ディレクトリを追加 (コメントアウト中)
# let-env Path = ( $env.Path | append ($env.USERPROFILE + "\\bin"))

# オーバーレイを使用して他の Nushell スクリプトを読み込む (コメントアウト中)
# starship の初期化スクリプト
# overlay use ~\.cache\starship\init.nu
# go-task の補完スクリプト
# overlay use ~\AppData\Roaming\nushell\my_modules\completions\go-task.nu
# terraform の補完スクリプト
# overlay use ~\AppData\Roaming\nushell\my_modules\completions\terraform.nu
# connehito 関連の関数スクリプト
# overlay use ~\AppData\Roaming\nushell\my_modules\functions\connehito_functions.nu
# scoop の補完スクリプト
# overlay use ~\ghq\github.com\nushell\nu_scripts\custom-completions\scoop\scoop-completions.nu


# プロンプトの設定 (コメントアウト中)
# 左側プロンプトを作成する関数
# def create_left_prompt [] {
  # # 現在のディレクトリパス
  # let path_segment = ($env.PWD)

  # # Git リポジトリの場合、現在のブランチ名を表示
  # let git_current_branch = (
    # if (".git" | path exists) {
      # $" (ansi yellow)[(git branch --show-current)]" # 黄色で表示
    # } else {
      # "" # Git リポジトリでない場合は空文字列
    # }
  # )

  # # 改行 + パス + Git ブランチ + 改行 + スペース
  # "\n" + $path_segment + $git_current_branch + "\n "
# }
# # 左側プロンプトを生成するコマンドを設定
# $env.PROMPT_COMMAND = { create_left_prompt }
# # プロンプトのインジケーターを設定
# $env.PROMPT_INDICATOR = "❯ "

# # 右側プロンプトを作成する関数
# def create_right_prompt [] {

  # # 現在の日時を表示
  # let datetime_segment = (date now | format date "%Y-%m-%d %H:%M:%S" | str join " ")
  # # Git ステータス (dirty/clean) を表示する例 (コメントアウト中)
  # # let git_segment = (
    # # if (".git" | path exists) {
      # # let git_segment = (git status --porcelain | lines | count | if $it > 0 { echo "dirty" } { echo "clean" } | str trim | str join " ")
      # # $git_segment
    # # } else {
      # # ""
    # # }
  # # )

  # # $git_segment
  # $datetime_segment # 日時のみ表示
# }

# # 右側プロンプトを生成するコマンドを設定
# $env.PROMPT_COMMAND_RIGHT = { create_right_prompt }
# # 複数行入力時のインジケーターを設定
# $env.PROMPT_MULTILINE_INDICATOR = "::: "
