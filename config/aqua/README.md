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

- `renovate.json5` の `postUpgradeTasks` からも
  同じコマンドを実行する構成。
- Renovate 更新時は
  `config/aqua/aqua.yaml` と
  `config/aqua/aqua-checksums.json` を
  同時に更新する前提。

## 関連設定

- aqua 本体の導入は `config/home-manager/home.nix` と
  `config/home-manager/pkgs/aqua.nix` 側で管理。
- shell からの利用は
  `config/home-manager/fish/config.fish` の
  `AQUA_GLOBAL_CONFIG` と `aqua i -a` 系 abbr に連動。

## 参考

- [aqua 公式ドキュメント](https://aquaproj.github.io/)
- [aqua checksum](https://aquaproj.github.io/docs/reference/checksum/)
- [Renovate postUpgradeTasks](https://docs.renovatebot.com/configuration-options/#postupgradetasks)
