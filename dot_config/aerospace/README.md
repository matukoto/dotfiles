# AeroSpace設定

このディレクトリには[AeroSpace](https://nikitabobko.github.io/AeroSpace/)（macOS向けタイル型ウィンドウマネージャー）の設定ファイルが含まれています。

## ファイル構成

- `aerospace.toml`: AeroSpaceのメイン設定ファイル

## 主な設定内容

### ワークスペース

- workspace 1: メイン表示用
- workspace 0: 待避用（一時的にアプリを退避させる場所）

workspace 0のウィンドウにフォーカスが当たった際、自動的にworkspace 1に移動する仕組みを導入しています。

### レイアウト

- デフォルトレイアウト: `tiles`（タイル型）
- コンテナの正規化を有効化
  - フラットコンテナ: 有効
  - ネストコンテナの反対方向: 有効

### ギャップとパディング

- アコーディオンパディング: 30px
- 内側ギャップ: 0px
- 外側ギャップ: 左5px、下5px、右5px、上0px

### 動作設定

- ログイン時に自動起動
- フォーカスが変更されたワークスペースでは、マウスカーソルを自動的にモニターの中央に移動
- カスタムフォーカスハンドラー（`~/.local/bin/aerospace-focus-handler`）を使用

## 主なキーバインド

設定ファイル内で定義されているキーバインドは以下の通りです（詳細は`aerospace.toml`を参照）。

## 参考資料

- [AeroSpace 公式ドキュメント](https://nikitabobko.github.io/AeroSpace/)
- [AeroSpace Commands](https://nikitabobko.github.io/AeroSpace/commands)
- [AeroSpace Normalization Guide](https://nikitabobko.github.io/AeroSpace/guide#normalization)
