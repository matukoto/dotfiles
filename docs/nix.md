# Nix home-manager の導入

home-manager: 環境管理ツール。
とりあえずパッケージ管理に利用するので mason でインストールしている lsp や formatter 関連を home-manager で管理することを目指す。

## MacOS

### install

```fish
# 公式は sh <(curl --proto '=https' --tlsv1.2 -L https://nixos.org/nix/install) だが、fish で動かないため、パイプで実行する方法を採用
curl --proto '=https' --tlsv1.2 -sSf -L https://nixos.org/nix/install | sh
```

途中、`.appから、コンピュータの管理を求められています。管理にはパスワード、ネットワーク、およびシステム設定の変更が含まれます。`とダイアログがでるが許可する。

### flake を有効にする

experimental なのに実質標準らしい。
はよ標準にしてくれ。
何か理由があるのかな？

```~/.cofnig/nix/nix.conf
experimental-features = nix-command flakes
```

### home-manager の有効化

```sh
 nix run home-manager/master -- init --switch
```

シェル再起動で home-manager が利用できるようになる。

### パッケージ導入

home.nix の packages 配下を編集することでパッケージの管理ができる。
packages の編集後 `home-manager switch` を実行することでパッケージの管理が反映される。

#### 手始めに Nix の lsp と formatter を home-manager で管理する

```home.nix
  home.packages = with pkgs; [
    nixfmt
    nixd
  ];
```

### パッケージ最新化

```sh
# flake.lock を更新
nix flake update
home-manager switch
```

### クロスプラットフォーム化

macOS と Linux(WSL2 Ubuntu) で同じ home.nix を利用できるようにする。
結局コマンドをわけないとダメだった。

```sh
home-manager switch --flake .#matukoto@darwin
home-manager switch --flake .#matukoto@linux
```

#### ファイル構成

```
home-manager/
├── flake.nix   # エントリーポイント・依存管理
├── flake.lock  # 依存バージョンのロックファイル（手動編集しない）
├── home.nix    # Darwin / Linux 共通設定（パッケージ一覧など）
├── darwin.nix  # macOS 固有設定
└── linux.nix   # Linux(WSL) 固有設定
```

#### 設計方針

- `home.nix` に共通パッケージ（LSP・linter・formatter など）をまとめる
- `darwin.nix` / `linux.nix` が `home.nix` を `imports` で取り込み、OS 固有の設定を上書き・追加する
- `flake.nix` で `pkgsDarwin`（aarch64-darwin）と `pkgsLinux`（x86_64-linux）を別々に用意し、`homeConfigurations."matukoto@darwin"` / `"matukoto@linux"` として公開する

## 参考

- [home-manager入門/kuu](https://zenn.dev/kuu/articles/20250204_introduce-home-manager)
- [Homebrew管理下のCLIをNixに移してみる/kawarimidoll](https://zenn.dev/kawarimidoll/articles/0a4ec8bab8a8ba)
- [Nixでdotfiles管理できるようになるまでのメモ](https://zenn.dev/airrnot1106/scraps/20e6a33574229f)
- [Nixとhome-managerにdotfiles管理を移行する](https://blog.tomoyukim.net/entry/nix-home-manager/)
- [home-manager/modules/programs at master · nix-community/home-manager](https://github.com/nix-community/home-manager/tree/master/modules/programs)
