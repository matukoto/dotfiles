# run/

`chezmoi apply`の実行時に一度だけ実行されるスクリプトです。主にツールのインストールに使用されます。

-   `run_init.sh`: 初期設定用のスクリプトです。
-   `run_nvim_build.sh`: Neovimをビルド・インストールするためのスクリプトです。
-   `run_once_sudo.sh`: `sudo`が必要な処理をまとめたスクリプトです。
-   `run_once_tools.sh`: 各種ツールをインストールするためのスクリプトです。
-   `run_vim_build.sh`: Vimをビルド・インストールするためのスクリプトです。
-   `run_windows.sh`: Windows環境でのみ実行されるスクリプトです。
