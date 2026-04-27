# Ghostty設定

`~/.config/ghostty/config` に配備する
Ghostty ターミナル設定。

## 主要ファイル

- `config`: Ghostty 本体設定。

## 構成

- `HackGen Console NF` とフォントサイズ 16 の指定。
- `copy-on-select = true` と
  `clipboard-read = ask` / `clipboard-write = allow`
  によるクリップボード制御。
- 透過 (`background-opacity = 0.6`)、
  ウィンドウサイズ、装飾表示の設定。
- 最後のタブを閉じたらアプリを終了する運用。

## 補足

- プラグイン構成はなし。
- macOS 側のインストールは
  `config/home-manager/darwin-homebrew.nix` で管理。
