# dotfiles

Nix / Home Manager / nix-darwin で管理している personal dotfiles。  

## apply

- `flake.nix` は repo ルートではなく `dot_config/home-manager/` にあります。
- macOS:
  `sudo -H nix --extra-experimental-features "nix-command flakes" run`
  `./dot_config/home-manager#darwin-rebuild -- switch`
  `--flake ./dot_config/home-manager#darwin`
- Linux:
  `nix --extra-experimental-features "nix-command flakes" run`
  `./dot_config/home-manager#home-manager -- switch`
  `--flake ./dot_config/home-manager#linux`
- 初回適用が終わるまでは `hms` / `hmu` ではなく上記の `nix run` を使います。
- `exec fish` だけでは `hms` / `hmu` は新しくならず、先に初回反映が必要です。
- 初回適用後に shell を開き直すと、fish を使っている場合は `hms` で現在ホスト向けの反映、
  `hmu` で `nix flake update` + 反映を実行できます。

## GitHub Copilot CLI

- Copilot CLI 自体は `dot_config/aqua/aqua.yaml` で管理しています。
- Copilot CLI の起動ポリシーは shell wrapper で管理します。
  - `copilot_safe` / `cps`: `git push` と `rm` を deny した安全寄りの起動
  - `copilot_yolo`: `--allow-all` 付きで明示的に全権限起動
- Fish の wrapper 関数は
  `dot_config/home-manager/fish/functions/` 以下で定義します。
- 永続的な trusted directories が必要なときは、
  ローカルの `~/.copilot/config.json` を調整してください。
- 一時的な権限緩和は Copilot CLI の `/add-dir`、`/allow-all`、
  `/reset-allowed-tools` や起動オプションを使います。
