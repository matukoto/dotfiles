# 管理者権限なしで使う Zsh

macOS 標準の `/bin/zsh` 用。Nix、Home Manager、aqua、mise、Homebrew、
Atuin、zoxide、外部プロンプト・プラグインのインストールは不要。
既存の Fish とホームの起動ファイルを変更せず、子シェルとして試せる。

## このパソコンで試す

dotfiles のルートで、Fish から実行する。

```sh
sh config/zsh/start.sh
```

終了は `exit` または空の入力行で `Ctrl-D`。元の Fish に戻る。
起動中の Zsh で移動しても、親の Fish のディレクトリは変わらない。

既存の Nix / mise / aqua の PATH を引き継がずに試す場合:

```sh
sh config/zsh/start.sh --clean-path
```

このモードは PATH を macOS のシステムディレクトリに設定する。
その後 `.zshenv` が、存在すれば `~/bin` と `~/.local/bin` を追加する。
PATH 以外の親シェルの環境変数は引き継ぐため、移行先そのものの完全再現ではない。

ランチャーは `ZDOTDIR` でこのディレクトリを指定し、`-d` で後続のシステム起動ファイルを省略する。
`/etc/zshenv` は Zsh 自体が必ず読む。今回の Nix 管理の `/etc/zshrc` 等への依存を避ける目的で、
既定ではログインシェルとして起動しない。

## 移行先への持ち込み

dotfiles リポジトリを配置して使う場合は、`bash scripts/link-configs.sh zsh` で
設定ディレクトリとホームの起動ファイルを symlink 配備できる。
ホームの起動ファイルを維持する場合は `--config-only` を指定する。
詳細は [symlink 配備手順](../../docs/symlinks.md) を参照。
以下はディレクトリをコピーして使う場合の手順。

1. この `config/zsh` ディレクトリ全体を移行先の任意の場所にコピーする。隠しファイルの `.zshenv` と `.zshrc` も含める。
2. たとえば `~/.config/zsh-work` に配置した場合、ターミナルから次のように起動する。

   ```sh
   sh "$HOME/.config/zsh-work/start.sh"
   ```

3. 常用する場合は、ターミナルの起動コマンドにも同じコマンドを指定できる。`chsh`、sudo、ホームの `.zshrc` 変更は不要。

配置先に既存設定がある場合は別のディレクトリを選ぶ。
持ち込むのはこのディレクトリだけでよく、個人の Git 設定・履歴・SKK 辞書等をコピーする必要はない。
ツールは勤務先で許可・用意されたものを使用し、この設定からインストールは実行しない。

## 含まれる機能

| 機能 | 内容 |
| --- | --- |
| 基本環境 | XDG、東京のタイムゾーン、`BROWSER=open`、TTY がある場合の `GPG_TTY` |
| エディタ | PATH 上に nvim があれば nvim、なければ vi |
| 操作 | Vi キー。Neovim ターミナル内は Emacs キー |
| 履歴検索 | Zsh 標準の `Ctrl-R`。上・下キーで履歴移動 |
| 補完 | Zsh 標準の compinit、メニュー選択、大文字小文字の補完設定 |
| プロンプト | 空行、現在地・Git、改行、モードと `❯`。背景なし |
| 右プロンプト | 失敗コード、3秒以上の実行時間、SSH/root 情報、ジョブ、言語、時刻 |
| Git | ブランチ、detached HEAD、stash、stage、変更、未追跡、競合、ahead/behind、操作状態 |
| 言語 | プロジェクトを検出し、使用可能な言語コマンドのバージョンを表示。Svelte は package.json から取得 |
| クラウド | 設定済みの `AWS_PROFILE` / `CLOUDSDK_CORE_PROJECT` を表示 |
| `ghf` | ghq + fzf がある場合にリポジトリを選択して移動 |
| `yy` | Yazi がある場合に終了時のディレクトリへ移動 |

Git がなくても起動可能。Apple の Git / Python スタブは developer tools がない場合に呼び出さず、
Java のシステムスタブも JDK を確認してから呼び出す。
`ghf` / `yy` は必要なツールがない場合に説明を表示し、終了コード127を返す。

言語検出は現在地から親ディレクトリまで確認する。
Bun、Node、Python、Rust、Java、C#、F#、PHP、Pulumi、Ruby、Go、Terraform、Crystal、Elixir、Zig、Lua に対応。
ランタイムの切り替え・プロジェクト設定の source は行わない。
バージョン取得は同期実行なので、インストール済みのランタイムや shim により待ち時間が発生する場合がある。

## alias

