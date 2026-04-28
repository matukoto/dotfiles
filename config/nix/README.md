# Nix設定

`~/.config/nix/nix.conf` に配備する
Nix クライアント設定。

## 主要ファイル

- `nix.conf`: Nix 設定本体。

## 構成

- `experimental-features = nix-command flakes` の有効化。
- flake ベース運用の前提設定。

## 関連設定

- 実際の flake 定義は repo ルートの `flake.nix`。
- `nix build` / `nix run` / `darwin-rebuild` /
  `home-manager` 系コマンドの前提設定。
