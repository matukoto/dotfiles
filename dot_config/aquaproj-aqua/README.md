# aqua設定

このディレクトリには[aqua](https://aquaproj.github.io/)の設定ファイルが含まれています。

## ファイル構成

- `aqua.yaml`: aquaのメイン設定ファイル
- `aqua-checksums.json`: パッケージのチェックサム情報

## チェックサム検証とは

チェックサム検証は、ダウンロードしたパッケージのバイナリファイルが改ざんされていないことを確認するセキュリティ機能です。
各パッケージのチェックサム（ハッシュ値）を事前に記録しておき、インストール時に実際のファイルのチェックサムと照合することで、ファイルの整合性を保証します。

### 導入の目的

このリポジトリでチェックサム検証を導入した理由：

1. **サプライチェーン攻撃からの保護**: パッケージの配布経路で改ざんされたバイナリが混入することを防ぎます
2. **ダウンロードエラーの検出**: ネットワークエラーなどによる破損したファイルのインストールを防ぎます
3. **再現性の保証**: 同じバージョンのパッケージが常に同じバイナリであることを保証します

セキュリティ向上のため、チェックサム検証が有効化されています。

### チェックサムの生成

新しいパッケージを追加した後、または既存のパッケージのバージョンを更新した後は、以下のコマンドでチェックサムを生成してください：

```bash
aqua update-checksum --all
```

### チェックサムの自動更新

Renovateの`postUpgradeTasks`機能を使用して、`aqua.yaml`の変更時にチェックサムを自動的に更新します。

`renovate.json5`に以下の設定を追加しています：

```json
{
  "postUpgradeTasks": {
    "commands": [
      "aqua update-checksum --all --config dot_config/aquaproj-aqua/aqua.yaml"
    ],
    "fileFilters": [
      "dot_config/aquaproj-aqua/aqua-checksums.json"
    ],
    "executionMode": "update"
  }
}
```

これにより、Renovateがパッケージのバージョンを更新するPRを作成する際に、自動的にチェックサムも更新され、手動でチェックサムを更新する手間が省けます。

### 参考資料

- [aqua チェックサム検証のハンドブック](https://zenn.dev/shunsuke_suzuki/books/aqua-handbook/viewer/checksum-verification)
- [aqua 公式ドキュメント](https://aquaproj.github.io/)
