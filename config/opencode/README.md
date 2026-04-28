# OpenCode設定

`~/.config/opencode` に配備する OpenCode 設定。
モデル定義、LSP、subagent、プラグイン依存の置き場。

## 主要ファイル

- `opencode.jsonc`: OpenCode 本体設定。
- `AGENTS.md`: エージェントへの作業ルール。
- `README.md`: このディレクトリの説明。

## 構成

- provider は `github-copilot` と `google` を有効化。
- 既定 model は `github-copilot/gpt-5.3-codex`。
- `small_model` は `google/gemini-3-pro-preview`。
- TypeScript LSP として `vtsls --stdio` を定義。
- plugin として `@sveltejs/opencode` を読み込み。
- subagent として `code-reviewer`, `explore`, `general`
  を定義。

## AGENTS.md の役割

- 日本語でのやりとり。
- 依頼内容、計画、実行、検証の要約保存。
- `docs/design/` / `docs/research/` への
  日本語ファイル名での記録ルール。

## 補足

- Git 追跡対象は
  `opencode.jsonc`, `AGENTS.md`, `README.md`。
- プラグイン依存の実体ファイルは
  このリポジトリでは管理しない前提。
