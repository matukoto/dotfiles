# Copilot Instructions

## 基本

- 回答・コードコメント・コミットメッセージは日本語で記述する。
- コミットメッセージは `feat:`, `fix:`, `docs:` などのプレフィックス付きで、日本語の要約を書く。
- このリポジトリは chezmoi で管理する dotfiles。
  `dot_foo` は適用時に `.foo`、
  `dot_config/...` は `~/.config/...` に展開される。
- Linux / macOS では `.chezmoi.toml.tmpl` により symlink mode を使う。
  実環境の `~/.bashrc` や `~/.config/*` ではなく、
  このリポジトリ側の元ファイルを編集する。
- `.tmpl` は chezmoi の Go template。
  OS / ホスト差分は `{{ .chezmoi.os }}` /
  `{{ .chezmoi.hostname }}` と `.chezmoiignore` の条件分岐で吸収する。

## Build / test / lint / validation

- 通常のユニットテストスイートはない。
  CI では `.github/workflows/chezmoi-test.yaml` の
  `sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply` が
  dotfiles 全体の smoke test になっている。
- ローカル反映の基本コマンドは `chezmoi apply`。
  実環境を書き換えるので、
  レビュー目的や共有環境では不用意に実行しない。
- Home Manager 側の反映:
  - `cd dot_config/home-manager && home-manager switch --flake .#darwin`
  - `cd dot_config/home-manager && home-manager switch --flake .#linux`
  - fish の `hmu` は
    `nix flake update && home-manager switch --flake ".#<current-os>"`
    のラッパー。
- 初期セットアップ / ツール同期:
  - `mise i`
  - `aqua i -a`
- 手元の upstream clone を使う手動ビルド補助:
  - `sh run/run_nvim_build.sh`
  - `sh run/run_vim_build.sh`
- 単一対象の確認例:
  - `actionlint .github/workflows/chezmoi-test.yaml`
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
  1. **Chezmoi レイヤー**:
     ルートの `dot_*`、`dot_config/`、`.tmpl`、`.chezmoiignore` で
     各 OS へ配備する実ファイルを定義する。
  2. **Bootstrap レイヤー**:
     `run/` のスクリプトがセットアップを補助する。
     `run_once_*` は初回 apply 時だけ、
     `run_init.sh` は `mise i` / `aqua i -a` / `ghq get ...` をまとめる。
  3. **ツール管理レイヤー**:
     `dot_config/aqua/aqua.yaml` は CLI ツール本体、
     `dot_config/mise/config.toml` は言語ランタイムと npm 系 CLI、
     `dot_config/home-manager/home.nix` は
     LSP / formatter / linter などを管理する。
  4. **アプリ設定レイヤー**:
     `dot_config/nvim`、`dot_config/home-manager/fish`、`windows/`、
     `wslconf/`、`AppData/` などが各ツール / OS 向けの実設定を持つ。
- `dot_config/home-manager/` は独立した Nix flake。
  `flake.nix` が `darwin` / `linux` の出力を作り、
  `home.nix` に共通パッケージ、
  `darwin.nix` / `linux.nix` に OS 固有差分を置く。
- Fish は `dot_config/home-manager/fish/config.fish` をソースとして持つ。
  `dot_config/home-manager/modules/fish.nix` が
  OS ごとの行を差し込んだうえで
  `programs.fish.shellInit` と `xdg.configFile` に配備する。
  生成後の `~/.config/fish/config.fish` ではなく、
  リポジトリ側のソースを修正する。
- Neovim は `dot_config/nvim` 以下の Lua 設定が中心で、
  LSP / formatter / linter は Home Manager と外部 CLI に依存する。
  `lua/plugins/lspconfig.lua` は
  Nix で入れた LSP を `vim.lsp.enable(...)` で有効化し、
  `lua/plugins/conform.lua` と `lua/plugins/nvim-lint.lua` が
  filetype ごとの formatter / linter を切り替える。
- OS 別の配備は `.chezmoiignore` で切り替える。
  Windows では `AppData/` や `_vimrc` を使い、
  非 Windows では `dot_config/*` や `dot_vimrc.tmpl` を使う。

## このリポジトリの重要な慣習

- 実際のホームディレクトリ上の dotfile を直接編集しない。
  必ず chezmoi 管理下の元ファイルを編集し、
  必要なら `chezmoi apply` で反映する。
- OS / ホスト差分はファイルを複製するより
  `.tmpl` と `.chezmoiignore` の条件分岐で表現する。
  `dot_gitconfig.tmpl` のように `{{ include "..." }}` で
  外部断片を取り込むパターンも使う。
- 新しい CLI ツールやバージョン更新は追加先を分ける。
  - 汎用 CLI: `dot_config/aqua/aqua.yaml`（checksum 必須）
  - 言語ランタイム / npm ベース CLI: `dot_config/mise/config.toml`
  - エディタ依存の LSP / formatter / linter: `dot_config/home-manager/home.nix`
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
