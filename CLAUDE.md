# CLAUDE.md

## プロジェクトについて

このプロジェクトは Nix / Home Manager / nix-darwin で管理している dotfiles リポジトリです。

## 作業について

- 実ファイルの配備は repo ルートの flake が担当します
- macOS は `nix-darwin` + Home Manager、Linux は Home Manager を使います
- 歴史的な理由で `dot_` や `dot_config/` という名前は残っていましたが、
  chezmoi ではなく Nix 側から参照しています
- 設定変更後は対象 OS に応じて
  `sudo -H nix --extra-experimental-features "nix-command flakes" run`
  `.#darwin-rebuild -- switch --flake` または
  `nix --extra-experimental-features "nix-command flakes" run`
  `.#home-manager -- switch --flake` で反映します
- fish の `hms` / `hmu` は Home Manager の反映ラッパー、
  `hmd` は macOS の nix-darwin 反映ラッパーです

## ファイル構造について

- `config/`: 実際に配備する設定ファイル群と Home Manager モジュール
- `dot_*`: Home Manager が読み込むホームディレクトリ向けの元ファイル
- `run/`: 手動 bootstrap や補助スクリプト
- `others/`: その他のスクリプトやメモ

## 重要な注意点

- `~/.bashrc` や `~/.config/*` を直接編集せず、
  必ずこのリポジトリ側の元ファイルを修正してください
- 反映コマンドは macOS では
  `sudo -H nix --extra-experimental-features "nix-command flakes" run`
  `.#darwin-rebuild -- switch --flake .#darwin`、
  Linux では
  `nix --extra-experimental-features "nix-command flakes" run`
  `.#home-manager -- switch --flake .#linux` が基本です
- Fish の `hms` / `hmu` は Home Manager の反映ラッパー、
  `hmd` は macOS の nix-darwin 反映ラッパーです

## テストについて

- dotfilesの性質上、通常のユニットテストは適用されません
- repo ルート flake build と設定ファイルの文法チェックが主になります
