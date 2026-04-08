# dotfiles

Nix / Home Manager / nix-darwin で管理している personal dotfiles。  

## apply

- macOS: `cd dot_config/home-manager && sudo darwin-rebuild switch --flake .#darwin`
- Linux: `cd dot_config/home-manager && home-manager switch --flake .#linux`
- fish を使っている場合は `hms` で現在ホスト向けの反映、`hmu` で `nix flake update` + 反映を実行できます。

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
