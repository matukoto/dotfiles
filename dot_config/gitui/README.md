# GitUI設定

このディレクトリには[GitUI](https://github.com/extrawurst/gitui)（Rust製のターミナルベースGit UI）の設定ファイルが含まれています。

## ファイル構成

- `key_bindings.ron`: キーバインド設定ファイル（RON形式）

## 主なキーバインド

### カーソル移動

- `h`: 左に移動
- `l`: 右に移動
- `k`: 上に移動
- `j`: 下に移動
- `g`: ホーム（先頭）
- `G`: エンド（末尾）

### ページ移動

- `Ctrl+b`: Page Up
- `Ctrl+f`: Page Down
- `Ctrl+p`: Popup Up
- `Ctrl+n`: Popup Down

### Git操作

- `s`: 変更をステージング
- `u`: 変更をリセット
- `U`: アイテムをリセット
- `w`: スタッシュを保存
- `m`: インデックスをトグル
- `l`: スタッシュを開く
- `I`: ファイルを編集
- `M`: マージを中止

### その他

- `F1`: ヘルプを開く
- `K`: 上にシフト
- `J`: 下にシフト

## 参考資料

- [GitUI GitHub リポジトリ](https://github.com/extrawurst/gitui)
- [GitUI キー設定ドキュメント](https://github.com/extrawurst/gitui/blob/master/KEY_CONFIG.md)
