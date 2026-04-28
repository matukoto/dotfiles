# Home Manager / nix-darwin設定

このディレクトリは dotfiles 全体の統合レイヤー。
パッケージ導入、`~/.config` への配備、
OS 差分、shell 生成処理をまとめる場所。

## 主要ファイル

- `home.nix`: 共通パッケージ定義。
  CLI、LSP、formatter、フォントなどの基本セット。
- `darwin.nix`: macOS 用 Home Manager 設定。
  `colima`、`leetcode-cli` などの追加。
- `linux.nix`: Linux 用 Home Manager 設定。
  `csharp-ls` などの追加。
- `darwin-system.nix`: nix-darwin 側の
  macOS defaults、shell、電源設定。
- `darwin-homebrew.nix`: nix-homebrew と Homebrew の
  tap / brew / cask 管理。
- `modules/`: bash、fish、git、gnupg、files 配備の分割 module。
- `fish/`: Fish 設定の元ファイル群。
- `pkgs/aqua.nix`: aqua の custom package 定義。

## module ごとの役割

- `modules/files.nix`:
  `config/` 以下の各ディレクトリを
  `~/.config` へ out-of-store symlink 配備。
- `modules/fish.nix`:
  `config.fish` テンプレートを読み込み、
  OS 差分と generation hash を差し込んだうえで
  `hms` / `hmu` / `hmd` を生成。
- `modules/git.nix`:
  `delta`、署名、alias、credential helper、
  commit template などの Git 運用設定。
- `modules/bash.nix`:
  `.bashrc`、`.bash_aliases`、`.profile` の配備。
- `modules/gnupg.nix`:
  `gpg-agent.conf` と `gpg.conf` の生成。

## Fish 関連

- `fish/config.fish` が shell 初期化の元テンプレート。
- `conf.d/` と `functions/` に
  abbr、補助関数、Tide 用表示関数を配置。
- `aqua`, `mise`, `atuin` の初期化は
  Fish のキャッシュ生成処理から実施。

## 補足

- エディタ設定そのものは `config/nvim/` や `config/vim/` 側。
- 実行バイナリの導入と配備の結線はこのディレクトリ側の責務。
