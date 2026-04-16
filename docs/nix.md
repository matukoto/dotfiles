# Nix / Home Manager / nix-darwin

現在の dotfiles は **macOS を `nix-darwin` + Home Manager、
Linux を Home Manager** で管理しています。  
歴史的な理由で `dot_foo` や `dot_config/` というパス名は残っていましたが、
配備そのものは repo ルートの flake が担当します。

## 実行場所

`flake.nix` は `~/.local/share/chezmoi/`（repo ルート）にあります。

- `cd ~/.local/share/chezmoi` してから `.#darwin` / `.#linux` を使う

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

repo ルートから実行する場合:

```sh
cd ~/.local/share/chezmoi
sudo -H nix --extra-experimental-features "nix-command flakes" run \
  .#darwin-rebuild -- switch --flake .#darwin
```

初回導入で `/etc/bashrc` / `/etc/zprofile` / `/etc/zshenv` / `/etc/zshrc`
のような macOS 標準の shell init file が残っている場合は、
`darwin-system.nix` の preActivation で
`.before-nix-darwin` 付きに自動退避します。
それ以外の `/etc` 衝突が出た場合だけ、内容を確認して手動退避してください。

初回適用が終わるまでは、`hms` / `hmu` は使わず上記の `nix run` を直接使ってください。
初回適用前の shell には古い関数が残っていることがあり、
`homeConfigurations."darwin".activationPackage` を探して失敗する場合があります。
`exec fish` だけでは更新されず、先に `darwin-rebuild switch` の成功が必要です。
反映後に shell を開き直すか `exec fish` すると、新しい `hms` / `hmu` が使えます。

### Linux

repo ルートから実行する場合:

```sh
cd ~/.local/share/chezmoi
nix --extra-experimental-features "nix-command flakes" run \
  .#home-manager -- switch -b hm-backup --flake .#linux
```

ホスト別設定を使う場合は `.#DesktopFractal` や `.#ThinkPadE14` を指定します。

初回適用だけ `-b hm-backup` を付けます。以降の `hms` / `hmu` では
バックアップ指定は不要です。

## 日常運用

- `hms`
  - 現在のホスト向け設定を反映する
- `hmu`
  - `nix flake update` してから現在のホスト向け設定を反映する

Fish では `config/home-manager/modules/fish.nix` が
`nix run .#darwin-rebuild` / `nix run .#home-manager` ベースの wrapper を生成します。

## 検証

### ローカル

```sh
cd ~/.local/share/chezmoi

# Linux 出力の評価
nix eval .#homeConfigurations.linux.activationPackage.drvPath

# Linux 出力の build
nix build \
  .#homeConfigurations.linux.activationPackage \
  --no-link

# macOS 出力の build
nix build \
  .#darwinConfigurations.darwin.config.system.build.\
  toplevel \
  --no-link
```

### CI

`.github/workflows/nix-validate.yaml` で Linux / macOS の build を検証します。

## 追加先の目安

- 汎用 CLI: `config/aqua/aqua.yaml`
- 言語ランタイム / npm ベース CLI: `config/mise/config.toml`
- エディタ依存の LSP / formatter / linter: `config/home-manager/home.nix`
- dotfile / config file の配備: `config/home-manager/modules/*.nix`
- macOS の Homebrew 管理: `config/home-manager/darwin-homebrew.nix`

## 参考

- [home-manager入門/kuu](https://zenn.dev/kuu/articles/20250204_introduce-home-manager)
- [Homebrew管理下のCLIをNixに移してみる/kawarimidoll](https://zenn.dev/kawarimidoll/articles/0a4ec8bab8a8ba)
- [Nixでdotfiles管理できるようになるまでのメモ](https://zenn.dev/airrnot1106/scraps/20e6a33574229f)
- [Nixとhome-managerにdotfiles管理を移行する](https://blog.tomoyukim.net/entry/nix-home-manager/)
- [home-manager/modules/programs at master · nix-community/home-manager](https://github.com/nix-community/home-manager/tree/master/modules/programs)
- [yuyu-hf/dotfiles](https://github.com/yuyu-hf/dotfiles)
