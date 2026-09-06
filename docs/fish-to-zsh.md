# Fish から Zsh への移行調査・作業記録

最終更新: 2026-09-05

## 目的・現在の状況

別のパソコンでの開発に向け、現在の Fish 環境を棚卸しし、移行する機能と設定を整理する。
ユーザーの「Gシェル」は、作業ブランチが `fish2zsh` であることから Zsh と解釈している。
移行先は macOS / M4、管理者権限なし。Nix / Home Manager、aqua、mise は使用しない。
Vi 操作と Neovim 内の切り替えを維持する。
短縮入力は当初省略したが、追加指示により汎用的なものを Zsh の alias として移植。
ユーザーの「熱い属脂度」は Atuin / zoxide を指すと解釈し、今回は除外。
個人用設定・既存履歴は移行対象外。このパソコンの Fish は維持し、Zsh を子シェルとして試す。

独立した Zsh 設定を [config/zsh](../config/zsh/README.md) に実装。
主要なプロンプト表示を Zsh 標準で再現し、外部ツールは存在する場合だけ使用する。
現行の Fish、Home Manager、ログインシェル、ホームの起動ファイルは変更していない。
移行先へのコピーと実機確認は未実施。
ユーザーの追加指示により、テストコードの整備・追加のテスト実行は行わない。
途中で作成した Ruby テストは削除。通常利用に Ruby は不要。
今後の調査結果、判断、変更内容、検証結果はこのドキュメントに追記する。

## 調査範囲と確度

- リポジトリの設定、実際の `~/.config/fish/`、システム側の Fish 設定を確認。
- 配備済みの独自 `conf.d` / `functions` を元ファイルと比較。未配備の Copilot 関数2つを除き、一致を確認。
- Fish のバージョンは実行結果で確認。それ以外のツールの指定バージョンは導入済みバージョンを保証しない。
- 永続変数、初期化キャッシュ、補完定義、履歴・データ保存先を確認。
- 履歴本文、認証情報、既存セッションだけにある一時変数・関数は調査していない。
- 対話シェルでの操作確認、各コマンドの実行、性能測定は未実施。以下の動作説明は設定・コードからの確認。

## 設定の管理構造

| 項目 | 現状 |
| --- | --- |
| Fish 本体 | 4.8.0。確認した実行パスは `/etc/profiles/per-user/matukoto/bin/fish` |
| ログインシェル | nix-darwin で Fish を指定 |
| ユーザー設定 | Home Manager が `~/.config/fish/` へ配備 |
| プロンプト | Tide と独自表示関数 |
| キーバインド | 通常は Vi、Neovim 内は標準 |
| 履歴 | Fish 標準履歴と Atuin |
| 移動支援 | zoxide、ghq + fzf |
| ツール導入 | Nix、aqua、mise、Homebrew |

主要ファイル:

| 設定元 | 役割 |
| --- | --- |
| [modules/fish.nix](../config/home-manager/modules/fish.nix) | Fish 有効化、Tide 導入、OS 差分・ハッシュ挿入、関数の配備・生成 |
| [fish/config.fish](../config/home-manager/fish/config.fish) | 環境変数、PATH、短縮入力、ツール初期化 |
| [fish/conf.d](../config/home-manager/fish/conf.d) | キーバインド、起動メッセージ、Tide 設定 |
| [fish/functions](../config/home-manager/fish/functions) | 独自コマンドと Tide 表示関数 |
| [darwin-system.nix](../config/home-manager/darwin-system.nix) | macOS のログインシェル設定 |
| [modules/files.nix](../config/home-manager/modules/files.nix) | 関連ツール設定・ローカルスクリプトの配備 |

`~/.config/fish/config.fish` は Nix store へのリンクで、Home Manager の生成物。
元テンプレートに加え、Home Manager のセッション変数読み込みと生成補完パスの追加がある。
`/etc/fish/config.fish` と `/etc/fish/nixos-env-preinit.fish` では、nix-darwin が foreign-env 経由でシステム環境を取り込む。
ユーザーの `conf.d` では `_key_bindings.fish` を Tide 初期化より先に処理する意図で命名している。

