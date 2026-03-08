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

```nix
home.packages = with pkgs; [  nixfmt
  nixd
];
```

### パッケージ最新化

```sh
# ~/.local/share/chezmoi/dot_config/home-manager で flake 更新と switch をまとめて実行
hmu
```

### クロスプラットフォーム化

macOS と Linux(WSL2 Ubuntu) で同じ home.nix を利用できるようにする。
`hmu` は Nix 側で現在の OS に対応する flake ターゲットを選ぶ。

```sh
# 内部では OS ごとに以下を切り替える
home-manager switch --flake .#darwin
home-manager switch --flake .#linux
```

#### ファイル構成

```
home-manager/
├── flake.nix   # エントリーポイント・依存管理
├── flake.lock  # ロックファイル
├── home.nix    # OS 共通設定
├── darwin.nix  # macOS 固有設定
└── linux.nix   # Linux(WSL) 固有設定
```

### nixpkgs から検索

```sh
nix search nixpkgs <package-name>
```

### nixpkgs にない場合

今回は aqua をインストールしたい。
pkgs ディレクトリ配下に aqua.nix を作成して、aqua のインストール方法を記述する。
以下のように aqua.nix を作成しhome.nix で aqua.nix を呼び出す。

```
home-manager/
├── home.nix
└── pkgs/
    └── aqua.nix
```

##### home.nix

```nix
{
  home = {
    packages = with pkgs; [
       # aqua.nix を呼び出す
      (pkgs.callPackage ./pkgs/aqua.nix { })
    ];
  }
}
```

##### aqua.nix

Linux と macOS でインストールするファイルが違うため、それぞれ設定している

```nix
{ pkgs }:

let
  version = "2.56.7";

  target =
    if pkgs.stdenv.isDarwin then
      {
        suffix = "darwin_arm64";
        sha256 = "8d6b37e86448debc0dfabf3b103f11bea8d7ad9b0c0b9bb3163b6075bbd87aba";
      }
    else
      {
        suffix = "linux_amd64";
        sha256 = "0000000000000000000000000000000000000000000000000000000000000000";
      };
in
pkgs.stdenv.mkDerivation {
  pname = "aqua";
  inherit version;

  src = pkgs.fetchurl {
    url = "https://github.com/aquaproj/aqua/releases/download/v${version}/aqua_${target.suffix}.tar.gz";
    sha256 = target.sha256;
  };

  sourceRoot = ".";

  installPhase = ''
    mkdir -p $out/bin
    cp -r aqua $out/bin/
    chmod +x $out/bin/aqua
  '';

  meta = {
    description = "Declarative CLI Version manager written in Go.";
    homepage = "https://github.com/aquaproj/aqua";
    license = pkgs.lib.licenses.mit;
  };
}
```

## 参考

- [home-manager入門/kuu](https://zenn.dev/kuu/articles/20250204_introduce-home-manager)
- [Homebrew管理下のCLIをNixに移してみる/kawarimidoll](https://zenn.dev/kawarimidoll/articles/0a4ec8bab8a8ba)
- [Nixでdotfiles管理できるようになるまでのメモ](https://zenn.dev/airrnot1106/scraps/20e6a33574229f)
- [Nixとhome-managerにdotfiles管理を移行する](https://blog.tomoyukim.net/entry/nix-home-manager/)
- [home-manager/modules/programs at master · nix-community/home-manager](https://github.com/nix-community/home-manager/tree/master/modules/programs)
- [yuyu-hf/dotfiles](https://github.com/yuyu-hf/dotfiles)
