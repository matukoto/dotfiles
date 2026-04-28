# Atuin設定

`~/.config/atuin` に配備する Atuin 設定。
シェル履歴検索の挙動と入力体験の定義。

## 主要ファイル

- `config.toml`: Atuin 本体設定。
- `atuin-receipt.json`: インストール状態のメタデータ。

## 構成

- `enter_accept = true` による即時実行寄りの挙動。
- それ以外は公式デフォルトを多く残した最小構成。
- shell への実際の組み込みは
  `config/home-manager/fish/config.fish` 側の
  `atuin init` 呼び出しで実施。

## 関連設定

- Fish 側ではキャッシュ生成時に Atuin 初期化コードを組み込み。
- 履歴 UI 自体の見た目より、shell 統合を重視した構成。
