# soc-toolbox

主に動画編集に使うちょっとしたツール類

1. [voicevox-caller](#voicevox-caller)：VOICEVOXの音声合成エンジンを呼ぶスクリプト。Recotte Studioのユーザー定義音声連携に使えます
1. [aivos-userdef](#aivos-userdef)：Recotte Studioのユーザー定義音声連携にインポートするためのA.I.VOICE向け設定ファイル
1. voice-list-generator
   * [tuinavo-list-generator](#tuinavo-list-generator)：ついなちゃんの配布ボイスをぴた声アプリやRecotte Studioから便利に使えるようにするためのスクリプト

----

## voicevox-caller

PowerShellから[VOICEVOX](https://voicevox.hiroshiba.jp/)の音声合成エンジンを呼ぶためのスクリプトです

### Recotte Studioの「ユーザー定義音声連携」での使い方

#### インストール手順

1. [Releaseページ](https://github.com/so-c/soc-toolbox/releases)から`voicecox-caller-vX.Y.Z.zip`をダウンロードして展開する
1. `voicevox-caller`フォルダーにある`voicevox-caller.ps1`と`VOICEVOX(PowerShell 5.x).rvls`を好きな場所に保存する
1. Recotte Studioの [環境設定 > ユーザー定義音声連携の設定] を開く
1. インポートボタンを押して`VOICEVOX(PowerShell 5.x).rvls`を読み込む
1. [引数] で `-File ""` のダブルクォーテーションの中に`voicevox-caller.ps1`のフルパスを書き足す
1. [適用] ボタンを押す

[引数] の設定例

```ps1
-ExecutionPolicy RemoteSigned -File "C:\Users\YourName\Documents\voicevox-caller\voicevox-caller.ps1" -text "%c" -speaker "%s" -output "%o"`
```

#### 準備

1. 話者レイヤーを追加してプロパティーを開く
1. [話者名] (≠名前) を「四国めたん」か「ずんだもん」で始まるようにする
   * 「ずんだもん クール」のようにスタイル名（`あまあま`,`ノーマル`, `ツンツン`, `クール`)を含めておくとそのスタイルで音声を作成します
1. [音声連携] でインストールした"VOICEVOX(PoerShell 5.x)" を選ぶ
1. [OK] ボタンを押す

#### 使い方

VOICEVOXを起動した状態で [音声の同期] をしてください

参考動画：[Recotte Studio（レコスタ）ユーザー定義音声連携 \- YouTube](https://www.youtube.com/watch?v=N_VCF2ABKA8)

[![参考動画](https://img.youtube.com/vi/N_VCF2ABKA8/0.jpg)](https://www.youtube.com/watch?v=N_VCF2ABKA8)

#### ヒント

* 音声が作成されない場合は`voicevox-caler.ps1`と同じフォルダの`last_error.txt`を確認してみてください。最後に発生したエラーが出力されています
* 調整パラメータを [ユーザ定義音声連携] の引数として渡せます。利用できるパラメータはVOICEVOXのドキュメント (<http://127.0.0.1:50021/docs>) を参照してください
* このスクリプトはWindowsに最初からインストールされてるWindows PowerShell ISEで変更・動作確認できます。好みに合わせてカスタマイズして使ってください

----

## aivos-userdef

Recotte StudioでVOICEROID2連携と同じようにA.I.VOICEを起動するためのユーザー定義音声連携ファイルです

* インストール手順
  1. [Releaseページ](https://github.com/so-c/soc-toolbox/releases)から`aivos-userdef-vX.Y.Z.zip`をダウンロードして展開する
  1. Recotte Studioのユーザー定義音声連携として`aivos-userdef\aivos-userdef.rvls`をインポートする

使い方はRecotte Studioのマニュアルでご確認ください

----

## tuinavo-list-generator

ついなちゃんが[Fantia](https://fantia.jp/fanclubs/326)で配布しているサンプルボイスを、ぴた声アプリやRecotte Studioから便利に使えるようにするスクリプトです

[Releaseページ](https://github.com/so-c/soc-toolbox/releases)から`tuinavo-list-generator-vX.Y.Z.zip`をダウンロードして展開してください

使い方は`voice-list-generator\tuinavo\`フォルダの[「使い方.txt」](https://github.com/so-c/soc-toolbox/blob/main/voice-list-generator/tuinavo/%E4%BD%BF%E3%81%84%E6%96%B9.txt)を参照してください

----

### 利用規約

* ユーザ向け
  * このリポジトリで公開しているスクリプトなどはインターネット全般で非商用・商用問わず利用できます
  * Recotte StudioやVOICEVOX、各キャラクターなどそれぞれの利用規約に従ってください
  * （任意）ニコニコ動画で使う際は[voicevox\-caller \- ニコニ･コモンズ](https://commons.nicovideo.jp/material/nc252957)をコンテンツツリーに登録してもらえると作者が喜びます
* 開発者向け
  * スクリプト本体(ps1)は[MIT License](https://github.com/so-c/soc-toolbox/blob/main/LICENSE)です
