# Nix を使わない設定の symlink 配備

スクリプト: [scripts/link-configs.sh](../scripts/link-configs.sh)。
macOS 標準の Bash で実行し、sudo・Nix・aqua・mise は不要。
リポジトリの置き場所はスクリプト自身の位置から取得する。

## 使い方

dotfiles のルートから実行する。

```sh
# 変更予定の表示だけ（書き込みなし）
bash scripts/link-configs.sh --dry-run

# Neovim と Zsh の設定をリンク
bash scripts/link-configs.sh

# 対象を指定してリンク
bash scripts/link-configs.sh nvim zsh ghostty wezterm yazi typos

# ホームの Zsh 起動ファイルを変更せず、設定ディレクトリだけリンク
bash scripts/link-configs.sh --config-only nvim zsh

# 対応している設定一覧
bash scripts/link-configs.sh --list
```

スクリプトを用意した段階ではリンクは作成されない。実際の配備は上のコマンドを実行したときに行う。
テストはユーザーの方針により実施していない。

## 配備先

`$XDG_CONFIG_HOME` が設定されていればその場所を使い、未設定なら `~/.config` を使う。

| 指定名 | リンク元 | 配備先 |
| --- | --- | --- |
| `nvim` | `config/nvim` | `~/.config/nvim` |
| `zsh` | `config/zsh` | `~/.config/zsh` |
| `zsh` | `config/zsh/.zshenv` | `~/.zshenv`（`--config-only` で省略） |
| `zsh` | `config/zsh/.zshrc` | `~/.zshrc`（`--config-only` で省略） |
| `ghostty` / `wezterm` | `config/指定名` | `~/.config/指定名` |
| `yazi` / `gitui` | `config/指定名` | `~/.config/指定名` |
| `jdtls` / `sqls` | `config/指定名` | `~/.config/指定名` |
| `stylua` / `yamlfmt` | `config/指定名` | `~/.config/指定名` |
| `typos` | `config/typos.toml` | `~/.config/typos.toml` |

引数なしの既定対象は nvim と zsh のみ。他の設定は明示的に指定する。
Fish、個人の Git 設定、SKK 辞書、履歴、Copilot、Nix / aqua / mise / Atuin / zoxide は配備しない。
標準シェルを変更する `chsh` も実行しない。

## このパソコンで Fish と併用する

ホームの `.zshenv` / `.zshrc` を維持したい場合は `--config-only` を指定する。
Zsh は次のように子シェルとして起動でき、`exit` で元の Fish に戻る。

```sh
sh "$HOME/.config/zsh/start.sh"
```

独自の `XDG_CONFIG_HOME` を使っている場合はその配下の `zsh/start.sh` を指定する。
通常配備で `.zshenv` / `.zshrc` もリンクした場合は `/bin/zsh` から読み込まれる。
ただし既に `ZDOTDIR` を別の場所に設定している場合はその設定が優先されるため、専用の `start.sh` を使う。
通常の `/bin/zsh` はシステムの起動設定も読む点が、`start.sh` とは異なる。

## 既存設定の扱い

- 同じ実体へのリンクがあればスキップする。Nix のリンクを経由して同じ実体に到達する場合も対象。
- バックアップは作成しない。
- 異なる既存ファイル・ディレクトリ・symlink がある場合は、その場所を表示してリンク作成前に停止する。
  既存設定の削除・上書きは行わない。
- 実行途中で権限エラー等が発生した場合、それまでに作成したリンクは残る。
- 設定ディレクトリ全体をリンクし、既存ファイルへのマージは行わない。

元に戻す場合は、配備先がこのリポジトリへの symlink であることを確認し、
作成したリンクだけを外す。

リンク元は絶対パスなので、このリポジトリを移動・削除するとリンクが切れる。
また、配備先の設定を編集するとリポジトリの元ファイルも変更される。

## Neovim の依存について

このスクリプトは既存の Neovim 設定をそのままリンクする。
制限付き環境向けに Neovim の機能・依存を縮小する変更は含まない。

- Neovim 本体、LSP、formatter、Deno 等は別途利用可能な環境が必要。
- 現在の `lua/config/lazy.lua` は、lazy.nvim が未導入なら初回起動時に GitHub から取得する。
- SKK・AI 関連を含む既存のプラグイン定義もそのまま読み込む。個人の辞書・認証情報をコピーする処理はない。

外部依存の詳細は [Neovim README](../config/nvim/README.md)、
Zsh の利用方法は [Zsh README](../config/zsh/README.md) を参照。
