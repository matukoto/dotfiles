# aqua設定

`~/.config/aqua` に配備する aqua 設定。
CLI ツールの導入元、バージョン、チェックサム管理の置き場。

## 主要ファイル

- `aqua.yaml`: パッケージ定義本体。
- `aqua-checksums.json`: 配布バイナリのチェックサム記録。

## 構成

- 汎用 CLI ツールの導入先。
- `aqua-checksums.json` により
  ダウンロード物の整合性確認を実施。
- バージョン更新時は
  `aqua.yaml` と `aqua-checksums.json` の両方が更新対象。

## 運用

- パッケージ追加や更新後のチェックサム生成コマンド:

```bash
aqua update-checksum --all --config config/aqua/aqua.yaml
```

- ローカルの `renovate.json5` では
  `postUpgradeTasks` を明示定義していない。
- Renovate 設定は
  `github>aquaproj/aqua-renovate-config#2.12.0` を extends。
- ローカル設定では
  `config/aqua/**` を `aqua` グループとして扱う package rule を定義。
- チェックサム更新が必要な変更では
  `aqua.yaml` と `aqua-checksums.json` の整合を保つ前提。

## 関連設定

- aqua 本体の導入は `config/home-manager/home.nix` と
  `config/home-manager/pkgs/aqua.nix` 側で管理。
- shell からの利用は
  `config/home-manager/fish/config.fish` の
  `AQUA_GLOBAL_CONFIG` と `aqua i -a` 系 abbr に連動。

## 参考

- [aqua 公式ドキュメント](https://aquaproj.github.io/)
- [aqua checksum](https://aquaproj.github.io/docs/reference/checksum/)
- [aqua-renovate-config](https://github.com/aquaproj/aqua-renovate-config)
- [Renovate postUpgradeTasks](https://docs.renovatebot.com/configuration-options/#postupgradetasks)
