# recosta-project-cleaner

Recotte Studio（レコスタ）のプロジェクトJSONファイルから未使用ファイル参照を削除するF#製CLIツールです。

## 使い方

### 1. ビルド済みファイルを使う（エンドユーザー向け・推奨）

1. [最新リリースをダウンロード](https://github.com/so-c/soc-toolbox/releases)し、zipファイルを展開します。
2. コマンドプロンプトで以下のように実行します：

   ```sh
   recosta-project-cleaner.exe <入力.ccproj> [出力.ccproj] [--force]
   ```

#### コマンドライン引数の説明

- `<入力.ccproj>` : クリーンアップしたいRecotte Studioプロジェクトファイル（JSON形式）
- `[出力.ccproj]` : （省略可）出力先ファイル名。省略時は `<入力>.cleaned.ccproj` となります
- `[--force]` : （省略可）出力先ファイルが既に存在する場合に上書きします

##### 使用例

- 基本的な使い方（`project.ccproj` をクリーンし `project.cleaned.ccproj` を出力）

  ```sh
  recosta-project-cleaner.exe project.ccproj
  ```

- 出力ファイル名を指定

  ```sh
  recosta-project-cleaner.exe project.ccproj cleaned.ccproj
  ```

- 上書き保存（出力先が既に存在する場合）

  ```sh
  recosta-project-cleaner.exe project.ccproj cleaned.ccproj --force
  ```

### 2. ソースからビルドする（開発者向け）

1. プロジェクトをビルド：

   ```sh
   dotnet build
   ```

2. ツールを実行：

   ```sh
   dotnet run -- <オプション>
   ```

## 特長

- Recotte StudioプロジェクトJSONから未使用ファイル参照を削除
- Windows CLI向けに設計

## 必要環境

- .NET 5.0 SDK 以降

## リリースバイナリのビルド

Windows x64向けの自己完結型バイナリをビルドするには：

```sh
# プロジェクトルートで実行
 dotnet publish src/recosta-project-cleaner/recosta-project-cleaner.fsproj -c Release -r win-x64 --self-contained true -p:PublishSingleFile=true -o ./publish/win-x64
```

出力バイナリは `publish/win-x64` ディレクトリに生成されます。

## ライセンス
MIT License