## 環境変数と PATH

以下は対話・非対話共通の設定。

| 変数 | 値・条件 |
| --- | --- |
| `XDG_CONFIG_HOME` | `$HOME/.config` |
| `XDG_CACHE_HOME` | `$HOME/.cache` |
| `XDG_DATA_HOME` | `$HOME/.local/share` |
| `XDG_STATE_HOME` | `$HOME/.local/state` |
| `INITVIM` | `$XDG_CONFIG_HOME/nvim/init.vim` |
| `VIMRC` | `$HOME/.vimrc` |
| `AQUA_GLOBAL_CONFIG` | `$XDG_CONFIG_HOME/aqua/aqua.yaml` |
| `FISH_CONFIG_DIR` | `$XDG_CONFIG_HOME/fish` |
| `FISH_FUNCTIONS_DIR` | `$FISH_CONFIG_DIR/functions` |
| `FISH_CACHE_DIR` | `$XDG_CACHE_HOME/fish` |
| `EDITOR` / `SYSTEMD_EDITOR` | `nvim` |
| `TZ` | `Asia/Tokyo` |
| `GPG_TTY` | TTY があるときに `tty` の結果を設定 |
| `BROWSER` | macOS は `open`、Linux 側は `wslview` |
| `PRIVATE_PLUGIN_ENABLED` | macOS のみ `true` を設定 |
| `FISH_CONFIG_GENERATION_HASH` | Nix が生成する初期化キャッシュ判定用のハッシュ |

`fish_add_path` の定義順:

```text
~/bin
~/.local/bin
~/go/bin
~/.cargo/bin
~/.deno/bin
~/.local/share/aquaproj-aqua/bin
```

調査時の `fish_variables` に保存されていた `fish_user_paths` の順序:

```text
~/.local/share/aquaproj-aqua/bin
~/.local/share/nvim/mason/bin
~/.cargo/bin
~/.local/bin
```

Mason の PATH は現在の Fish テンプレートにない端末固有の設定。
上記は定義順と永続保存値であり、mise 等を含む最終的な実行時 PATH の全体・優先順位は未確認。

システム側には Nix のプロファイル用 PATH、`NIX_PATH`、`NIX_SSL_CERT_FILE`、
`TERMINFO_DIRS`、`XDG_CONFIG_DIRS`、`XDG_DATA_DIRS` などがある。
`PAGER="less -R"`、`HOMEBREW_NO_AUTO_UPDATE=1` も設定される。
システムの `EDITOR=nano` はユーザーの Fish 設定で `nvim` に上書きされる。

## 入力操作・履歴・補完

| 項目 | 設定 |
| --- | --- |
| 通常のキー操作 | `fish_vi_key_bindings` |
| Neovim 内 | `$NVIM` があれば `fish_default_key_bindings` |
| 起動メッセージ | `set -U fish_greeting` で空にする |
| 履歴検索 | Atuin の `Ctrl-R`。Vi insert モードにも登録 |
| 上矢印 | Atuin 初期化時に `--disable-up-arrow` を指定 |
| 履歴選択の Enter | Atuin の `enter_accept = true` |
| Atuin 同期設定 | `[sync] records = true`。ログイン・同期状態は未確認 |
| 行頭の `?` | 現在の Atuin 初期化キャッシュに AI 呼び出しのキー定義あり。モードごとの操作は未検証 |
| 補完 | Fish 標準、Home Manager 生成補完、Tide、ローカルの Copilot / OpenCode 補完 |

Atuin の設定元は [config/atuin/config.toml](../config/atuin/config.toml)。
Fish 本体が提供する補完、入力候補、構文ハイライトなども、移行時に操作感を確認する対象。
Home Manager の Fish プラグイン定義は Tide のみ。

## 短縮入力（abbr）全41件

