# Copilot Instructions

## 基本

- 回答・コードコメント・コミットメッセージは日本語で記述する。
- コミットメッセージは `feat:`, `fix:`, `docs:` などのプレフィックス付きで、日本語の要約を書く。
- このリポジトリは Nix / Home Manager / nix-darwin で管理する dotfiles。
- 歴史的な理由で `dot_foo` や `dot_config/...` というパス名は残っているが、
  実際の配備は `dot_config/home-manager/` の flake と `modules/*.nix` が担当する。
- 実環境の `~/.bashrc` や `~/.config/*` を直接編集せず、
  必ずこのリポジトリ側の元ファイルを編集する。
- macOS は `nix-darwin` + Home Manager、Linux は Home Manager を使う。

## Build / test / lint / validation

- 通常のユニットテストスイートはない。
  CI では `.github/workflows/nix-validate.yaml` が
  Linux の Home Manager build と macOS の nix-darwin build を検証する。
- ローカル反映の基本コマンド:
  - macOS: `cd dot_config/home-manager && sudo darwin-rebuild switch --flake .#darwin`
  - Linux: `cd dot_config/home-manager && home-manager switch --flake .#linux`
- fish の `hms` は現在ホスト向けの反映、
  `hmu` は `nix flake update` + 反映のラッパー。
- 初期セットアップ / ツール同期:
  - `mise i`
  - `aqua i -a`
- 手元の upstream clone を使う手動ビルド補助:
  - `sh run/run_nvim_build.sh`
  - `sh run/run_vim_build.sh`
- 単一対象の確認例:
  - `actionlint .github/workflows/nix-validate.yaml`
  - `cd dot_config/home-manager &&`
    `nix build .#homeConfigurations.linux.activationPackage --no-link`
  - `cd dot_config/home-manager &&`
    `nix build .#darwinConfigurations.darwin.config.system.build.toplevel --no-link`
  - `shellcheck run/run_init.sh`
  - `shfmt -d run/run_init.sh`
  - `stylua --check dot_config/nvim/lua/plugins/lspconfig.lua`
  - `typos README.md`
  - `markdownlint-cli2 README.md`
- 複数ファイルをまとめて確認する例:
  - `actionlint .github/workflows/*.yaml`
  - `typos .`
- `renovate.json5` は
  `.github/workflows/renovete-config-validator.yaml` で
  CI 検証される。

## 高レベルアーキテクチャ

- このリポジトリは大きく 4 層で構成されている。
  1. **Flake レイヤー**:
     `dot_config/home-manager/flake.nix` が
     `darwinConfigurations` と `homeConfigurations` を定義する。
  2. **Bootstrap レイヤー**:
     `run/` のスクリプトがセットアップを補助する。
     `run_init.sh` は `mise i` / `aqua i -a` / `ghq get ...` をまとめる。
  3. **ツール管理レイヤー**:
     `dot_config/aqua/aqua.yaml` は CLI ツール本体、
     `dot_config/mise/config.toml` は言語ランタイムと npm 系 CLI、
     `dot_config/home-manager/home.nix` は
     Home Manager module を束ねてパッケージや dotfile 配備を管理する。
  4. **アプリ設定レイヤー**:
     `dot_config/nvim`、`dot_config/home-manager/fish`、
     `dot_claude`、`dot_copilot`、`dot_local` などが実設定を持つ。
- `dot_config/home-manager/` は独立した Nix flake。
  `flake.nix` が `darwin` / `linux` / host-specific Linux の出力を作り、
  `home.nix` に共通パッケージ、
  `darwin.nix` / `linux.nix` / `modules/*.nix` に役割別の差分を置く。
- Fish は `dot_config/home-manager/fish/config.fish` をソースとして持つ。
  `dot_config/home-manager/modules/fish.nix` が
  OS ごとの行と wrapper 関数を差し込んだうえで
  `programs.fish.shellInit` と `xdg.configFile` に配備する。
  生成後の `~/.config/fish/config.fish` ではなく、
  リポジトリ側のソースを修正する。
- Neovim は `dot_config/nvim` 以下の Lua 設定が中心で、
  LSP / formatter / linter は Home Manager と外部 CLI に依存する。
  `lua/plugins/lspconfig.lua` は
  Nix で入れた LSP を `vim.lsp.enable(...)` で有効化し、
  `lua/plugins/conform.lua` と `lua/plugins/nvim-lint.lua` が
  filetype ごとの formatter / linter を切り替える。
- Windows / AppData / `wslconf/` は別フェーズ扱いで、
  現在の Nix 移行スコープには含めない。

## このリポジトリの重要な慣習

- 実際のホームディレクトリ上の dotfile を直接編集しない。
  必ずリポジトリ側の元ファイルを編集し、
  必要なら `darwin-rebuild switch --flake` / `home-manager switch --flake` で反映する。
- OS / ホスト差分は `modules/*.nix` と flake 出力で表現する。
- 新しい CLI ツールやバージョン更新は追加先を分ける。
  - 汎用 CLI: `dot_config/aqua/aqua.yaml`（checksum 必須）
  - 言語ランタイム / npm ベース CLI: `dot_config/mise/config.toml`
  - エディタ依存の LSP / formatter / linter: `dot_config/home-manager/home.nix`
  - dotfile / config file 配備: `dot_config/home-manager/modules/*.nix`
- GitHub Copilot CLI の起動ポリシーは shell wrapper で管理する。
  fish は `dot_config/home-manager/fish/functions/`、
  bash は `dot_bash_aliases.tmpl` を確認する。
  `trusted_folders` のような machine-specific な永続設定は
  リポジトリではなくローカルの `~/.copilot/config.json` を使う。
- Fish 関連を変えるときは
  `dot_config/home-manager/fish/` と
  `dot_config/home-manager/modules/fish.nix` を合わせて確認する。
  Nix 側で OS 差分と生成ハッシュを入れている。
- Neovim の LSP は Mason ではなく Home Manager / Nix 管理。
  LSP を増減するときは `dot_config/home-manager/home.nix` と
  `dot_config/nvim/lua/plugins/lspconfig.lua` の両方を見る。
- 永続的な設計メモや調査メモの追加を依頼された場合は、
  既存の `dot_config/opencode/AGENTS.md` に合わせて
  `docs/design/` または `docs/research/`
  以下へ日本語ファイル名で配置する。
