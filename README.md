# soc-toolbox

主に動画編集に使うちょっとしたツール類

1. [voicevox-caller](#voicevox-caller)：[VOICEVOX](https://voicevox.hiroshiba.jp/), [COEIROINK](https://coeiroink.com/)の音声合成エンジンを呼ぶスクリプト。Recotte Studioのユーザー定義音声連携に使えます
1. [aivos-userdef](#aivos-userdef)：Recotte StudioでA.I.VOICEをVOICEROD2と同じように連携させるためのユーザー定義音声連携設定ファイル
1. voice-list-generator
   * [tuinavo-list-generator](#tuinavo-list-generator)：[ついなちゃん](https://ついなちゃん.com)の配布ボイスをぴた声アプリやRecotte Studioから使いやすくするためのスクリプト

----

## voicevox-caller

VOICEVOX, COEIROINKの音声合成エンジンを呼ぶためのWindows PowerShellスクリプトです

使用例
```ps1
.\voicevox-caller.ps1 "ずんだもん（あまあま）" "ずんだもんなのだ" zundamon.wav
```

### Recotte Studioの「ユーザー定義音声連携」での使い方

#### インストール手順

※「ユーザー定義音声連携」の使い方は[Recotte Studioのマニュアル](https://www.ah-soft.com/rs/manual/tips/user-def.html)も参照してください

1. [Releaseページ](https://github.com/so-c/soc-toolbox/releases)から`voicecox-caller-vA.B.C.D.zip`をダウンロードして好きな場所に展開する
1. Recotte Studioの [環境設定 > ユーザー定義音声連携の設定] を開く
1. インポートボタンを押して展開したフォルダにある`VOICEVOX(PowerShell 5.x).rvls`を選ぶ
1. [引数] で `-File ""` のダブルクォーテーションの中に展開したフォルダにある`voicevox-caller.ps1`へのフルパスを書き足す
1. [適用] ボタンを押す

[引数] の設定例

```ps1
-ExecutionPolicy RemoteSigned -File "C:\Users\YourName\Documents\voicevox-caller\voicevox-caller.ps1" -text "%c" -speaker "%s" -output "%o"
```

#### 使用準備

1. 話者レイヤーを追加してプロパティーを開く
1. [話者名] (≠名前) をキャラクター名で始まるように設定してください
   * スタイルがあるキャラクタは「ずんだもん（あまあま）」のように指定してください
1. [音声連携] でインストールした"VOICEVOX(PoerShell 5.x)" を選ぶ
1. [OK] ボタンを押す

【話者一覧】

| VOICEVOX ||||
| --- | --- | --- | --- |
| 四国めたん | ずんだもん | 九州そら | |
| 春日部つむぎ | 雨晴はる | 波音リツ | |
| 黒野玄宏 | 白上虎太郎 | 青山龍星 | 冥鳴ひまり | 

|COEIROINK |||
| --- | --- | --- |
| つくよみちゃん | MANA | おふとんP |
| ディアちゃん | アルマちゃん | |

【スタイル一覧】

| 四国めたん | ずんだもん | 九州そら | つくよみちゃん |
| --- | --- | --- | --- | 
|ノーマル|ノーマル|ノーマル|れいせい|
|あまあま|あまあま|あまあま|おしとやか|
|ツンツン|ツンツン|ツンツン|げんき|
|セクシー|セクシー|セクシー||
|||ささやき||

#### 使用方法

VOICEVOX, COEIROINKを起動した状態で [音声の同期] をしてください。

#### 参考動画
[![参考動画](https://img.youtube.com/vi/N_VCF2ABKA8/0.jpg)](https://www.youtube.com/watch?v=N_VCF2ABKA8)

[Recotte Studio（レコスタ）ユーザー定義音声連携 \- YouTube](https://www.youtube.com/watch?v=N_VCF2ABKA8)

#### ヒント

* 音声が作成されない場合は`voicevox-caler.ps1`と同じフォルダの`last_error.txt`を確認してみてください。最後に発生したエラーが出力されています
* 調整パラメータを [ユーザ定義音声連携] の引数として渡せます。利用できるパラメータVOICEVOX, COEIROINKのドキュメント (<http://127.0.0.1:50021/docs>またはhttp://127.0.0.1:50031/docs>) を参照してください
* このスクリプトはWindowsに最初からインストールされてるWindows PowerShell ISEで変更・動作確認できます。好みに合わせてカスタマイズしてください

----

## aivos-userdef

Recotte StudioでA.I.VOICEをVOICEROD2と同じように連携させるためのユーザー定義音声連携設定ファイル

* インストール手順
  1. [Releaseページ](https://github.com/so-c/soc-toolbox/releases)から`aivos-userdef-vX.Y.Z.zip`をダウンロードして展開する
  1. Recotte Studioのユーザー定義音声連携として`aivos-userdef\aivos-userdef.rvls`をインポートする

使い方はRecotte Studioのマニュアルでご確認ください

----

## tuinavo-list-generator

ついなちゃんが[Fantia](https://fantia.jp/fanclubs/326)で配布しているサンプルボイスを、ぴた声アプリやRecotte Studioから便利に使えるようにするスクリプトです

[Releaseページ](https://github.com/so-c/soc-toolbox/releases)から`tuinavo-list-generator-vX.Y.Z.zip`をダウンロードして展開してください

使い方は`voice-list-generator\tuinavo\`フォルダの[「使い方.txt」](https://github.com/so-c/soc-toolbox/blob/main/voice-list-generator/tuinavo/%E4%BD%BF%E3%81%84%E6%96%B9.txt)を参照してください

参考動画：[第9回「ぴた声アプリで音声素材の管理」 \- YouTube](https://www.youtube.com/watch?v=KfCVTM4OaZA)

[![参考動画](https://img.youtube.com/vi/KfCVTM4OaZA/0.jpg)](https://www.youtube.com/watch?v=KfCVTM4OaZA)

----

### 利用規約

* ユーザ向け
  * このリポジトリで公開しているスクリプトなどはインターネット全般で非商用・商用問わず利用できます
  * Recotte StudioやVOICEVOX、各キャラクターなどそれぞれの利用規約に従ってください
  * （任意）ニコニコ動画で使う際はニコニ･コモンズをコンテンツツリーに登録してもらえると作者が喜びます
    * [voicevox\-caller](https://commons.nicovideo.jp/material/nc252957)
    * [tuinavo\-list\-generator（ついなボリストジェネレータ）](https://commons.nicovideo.jp/material/nc254607)
* 開発者向け
  * スクリプト本体(ps1)は[MIT License](https://github.com/so-c/soc-toolbox/blob/main/LICENSE)です