通常の alias ではなく、入力時にコマンドへ展開する Fish の `abbr` として定義されている。

| 入力 | 展開先 |
| --- | --- |
| `f` | `ghf` |
| `ai` | `aqua i -a` |
| `ag` | `aqua g` |
| `mi` | `mise i` |
| `skkadd` | `update_skk_dict` |
| `skkpull` | `pull_skk_dict` |
| `skk` | `cd ~/.skk` |
| `fsi` | `dotnet fsi` |
| `s` | `git status` |
| `ga` | `git add` |
| `gc` | `git commit` |
| `gp` | `git push` |
| `gpu` | `git push --set-upstream origin HEAD` |
| `gpl` | `git pull` |
| `gl` | `git log` |
| `gs` | `git switch` |
| `gd` | `git diff` |
| `gsc` | `git switch -c` |
| `gcp` | `git cherry-pick` |
| `groot` | `cd (git rev-parse --show-toplevel)` |
| `gas` | `gh auth switch` |
| `ll` | `eza -alF --time-style "+%Y/%m/%d %H:%M"` |
| `la` | `eza -A` |
| `l` | `clear && eza` |
| `ls` | `eza` |
| `lc` | `leetcode` |
| `v` | `nvim` |
| `va` | `nvim ~/work/workLog/a.md` |
| `v.` | `nvim .` |
| `vr` | `nvim ./README.md` |
| `dot` | `cd $HOME/work/github.com/matukoto/dotfiles/` |
| `cu` | `git -C $HOME/work/github.com/matukoto/dotfiles pull --rebase` |
| `ca` | `hms` |
| `conf` | `cd $HOME/.config` |
| `ob` | `cd $HOME/obsidian/` |
| `browser-html` | `deno run -A --unstable npm:browser-sync start --server --files "*.html"` |
| `startuptime` | `vim-startuptime -count 100 -vimpath nvim` |
| `a` | `aqua` |
| `cps` | `copilot --allow-tool shell --deny-tool "shell(git push)" --deny-tool "shell(rm)"` |
| `cpy` | `copilot --allow-all` |
| `ns` | `nix-search-tv print \| fzf --preview 'nix-search-tv preview {}' --scheme history` |

## 関数と補助コマンド

| 関数 | 動作・依存 |
| --- | --- |
| `ghf` | `ghq list -p` を fzf で選択し移動。現実装は `eval cd $d` を使用 |
| `yy` | Yazi を起動し、一時ファイル経由で終了時のディレクトリへシェルも移動 |
| `update_skk_dict` | `~/.skk/userdict.txt` を add、日付付き commit、push。元のディレクトリへ戻る |
| `pull_skk_dict` | `~/.skk` で fetch、`origin/main` へ rebase。元のディレクトリへ戻る |
| `hms` | dotfiles で Home Manager を適用。元のディレクトリと終了コードを扱う |
| `hmu` | dotfiles で `nix flake update` 後、Home Manager を適用 |
| `hmd` | macOS 限定。sudo で nix-darwin を適用 |
| `brew` | 初回呼び出し時に自身を解除し、`/opt/homebrew/bin/brew shellenv` を評価して実行 |
| `z` / `zi` | zoxide の初期化コードが生成する移動コマンド |

`hms` / `hmu` / `hmd` は [fish.nix](../config/home-manager/modules/fish.nix) から生成。
Home Manager の対象は macOS では `darwin`、それ以外では Nix の `hostname` 引数。
`hmu` に nix-darwin の適用は含まれない。

リポジトリに存在するが未配備の関数:

| 関数 | 定義内容 |
| --- | --- |
| `copilot-safe` | Git ルートへ移動し、shell 許可・push/rm 拒否・GitHub URL 許可を指定して起動後、元の場所へ戻る |
| `copilot-yolo` | `copilot --allow-all` に引数を渡す |

