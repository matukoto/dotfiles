# Nix / Home Manager / nix-darwin

現在の dotfiles は **macOS を `nix-darwin` + Home Manager、
Linux を Home Manager** で管理しています。  
歴史的な理由で `dot_foo` や `dot_config/` というパス名は残っていますが、
配備そのものは `dot_config/home-manager/` の flake が担当します。

## flake 出力

- `darwinConfigurations.darwin`
  - macOS 用の `nix-darwin` 出力
  - `darwinConfigurations.<mac-hostname>` でも同じ内容を参照できます
- `homeConfigurations.linux`
  - Linux 共通出力
- `homeConfigurations.DesktopFractal`
- `homeConfigurations.ThinkPadE14`
  - Linux のホスト別出力

## 初回適用

### macOS

初回・継続運用ともに、まずは flake から `darwin-rebuild` を直接起動するのが安全です。

```sh
cd ~/.local/share/chezmoi/dot_config/home-manager
sudo -H nix run .#darwin-rebuild -- switch --flake .#darwin
```

### Linux

```sh
cd ~/.local/share/chezmoi/dot_config/home-manager
nix run .#home-manager -- switch --flake .#linux
```

ホスト別設定を使う場合は `.#DesktopFractal` や `.#ThinkPadE14` を指定します。

## 日常運用

- `hms`
  - 現在のホスト向け設定を反映する
- `hmu`
  - `nix flake update` してから現在のホスト向け設定を反映する

Fish では `dot_config/home-manager/modules/fish.nix` が
`nix run .#darwin-rebuild` / `nix run .#home-manager` ベースの wrapper を生成します。

## 検証

### ローカル

```sh
cd dot_config/home-manager

# Linux 出力の評価
nix eval .#homeConfigurations.linux.activationPackage.drvPath

# Linux 出力の build
nix build .#homeConfigurations.linux.activationPackage --no-link

# macOS 出力の build
nix build .#darwinConfigurations.darwin.config.system.build.toplevel --no-link
```

### CI

`.github/workflows/nix-validate.yaml` で Linux / macOS の build を検証します。

## 追加先の目安

- 汎用 CLI: `dot_config/aqua/aqua.yaml`
- 言語ランタイム / npm ベース CLI: `dot_config/mise/config.toml`
- エディタ依存の LSP / formatter / linter: `dot_config/home-manager/home.nix`
- dotfile / config file の配備: `dot_config/home-manager/modules/*.nix`

## 参考

- [home-manager入門/kuu](https://zenn.dev/kuu/articles/20250204_introduce-home-manager)
- [Homebrew管理下のCLIをNixに移してみる/kawarimidoll](https://zenn.dev/kawarimidoll/articles/0a4ec8bab8a8ba)
- [Nixでdotfiles管理できるようになるまでのメモ](https://zenn.dev/airrnot1106/scraps/20e6a33574229f)
- [Nixとhome-managerにdotfiles管理を移行する](https://blog.tomoyukim.net/entry/nix-home-manager/)
- [home-manager/modules/programs at master · nix-community/home-manager](https://github.com/nix-community/home-manager/tree/master/modules/programs)
- [yuyu-hf/dotfiles](https://github.com/yuyu-hf/dotfiles)
