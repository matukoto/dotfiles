# Git設定

`~/.config/git` に配備する Git 補助設定。
このディレクトリ自体は少数ファイル構成で、
本体設定の多くは `config/home-manager/modules/git.nix` 側で管理。

## 主要ファイル

- `ignore`: グローバル ignore 設定。

## 構成

- Windows / macOS の不要ファイル除外。
- Vim の swap / undo 由来ファイル除外。
- `.env`、`.venv`、`*.key` など
  ローカル環境ファイルの除外。
- `.claude/*` や `docs/agents/` など
  エージェント系の補助ファイル除外。

## 関連設定

- `config/home-manager/modules/git.nix` が
  alias、delta、署名、commit template を定義。
- commit template は `config/vim/gitmessage` を参照。
