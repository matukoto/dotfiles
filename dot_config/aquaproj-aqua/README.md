# aqua設定

このディレクトリには[aqua](https://aquaproj.github.io/)の設定ファイルが含まれています。

## ファイル構成

- `aqua.yaml`: aquaのメイン設定ファイル
- `aqua-checksums.json`: パッケージのチェックサム情報

## チェックサム検証

セキュリティ向上のため、チェックサム検証が有効化されています。

### チェックサムの生成

新しいパッケージを追加した後、または既存のパッケージのバージョンを更新した後は、以下のコマンドでチェックサムを生成してください：

```bash
aqua g-c
```

または

```bash
aqua generate-checksum
```

### 参考資料

- [aqua チェックサム検証のハンドブック](https://zenn.dev/shunsuke_suzuki/books/aqua-handbook/viewer/checksum-verification)
- [aqua 公式ドキュメント](https://aquaproj.github.io/)
