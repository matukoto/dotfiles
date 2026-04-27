# dotfiles

Nix / Home Manager / nix-darwin で管理する personal dotfiles。  
repo ルートの `flake.nix` が
`darwinConfigurations` / `homeConfigurations` を定義し、
`config/` 以下の元ファイルを各環境へ配備。

## 運用方針

- `~/.bashrc` や `~/.config/*` を直接編集せず、このリポジトリ内の元ファイルを修正。
- macOS は `nix-darwin` + Home Manager、Linux は Home Manager を利用。
- `config/home-manager/modules/files.nix` が `config/` 以下の各ディレクトリを `~/.config` 配下へリンク。
- LSP / formatter / CLI の多くは Home Manager と Nix で導入。エディタ側ではそのバイナリを利用。

## 適用方法

- `flake.nix` は repo ルート。
- macOS:
  `sudo -H nix --extra-experimental-features "nix-command flakes" run`
  `.#darwin-rebuild -- switch --flake .#darwin`
- Linux:
  `nix --extra-experimental-features "nix-command flakes" run`
  `.#home-manager -- switch -b hm-backup --flake .#linux`
- 初回適用だけ `-b hm-backup` を付与。以降の `hms` / `hmu` ではバックアップ指定不要。
- `exec fish` だけでは `hms` / `hmu` / `hmd` は新しくならないため、先に初回反映が必要。
- 初回適用後に shell を開き直すと、fish を使っている場合は
  `hms` で Home Manager を反映、`hmd` で nix-darwin を反映。
  `hmu` は `nix flake update` + Home Manager 反映。

## 構成の見取り図

| パス | 役割 |
| --- | --- |
| [`flake.nix`](flake.nix) | macOS / Linux 向け flake 出力の定義。 |
| [`config/home-manager/`](config/home-manager/) | パッケージ、OS 差分、`~/.config` への配備ルール。 |
| [`config/nvim/`](config/nvim/) | Neovim 本体設定と `lazy.nvim` ベースのプラグイン設定。 |
| [`config/vim/`](config/vim/) | Vim 本体設定と `vim-jetpack` ベースのプラグイン設定。 |
| [`config/aqua/`](config/aqua/) | CLI ツールの配布元・バージョン・チェックサム管理。 |
| [`config/mise/`](config/mise/) | 言語ランタイムや npm 系 CLI のバージョン管理。 |
| [`config/git/`](config/git/) | Git 設定と補助ファイル。 |
| [`config/ghostty/`](config/ghostty/), [`config/wezterm/`](config/wezterm/) | ターミナル設定。 |
| [`config/yazi/`](config/yazi/), [`config/gitui/`](config/gitui/) | TUI ツール設定。 |
| [`config/aerospace/`](config/aerospace/), [`config/borders/`](config/borders/), [`config/sketchybar/`](config/sketchybar/) | macOS 固有のデスクトップ設定。 |
| [`home/`](home/) | `.claude` や `.copilot` など、XDG 外へ置くファイルの元データ。 |

## ツール別 README

- [`config/aqua/README.md`](config/aqua/README.md)
- [`config/nvim/README.md`](config/nvim/README.md)
- [`config/vim/README.md`](config/vim/README.md)

各ツールディレクトリの README には、
その設定が管理している範囲、主要ファイル、
使っているプラグインや補助ツールの概要を順次追記。

## GitHub Copilot CLI

- Copilot CLI 自体は `config/aqua/aqua.yaml` で管理。
- Copilot CLI の起動ポリシーは shell wrapper で管理。
  - `copilot_safe` / `cps`: `git push` と `rm` を deny した安全寄りの起動
  - `copilot_yolo`: `--allow-all` 付きで明示的に全権限起動
- Fish の wrapper 関数は `config/home-manager/fish/functions/` 以下で定義。
- 永続的な trusted directories が必要なときは、ローカルの `~/.copilot/config.json` を調整。
- 一時的な権限緩和は Copilot CLI の `/add-dir`、`/allow-all`、
  `/reset-allowed-tools` や起動オプションを利用。
