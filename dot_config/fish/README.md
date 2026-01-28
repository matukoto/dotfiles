# Fish Shell設定

このディレクトリには[Fish Shell](https://fishshell.com/)の設定ファイルが含まれています。

## ファイル構成

- `config.fish.tmpl`: Fish Shellのメイン設定ファイル（chezmoiテンプレート）
- `functions/`: カスタム関数を格納するディレクトリ

## 主な設定内容

### PATHの設定

以下のディレクトリをPATHに追加しています：

- `$HOME/bin`
- `$HOME/.local/bin`
- `$HOME/go/bin`
- `$HOME/.cargo/bin`
- `$HOME/.deno/bin`
- `$HOME/.local/share/nvim/mason/bin`
- `$HOME/.local/share/aquaproj-aqua/bin`

### 環境変数

#### XDG Base Directory

- `XDG_CONFIG_HOME`: `$HOME/.config`
- `XDG_CACHE_HOME`: `$HOME/.cache`
- `XDG_DATA_HOME`: `$HOME/.local/share`
- `XDG_STATE_HOME`: `$HOME/.local/state`

#### エディタ/ブラウザ

- `EDITOR`: `nvim`
- `BROWSER`: `wslview`
- `SYSTEMD_EDITOR`: `$EDITOR`

#### その他

- `TZ`: `Asia/Tokyo`
- `GPG_TTY`: 現在のtty

### 略語 (Abbreviations)

よく使うコマンドの略語を定義しています：

- `f` → `ghf`
- `ai` → `aqua i -a`
- `ag` → `aqua g`
- `mi` → `mise i`
- `skkadd` → `update_skk_dict`
- `skkpull` → `pull_skk_dict`
- `skk` → `cd ~/.skk`
- `fsi` → `dotnet fsi`

### プラットフォーム固有の設定

chezmoiテンプレート機能を使用して、macOSとLinuxで異なる設定を適用しています。

## 参考資料

- [Fish Shell 公式サイト](https://fishshell.com/)
- [Fish Shell ドキュメント](https://fishshell.com/docs/current/)
