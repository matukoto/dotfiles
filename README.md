# Dotfiles

[chezmoi](https://github.com/twpayne/chezmoi)で管理している。

## 概要

このリポジトリには、さまざまなツールやシェルのための私の個人的な設定ファイルが含まれています。macOS、Linux、Windows (WSL経由)など、複数のプラットフォームで使用できるように設計されています。

## インストール

これらのdotfilesをインストールするには、次のコマンドを使用します:

```bash
chezmoi init matukoto
```

これにより、chezmoiが初期化され、dotfilesがホームディレクトリに適用されます。

## ディレクトリ構成

リポジトリは次のように構成されています。詳細は各ディレクトリの`README.md`を参照してください。

- **[run/](./run/)**: `chezmoi apply`の実行時に一度だけ実行されるスクリプトです。
- **[dot_config/](./dot_config/)**: `~/.config`以下に配置される設定ファイル群です。
- **[dot_local/bin/](./dot_local/bin/)**: `~/.local/bin`に配置される自作スクリプト群です。
- **[dpp/](./dpp/)**: Neovimのプラグインマネージャ`dpp.vim`関連の設定です。
- **[windows/](./windows/)**: Windows固有の設定ファイルです。
- **[wslconf/](./wslconf/)**: WSL (Windows Subsystem for Linux) の設定ファイルです。
