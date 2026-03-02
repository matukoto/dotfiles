# LSP・ツール管理をmasonからnixへ移行

## 依頼されたこと

Neovimで mason が管理していたLSPサーバー・linter・formatterをnix(home-manager)管理に移行する。

## 計画したこと

1. 各ツールのnixpkgs名を調査
2. `home.nix` にパッケージを追加
3. `lspconfig.lua` からmason依存を削除し `vim.lsp.enable()` に統一

## 実行したこと

### `dot_config/home-manager/home.nix`

以下のパッケージを `home.packages` に追加:

| mason名 | nixpkgs名 |
|---------|-----------|
| bash-language-server | `bash-language-server` |
| copilot-language-server | `copilot-language-server` |
| csharp-language-server (csharp_ls) | `csharp-ls` |
| fish-lsp | `fish-lsp` |
| fsautocomplete | `fsautocomplete` |
| fantomas | `fantomas` |
| jdtls | `jdt-language-server` |
| json-lsp (jsonls) | `vscode-langservers-extracted` |
| lemminx | `lemminx` |
| lombok-nightly | `lombok` |
| lua-language-server (lua_ls) | `lua-language-server` |
| svelte-language-server (svelte) | `svelte-language-server` |
| tailwindcss-language-server | `tailwindcss-language-server` |
| typos-lsp | `typos-lsp` |
| vim-language-server (vimls) | `vim-language-server` |
| vtsls | `vtsls` |
| yaml-language-server (yamlls) | `yaml-language-server` |
| actionlint | `actionlint` |
| eslint_d | `eslint_d` |
| fixjson | `fixjson` |
| markdownlint-cli2 | `markdownlint-cli2` |
| shellcheck | `shellcheck` |
| shfmt | `shfmt` |
| sql-formatter | `sql-formatter` |
| sqls | `sqls` |
| stylua | `stylua` |
| taplo | `taplo` |
| typos | `typos` |
| yamlfmt | `yamlfmt` |

**削除したもの（nixpkgsに存在しないため）:**
- `gh-actions-language-server` (gh_actions_ls) — nixpkgsに未収録

### `dot_config/nvim/lua/plugins/lspconfig.lua`

- `mason-org/mason.nvim`、`mason-org/mason-lspconfig.nvim`、`WhoIsSethDaniel/mason-tool-installer.nvim` を `dependencies` から削除
- `mason_servers` / `non_mason_servers` / `mason_tools` を `lsp_servers` に統合
- `require('mason-lspconfig').setup(...)` / `require('mason-tool-installer').setup(...)` を削除
- `vim.lsp.enable(lsp_servers)` に一本化

## 検証したこと

- `git diff` で意図通りの変更のみであることを確認
- コミット: `de4a645` feat: LSP/ツール管理をmasonからnix(home-manager)に移行

## 次のステップ

`home-manager switch` を実行してnixでパッケージをインストールし、Neovimを起動してLSPが動作することを確認する。
