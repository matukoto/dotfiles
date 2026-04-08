# CLAUDE.md

## プロジェクトについて

このプロジェクトは Nix / Home Manager / nix-darwin で管理している dotfiles リポジトリです。

## 作業について

- 実ファイルの配備は `dot_config/home-manager/` の flake が担当します
- macOS は `nix-darwin` + Home Manager、Linux は Home Manager を使います
- 歴史的な理由で `dot_` や `dot_config/` という名前は残っていますが、
  chezmoi ではなく Nix 側から参照しています
- 設定変更後は対象 OS に応じて
  `nix run .#darwin-rebuild -- switch --flake` または
  `nix run .#home-manager -- switch --flake` で反映します

## ファイル構造について

- `dot_config/`: 実際に配備する設定ファイル群と Home Manager の flake
- `dot_*`: Home Manager が読み込むホームディレクトリ向けの元ファイル
- `run/`: 手動 bootstrap や補助スクリプト
- `others/`: その他のスクリプトやメモ

## 重要な注意点

- `~/.bashrc` や `~/.config/*` を直接編集せず、
  必ずこのリポジトリ側の元ファイルを修正してください
- 反映コマンドは macOS では
  `sudo nix run .#darwin-rebuild -- switch --flake .#darwin`、
  Linux では `nix run .#home-manager -- switch --flake .#linux` が基本です
- Fish の `hms` / `hmu` は現在ホスト向けの反映ラッパーです

## テストについて

- dotfilesの性質上、通常のユニットテストは適用されません
- `dot_config/home-manager` の flake build と設定ファイルの文法チェックが主になります