Fish の汎用的な短縮入力を Zsh の alias として追加。
入力中の展開は行わず、実行時に置き換える。

| 入力 | 内容 |
| --- | --- |
| `s` / `gd` / `gl` | `git status` / `git diff` / `git log` |
| `ga` / `gc` / `gp` / `gpl` | `git add` / `git commit` / `git push` / `git pull` |
| `gpu` | `git push --set-upstream origin HEAD` |
| `gs` / `gsc` / `gcp` | `git switch` / `git switch -c` / `git cherry-pick` |
| `groot` | Git ルートへ移動。失敗時に移動しない関数として実装 |
| `f` | `ghf`（ghq + fzf が必要） |
| `conf` | `$XDG_CONFIG_HOME` へ移動 |
| `ls` | eza があれば eza、なければ通常の ls |
| `ll` / `la` | 詳細一覧 / 隠しファイルを含む一覧。eza がなければ ls を使用 |
| `l` | 画面を消去して一覧表示 |
| `v` / `v.` / `vr` | nvim / カレントディレクトリ / README を開く。nvim がなければ vi |
| `gas` | `gh auth switch`。gh がある場合のみ |
| `fsi` | `dotnet fsi`。.NET がある場合のみ |
| `browser-html` | Deno 経由で browser-sync 起動。Deno がある場合のみ |
| `startuptime` | Neovim 起動時間測定。vim-startuptime と nvim がある場合のみ |

alias の追加自体はコマンドを実行しない。
`browser-html` は利用時に npm パッケージの取得が発生し得る、従来のコマンド定義。
ツールの利用可否は起動時に判定するため、追加インストール後は Zsh を開き直す。

## Fish との差分

- 短縮入力41件のうち汎用的なものを alias に移植。個人用・ツール管理用のものは除外。
- Atuin、zoxide、個人用パス・関数、Copilot、Nix 管理コマンド、ツール管理の初期化は含めない。
- Fish の自動候補表示と入力中の構文ハイライトは含めない。履歴検索と補完は Zsh 標準を使う。
- Tide 自体は使わず、主要な配置・色・情報を Zsh で再現する。パスの短縮は画面幅に基づく簡略版。
- Vi の insert / normal 表示を再現。Tide と同じ replace / visual 表示の完全な対応は未実施。
- kubectl の context 自動取得、direnv、Nix shell、distrobox / toolbox の表示は含めない。
- クラウド表示は環境変数に限定し、CLI の設定ファイルからの自動取得は行わない。
- アイコンを同じように表示するには Nerd Font が必要。現在の端末は HackGen Console NF。
  移行先でフォントを利用できるかは未確認。フォントがなくてもシェル機能は動作する。

## データと端末固有設定

新しい履歴は `${XDG_STATE_HOME:-~/.local/state}/zsh/history` に保存する。
補完キャッシュも同じディレクトリ。Fish / Atuin の既存履歴は読み込まない。
先頭に空白を置いたコマンドは履歴保存から除外する。

保存先を変更する場合は `DOTFILES_ZSH_DATA_DIR` を指定する。
設定ディレクトリの `local.zsh` があれば、対話起動時だけ読み込む。
`local.example.zsh` を参考に、許可されたツールの PATH 等を記載できる。
`local.zsh` は Git 管理対象外。

言語バージョン取得を無効にする設定:

```zsh
DOTFILES_ZSH_LANGUAGE_PROMPT=0
```

## ファイル構成

| ファイル | 役割 |
| --- | --- |
| `.zshenv` | 対話・非対話共通の環境変数と PATH |
| `.zshrc` | 履歴、補完、キー設定、モジュール読み込み |
| `prompt.zsh` | Git・言語情報、プロンプト、ZLE のモード表示 |
| `functions.zsh` | groot / ghf / yy |
| `aliases.zsh` | Git・一覧表示・エディタ等の alias |
| `start.sh` | Fish と併用する起動入口 |
| `local.example.zsh` | 端末固有設定の例 |

ユーザーの方針により、テストコード・テスト実行手順は含めない。
Ruby は使用しない。実際の使い心地は、上記の起動方法で必要なときに試せる。

調査と作業記録: [Fish → Zsh 移行記録](../../docs/fish-to-zsh.md)。
起動方式・プロンプト・ZLE の仕様は Zsh 公式の
[Startup Files](https://zsh.sourceforge.io/Doc/Release/Files.html)、
[Prompt Expansion](https://zsh.sourceforge.io/Doc/Release/Prompt-Expansion.html)、
[Zsh Line Editor](https://zsh.sourceforge.io/Doc/Release/Zsh-Line-Editor.html) を参照。