上記2つは Home Manager の配備定義にも実際の関数ディレクトリにもない。
`cps` / `cpy` はこれらの関数を呼ばず、直接 Copilot を呼ぶ。
ルート README の `copilot_safe` / `copilot_yolo` 表記とも一致していない。

Fish 以外の補助スクリプトは [home/local/bin](../home/local/bin) から `~/.local/bin` に配備される。

| スクリプト | 内容 |
| --- | --- |
| `build-nvim` | 固定配置の Neovim リポジトリを更新・クリーンビルドし `~/.local` へ導入 |
| `search-github` | gh を使った GitHub のファイル検索 |
| `grep_japanese` | ripgrep の PCRE2 で日本語を検索 |
| `app-toggle` | macOS / AeroSpace のアプリ切り替え |
| `aerospace-focus-handler` | AeroSpace のワークスペース移動 |

これらは Bash / sh スクリプトであり、Fish 関数とは別管理。
`ghq.root` は [Git 設定](../config/home-manager/modules/git.nix) で `~/work` に設定。

## Tide プロンプト

設定元: [tide_settings.fish](../config/home-manager/fish/conf.d/tide_settings.fish)。
ファイルの mtime が保存値と異なる場合のみ、Universal 変数を更新する。
mtime の取得は macOS の `stat -f` と Linux の `stat -c` で分岐。

| 項目 | 設定 |
| --- | --- |
| 左側 | `os pwd git newline vi_mode character` |
| 右側 | 終了状態、実行時間、接続情報、ジョブ、言語・クラウド情報、時刻 |
| 配色・装飾 | 背景色は基本 `normal`、枠なし、空白区切り |
| 行間 | プロンプト前に空行 |
| transient prompt | 無効 |
| 最小列数 | 34 |
| 入力記号 | `❯`。成功は緑、失敗は赤 |
| Vi 表示 | モードごとに記号・色を変更。Neovim 内は非表示 |
| 実行時間 | 3,000ms 以上で表示、小数0桁 |
| 接続情報 | 常時表示は無効、ホスト名は1部分 |
| 時刻 | `%T`（時分秒） |
| Git ブランチ名 | 最大24文字 |
| 現在地 | プロジェクト識別ファイルをマーカーとして設定、ディレクトリ種別で色分け |

右側に指定される項目の全体:

```text
status cmd_duration context jobs direnv bun node svelte python rustc
java csharp fsharp php pulumi ruby go gcloud kubectl distrobox toolbox
terraform aws nix_shell crystal elixir zig lua time
```

これは表示候補の設定で、全項目が常に出るわけではない。
端末に保存された Tide の内部表示候補には、使用可能な項目に絞られたリストもある。
Docker、private mode、shlvl の色等の設定は存在するが、上の表示項目には含まれない。

独自表示関数:

| 対象 | 内容 |
| --- | --- |
| Git | ブランチ／タグ／コミット、stash、競合、stage、変更、未追跡、ahead/behind、rebase 等の操作状態 |
| Vi モード | insert / normal / replace / visual の表示と Neovim 内の抑制 |
| 入力記号 | 終了状態による色、Vi モード表示との役割分担 |
| Java | Maven / Gradle / Java ファイル等を検出し `java -version` |
| Lua | Lua ファイルや `.lua-version` を検出し `lua -v` |
| Svelte | 親ディレクトリを含む `package.json` の依存記述からバージョン抽出 |
| C# | `.csproj` / `.sln` / `global.json` を検出し `dotnet --version` |
| F# | `.fsproj` / `.sln` / `global.json` を検出し `dotnet --version` |

フォントは [Ghostty](../config/ghostty/config) と [WezTerm](../config/wezterm/wezterm.lua) で
`HackGen Console NF` を指定。Tide のアイコンには Nerd Font のグリフを使用。

## 初期化キャッシュ

対話シェルで、次の出力を `~/.cache/fish/config.fish` に保存して source する。

```fish
zoxide init fish
mise activate fish
atuin init --disable-up-arrow fish
```

