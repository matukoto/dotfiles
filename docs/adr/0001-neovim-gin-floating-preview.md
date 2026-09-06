# ADR-0001: GinStatus に上下配置の floating 自動プレビューを採用する

- 状態: 採用
- 決定日: 2026-09-06
- 対象: Neovim の vim-gin 設定

## 背景

今まで gin の画面を tab や buffer で表示してきたが、画面を消したあともバッファとして残ってしまい、一覧性などが低下していた。まだ gin の画面を探すのも時間がかかっていた。 Git の操作画面は保持する必要がないため floating で表示するのが最善ではないかと考えた。

### 追加で発生した問題点

Git 操作中も編集画面の配置を保ち、GinStatus のファイル一覧と差分を同時に確認したい。
横幅に余裕がないため、一覧と差分の左右配置および side-by-side diff は適さない。
また、Gin が内部で保持するバッファが bufferline に表示され、通常の編集ファイルと混在する問題があった。

## 決定

### Floating の入口

空の floating window を先に作り、その中で Gin コマンドを実行する `:GinFloat` を使う。
Gin の既定の `edit` opener がそのウィンドウのバッファを置き換える。
既存の通常ウィンドウをイベントで後から floating に移す方式は使わない。

Status / Log / Branch のキーマップと dashboard の Git Status をこの入口へ接続する。
すべての Gin コマンドやアクションを強制的に floating 化するものではない。
`GinPatch` / `GinChaperon` の複数ペイン比較や editor proxy は今回の変更対象外とする。

### プレビューの配置と更新

Neovim 標準の window API を使い、上段に GinStatus、下段に unified diff を表示する。
全体は画面の約85%、枠を除く高さの配分は一覧約30%、差分約70%とする。

```text
┌─ GinStatus ─────────────────────────┐
│ > M src/app.ts                      │
│   M README.md                       │
├─ Diff (unified) ────────────────────┤
│   10      │ - const count = 0;       │
│        10 │ + const count = 1;       │
│   11   11 │   return count;          │
└─────────────────────────────────────┘
```

- Floating の GinStatus を開いた時点で下段も表示する。
- カーソル移動・一覧の内容変更に追従し、120ms の debounce で連続イベントをまとめる。
- 更新中の再入を防ぎ、下段に一時表示した status バッファから自動更新を起動しない。
- 下段ウィンドウを再利用し、更新後は上段にフォーカスを戻す。
- ヘッダーなどファイル以外の行では選択を促すメッセージを表示する。
- Status を閉じると下段も閉じる。下段を閉じると一覧を元の大きさに戻す。
  一覧で次にカーソルを移動するとプレビューは再表示される。

### 差分の取得と操作

ファイル名を Lua 側で独自解析せず、Gin の既存アクションにパス解決と差分取得を任せる。
通常は `diff:smart:edit` を使う。Gin の判定に従い、index に変更がある場合は staged、
それ以外は unstaged を表示する。両方の変更がある場合は手動で切り替えられる。
未追跡ファイルは `edit:local:edit` で内容を表示し、追加差分とは区別する。

| 操作 | 動作 |
| --- | --- |
| カーソル移動 | 選択ファイルのプレビューを自動更新 |
| `p` | smart 判定で手動更新 |
| `gS` / `gU` | staged / unstaged を手動表示 |
| `Tab` | 一覧からプレビューへ移動 |
| 差分側の `q` | プレビューを閉じて一覧へ戻る |
| 未追跡ファイル側の `<C-w>c` | 内容表示ウィンドウを閉じる |

staged / unstaged の手動選択は固定モードではなく、次の自動更新では smart 判定に戻る。

### 行番号と delta

差分バッファ内の通し番号ではなく、変更前・変更後のソース行番号を表示する。
Unified diff の hunk 見出しと行頭の記号から行番号を計算し、inline virtual text で添える。
未追跡ファイルの内容表示には通常の行番号を使う。

delta は `--diff-highlight --no-gitconfig --color-only` で色付けに使う。
delta の `--line-numbers` は本文の構造を変えるため採用しない。
Gin の差分ジャンプが読む `+` / `-` や hunk 見出しをそのまま維持する。
Denops の実行許可は `--allow-run=git,delta` とする。

### バッファの寿命と表示

Gin 本体のバッファを `bufhidden=wipe` にしない。
試行時には、削除したバッファを Denops の遅延リロードが参照して `E680: invalid buffer number` が発生した。
内部バッファの保持と、ユーザー向けの表示対象を分ける。

bufferline の `custom_filter` で `^gin[%w-]*://` に一致する URI を除外する。
この除外は表示中かどうかを問わず適用する。`:ls!` には引き続き表示される。
Gin が管理しない一時 scratch buffer のみ、非表示時に wipe する。

## 検討した代替案

- **Gin バッファを後から floating へ移動する**: ウィンドウ・バッファ再利用との干渉があり、撤回した。
- **別の大きな floating を重ねる**: ファイル一覧が隠れるため、上下配置を選んだ。
- **左右配置 / side-by-side diff**: 利用環境の横幅に合わない。
- **手動プレビューのみ**: 初期案として実装後、カーソル追従へ変更した。手動操作も残す。
- **nvim-gin-preview**: Neovim の登録・依存関係・lockfile から削除した。
  今回は必要な配置とライフサイクルを独自モジュールで管理する。
- **nui.nvim**: 配置の補助として検討したが、実装は標準 window API で完結しており使用しない。
- **Neogit への置換**: Gin の操作体系を継続するため採用しない。

## 影響・制約

- Gin の内部アクション名と同期的な `denops#request` に依存する。
  Gin/Denops 更新時には、カーソル・対象バッファ・フォーカスの扱いを再確認する。
- Debounce は実行回数を減らすが、実行済みの Git 処理をキャンセルするものではない。
- 行番号付与は通常の unified diff を対象とする。combined diff やバイナリ差分の行番号は対象外。
- 未追跡ファイルは実ファイルのバッファを表示する。専用の読み取り専用コピーではない。
- プレビューを閉じても Gin バッファは保持するため、bufferline 非表示をバッファ削除と混同しない。
- 実装時の headless 模擬テストでは、繰り返し表示、ウィンドウ再利用、サイズ復元、
  行番号付与と本文保持、初期表示、debounce、フォーカス、終了時の片付けを確認した。
  これらは実際の Gin/Denops を含む統合テストを代替しない。

## 実装・参考資料

- [Gin の入口とキーマップ](../../config/nvim/lua/plugins/gin.lua)
- [上下プレビューと自動更新](../../config/nvim/lua/config/gin_preview.lua)
- [bufferline の除外設定](../../config/nvim/lua/plugins/bufferline.lua)
- [Denops の実行許可](../../config/nvim/lua/plugins/denops.lua)
- [dashboard](../../config/nvim/lua/plugins/snacks.lua)
- [aiya000/dotfiles の GinStatus 設定](https://github.com/aiya000/dotfiles/blob/main/.config/nvim/after/ftplugin/gin-status.lua)
- [aiya000/dotfiles のキーマップ](https://github.com/aiya000/dotfiles/blob/main/.config/nvim/lua/keymaps.lua)

参考リポジトリからは、先に floating を開く入口、一覧を保持する操作、差分表示先の再利用を参考にした。
参考実装の通常タブ / split による差分表示は、そのまま採用していない。
