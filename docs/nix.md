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

```~/.cofnig/nix/nix.conf
experimental-features = nix-command flakes
```

```sh
 nix run home-manager/master -- init --switch
```

### 手始めに Nix の lsp と formatter を home-manager で管理する

```nix
{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # lsp
    rls
    rust-analyzer
    # formatter
    rustfmt
  ];
}
```formmter

## 参考

- [home-manager入門/kuu](https://zenn.dev/kuu/articles/20250204_introduce-home-manager)