- 各ツールは `type -q` で存在を確認してから初期化コードを生成。
- Atuin 初期化コード中の `atuin uuid` を `uuidgen` に置換。
- zoxide は PWD 変更時に移動履歴を記録。
- mise はプロンプト、ディレクトリ変更、コマンド実行前などのフックを定義。
- Atuin はコマンド実行前後の履歴記録フックとキー設定を定義。

再生成条件:

1. キャッシュファイルがない。
2. `config.fish.hash` がない。
3. Fish 設定の生成ハッシュが保存値と異なる。
4. `aqua.yaml` がキャッシュより新しい。

ツールのバイナリ更新そのものや mise の設定変更を直接検出する条件はない。
この Fish 向け生成物を移行先シェルでそのまま使用することは移行案に含めない。

## 外部依存・端末固有の配置

| 管理元 | シェルに関係する主な対象 |
| --- | --- |
| Nix / Home Manager | Fish、Tide、mise、aqua、gh、GnuPG、nix-search-tv、フォントなど |
| aqua | ghq、fzf、eza、zoxide、Atuin、Yazi、Deno、Bun、Copilot など |
| mise | Java、Rust、Go、Node、Lua、.NET、npm 系 CLI など |
| Homebrew | macOS 向けパッケージと shellenv |

バージョン指定の原本:

- [aqua.yaml](../config/aqua/aqua.yaml)
- [mise/config.toml](../config/mise/config.toml)
- [home.nix](../config/home-manager/home.nix)
- [darwin-homebrew.nix](../config/home-manager/darwin-homebrew.nix)
- [flake.lock](../flake.lock)

移行先で配置・利用有無を確認するパス:

- `~/work/github.com/matukoto/dotfiles/`
- `~/work/github.com/neovim/neovim/`
- `~/work/workLog/a.md`
- `~/.skk/` とその `userdict.txt`、`origin/main`
- `~/obsidian/`
- `/opt/homebrew/bin/brew`

## リポジトリと実環境の差分・注意点

| 発見事項 | 移行時の扱い・未確認事項 |
| --- | --- |
| Mason の PATH が永続変数にのみ存在 | 新環境でも必要か確認し、必要なら明示的に管理 |
| Copilot 関数2つが未配備 | 関数を採用するか、現行の短縮入力を維持するか判断 |
| Fisher / ローカル Tide ファイルが残存 | Nix 管理の Tide と併存。読み込み優先順位や版の差は追加調査対象 |
| `tide_debug.fish` がリンク切れ | 旧 `~/.local/share/chezmoi/dot_config/fish/conf.d/` を参照 |
| Starship のファイルと導入定義が存在 | Fish に初期化なし、`~/.config/starship.toml` もなし。現行プロンプトとしては使用していない |
| `config/zoxide` が存在しない | 配備対象にはあるがリンク先の元ディレクトリがない。初期化・DB は別に存在 |
| Homebrew 初期化が2層 | ユーザーの遅延ラッパーに加え `/etc/fish/config.fish` に対話起動時の shellenv 呼び出しあり |
| Linux の `BROWSER=wslview` | 通常の Linux か WSL かに合わせて判断 |
| `ghf` の `eval cd` | 空白等を含むパスの扱いを移行時に確認 |
| SKK 関数のエラー処理 | cd/fetch/rebase 等の失敗時の挙動は未検証 |

## 設定以外のローカルデータ

以下は存在を確認した保存先。履歴本文や認証情報は記録しない。

| 場所 | 内容 |
| --- | --- |
| `~/.config/fish/fish_variables` | 永続変数、PATH、Tide 設定・内部状態 |
| `~/.local/share/fish/fish_history` | Fish 標準履歴 |
| `~/.local/share/atuin/` | Atuin のデータ |
| `~/Library/Application Support/zoxide/db.zo` | この macOS 環境の zoxide 移動履歴 |
| `~/.config/fish/completions/` | ローカルの Copilot / OpenCode / Tide 補完 |
| `~/.local/share/fish/home-manager/generated_completions` | Home Manager が設定に追加する補完パス |
| `~/.cache/fish/` | 初期化キャッシュ、生成補完等 |

