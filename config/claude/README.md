# Claude設定

`~/.config/claude` に配備する Claude 系設定。
ツール権限、通知、作業ルールの置き場。

## 主要ファイル

- `settings.json`: 許可 / 拒否コマンド、
  通知チャネル、環境変数などの実行設定。
- `CLAUDE.md`: Claude に読ませる作業ルール。

## 構成

- `settings.json` では
  `git`, `gh`, `mise`, `docker`, `rg`, `fd` などの許可範囲を定義。
- 危険操作として `git push`, `sudo`, `rm -rf`,
  `/etc` や `~/.ssh` 配下の編集などを拒否。
- `preferredNotifChannel = terminal_bell`、
  `autoUpdates = false` の設定。
- `CLAUDE.md` では
  日本語応答、README 優先読解、TDD 手順、
  コメント禁止、行末空白禁止などのルールを定義。

## 補足

- ルールファイルと実行権限設定を同居させた構成。
- `home/claude` 側のホームディレクトリ配備ファイルとは別系統。