`~/.config/fish/fish_plugins` は存在しない。Fisher のファイルは残るが、現在のプラグイン管理の主軸は Home Manager。
履歴移行・Atuin 同期・zoxide DB の移行方針は未決定。
キャッシュやプロンプトの一時状態は、移行するユーザーデータとは区別する。

## 今後の作業

現在の決定と作業状況。上記の Fish 棚卸しは変更前の記録として保持する。

- [x] リポジトリと配備済み Fish 設定の棚卸し
- [x] 端末固有の永続変数・残存ファイル・データ保存先の確認
- [x] 調査結果と今後の作業のドキュメント化
- [x] 移行先の OS、CPU、Nix 利用可否を確認（Zsh と解釈して継続）
- [x] 残す機能と不要な機能を決定
- [x] 独立ディレクトリと ZDOTDIR による配置、初期化分担を決定
- [x] Zsh 標準で主要なプロンプト表示を再現
- [x] 追加指示により汎用的な alias を移植
- [x] PATH、環境変数、外部ツールの依存・初期化方法を整理して実装
- [x] ghf / yy を移植、個人用関数・Nix 管理関数を除外
- [x] 標準補完、Vi、Neovim 内のキー切り替えを実装・確認
- [x] Atuin・zoxide・既存履歴は移行しないと決定
- [x] 起動、システム PATH、キー設定、対話画面のモード切り替えを検証
- [x] ghf / yy の移動・キャンセル・空白付きパス・失敗を検証
- [x] 導入手順と Fish へ戻る方法を記録
- [ ] 移行先への持ち込み（ユーザー側で実施する段階）

テスト・起動時間の計測はユーザーの指示により今後の作業から外す。
上の検証完了項目は指示前に実施した作業の履歴であり、追加実施の予定ではない。

## 作業記録

| 日付 | 作業 | 結果・検証 | 残件 |
| --- | --- | --- | --- |
| 2026-09-05 | Fish の現状調査 | 設定元・配備済み設定・保存変数・キャッシュを確認。Fish 4.8.0、abbr 41件、未配備関数2件などを把握。設定変更なし | 対話動作と移行先条件は未確認 |
| 2026-09-05 | ドキュメント化 | 本書を追加し、ルート README からリンク。調査結果・未確認事項・作業候補を記録 | Zsh 実装は未着手 |

今後は各作業で「目的、調査根拠、採用した判断、変更ファイル、検証結果、残件」を追記する。
前提が変わった場合は、冒頭の状況と作業一覧も更新する。

### 2026-09-05: 移行条件の確定と独立 Zsh の実装

- 制約: macOS / M4、管理者権限なし、Nix / aqua / mise は使用しない。
- 判断: 外部プラグインの導入を前提にせず、macOS 標準 Zsh 5.9 で実装。
- 起動: `sh config/zsh/start.sh`。`exit` で Fish に戻る。`--clean-path` で既存ツール管理の PATH を外して試せる。
- 変更: `config/zsh/` を追加し、README からリンク。Home Manager には組み込まず、既存環境の切り替えは行わない。
- プロンプト: 2行、OS、現在地、Git、Vi モード、失敗状態、実行時間、言語、時刻を実装。
- 依存: Git・各言語・ghq/fzf/Yazi は任意。Apple の未導入ツール用スタブを不用意に起動しないガードを追加。
- データ: 新しい Zsh 履歴のみ別保存。個人の既存データは参照・コピーしない。
- 相違点: Fish の候補表示・構文ハイライト、Tide の完全なパス短縮・全モード表示、kubectl 等の一部項目は含めない。
  詳細は [Zsh README](../config/zsh/README.md) に記載。
- 検証: 構文、Vi/Neovim 切り替え、履歴分離、失敗コード・時間表示、二重読み込み、ツール不在、
  Git の変更件数・stash・detached HEAD・worktree、Svelte メタデータ、ghf/yy のパス・失敗処理、PTY での対話表示を確認。
- テスト中の問題: Ruby の PTY 出力がバイナリエンコーディングのため比較に失敗。
  テストのエンコーディングと子プロセス終了処理を修正し、対話テストの通過を確認。
- 未確認: 移行先で利用可能なツールと Nerd Font、実際の端末での見た目・性能。

### 2026-09-05: テストを含めない方針への変更

- ユーザー指示: Ruby 等を使ったテストは不要。現段階ではテスト全般を含めない。
- 対応: `config/zsh/test.rb` を削除し、テストの実行手順・追加計画を除去。
- 設定本体、Fish と併用する起動方法、移行先への持ち込み手順は維持。
- 指示前に行った検証の記録は作業履歴として残す。以降は追加のテストを実行しない。

### 2026-09-05: alias の追加

- ユーザーの追加指示により、Fish の汎用的な abbr を Zsh の alias に移植。
- `aliases.zsh` を追加し、`.zshrc` から読み込む。
- Git、一覧表示、エディタ、設定ディレクトリ移動、ghf の短縮を追加。
- eza / nvim がない場合は macOS の ls / vi を使用。
- gh、.NET、Deno、vim-startuptime 関連はコマンドが存在する場合だけ登録。
- `groot` は Git ルート取得に失敗した場合の誤移動を避けるため、関数として追加。
- 個人用パス、SKK、Obsidian、Copilot、LeetCode、Nix / aqua / mise 関連は対象外のまま。
- テストはユーザーの指示に従い未実施。alias 一覧は Zsh README に記載。

### 2026-09-05: symlink 配備スクリプト

- ユーザー指示: Neovim、Zsh 等の設定ファイル・ディレクトリを symlink するスクリプトを用意。
- 追加: [scripts/link-configs.sh](../scripts/link-configs.sh)。macOS 標準 Bash で動作する構成。
- 既定対象: Neovim、Zsh。追加のターミナル・TUI・formatter 設定は名前で選択する。
- Zsh は設定ディレクトリとホームの `.zshenv` / `.zshrc` をリンク。
  `--config-only` でホームの起動ファイルを維持し、Fish と併用できる。
- 既存設定は同じ場所に日時付きで退避。同じ実体ならスキップ。書き込みなしの `--dry-run` を用意。
- パッケージの導入、標準シェルの変更、Fish 設定・個人データの配備は行わない。
- Neovim は既存設定をそのままリンクするため、LSP・プラグイン等の依存削減は別作業。
- スクリプト本体・テスト・dry-run は実行していない。ホームへのリンク作成も未実施。
- 手順・配備先・バックアップの扱いを [docs/symlinks.md](symlinks.md) に記録。
- 追加指示により `link-configs.sh` の説明コメントを日本語に変更。処理・表示メッセージは変更せず、テストは未実施。

### 2026-09-05: バックアップ処理の削除

- ユーザー指示により、symlink 配備時のバックアップ作成・復元処理を削除。
- 同じ実体はスキップ。別の既存設定がある場合は、削除・上書きをせずリンク作成前に停止する。
- 手順書とヘルプを更新。スクリプト・テストは実行していない。

### 2026-09-06: Apple アイコンの削除

- ユーザー指示により、Zsh プロンプト先頭の Apple アイコンを削除。
- 現在地・Git 情報から始まる2行プロンプトに変更。テストは実行していない。

参照した公式仕様:

- [Zsh Startup Files](https://zsh.sourceforge.io/Doc/Release/Files.html): ZDOTDIR と起動ファイルの順序
- [Zsh Prompt Expansion](https://zsh.sourceforge.io/Doc/Release/Prompt-Expansion.html): 色・改行・状態表示、データ中の `%` の扱い
- [Zsh Line Editor](https://zsh.sourceforge.io/Doc/Release/Zsh-Line-Editor.html): keymap と ZLE フック
