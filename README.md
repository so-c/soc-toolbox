# soc-toolbox

主に動画編集に使うちょっとしたツール類

1. [voivoca](#voivoca)：[VOICEVOX](https://voicevox.hiroshiba.jp/), [COEIROINK](https://coeiroink.com/)の音声合成エンジンを呼ぶスクリプト。Recotte Studioのユーザー定義音声連携に使えます
1. [aivos-userdef](#aivos-userdef)：Recotte StudioでA.I.VOICEをVOICEROD2と同じように連携させるためのユーザー定義音声連携設定ファイル
1. voice-list-generator
   * [tuinavo-list-generator](#tuinavo-list-generator)：[ついなちゃん](https://ついなちゃん.com)の配布ボイスをぴた声アプリやRecotte Studioから使いやすくするためのスクリプト

----

## voivoca

VOICEVOX, COEIROINKの音声合成エンジンを呼ぶためのWindows PowerShellスクリプトです。Recotte Studioの「ユーザー定義音声連携」で使うことができます

詳しくは[マニュアルページ](https://so-c.github.io/toolbox/voicevox-caller.html)をご覧ください

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

### 参考動画
* [第9回「ぴた声アプリで音声素材の管理」 \- YouTube](https://www.youtube.com/watch?v=KfCVTM4OaZA)
* [【2分で教えてついなちゃん♡】ぴた声アプリで音声素材を管理＋ついなボリストジェネレータの紹介【レコスタ・ぴた声】 - ニコニコ動画](https://www.nicovideo.jp/watch/sm39480301)

[![参考動画](https://img.youtube.com/vi/KfCVTM4OaZA/0.jpg)](https://www.youtube.com/watch?v=KfCVTM4OaZA)

### 謝辞
[マスコットアプリ文化祭2021の咲ちゃん賞をいただきました。ありがとうございます](https://fantia.jp/posts/1150646)

----

### 利用規約

* ユーザ向け
  * このリポジトリで公開しているスクリプトなどはインターネット全般で非商用・商用問わず利用できます
  * Recotte StudioやVOICEVOX、各キャラクターなどそれぞれの利用規約に従ってください
  * （任意）ニコニコ動画で使う際はニコニ･コモンズをコンテンツツリーに登録してもらえると作者が喜びます
    * [voivoca](https://commons.nicovideo.jp/material/nc252957)
    * [tuinavo\-list\-generator（ついなボリストジェネレータ）](https://commons.nicovideo.jp/material/nc254607)
* 開発者向け
  * スクリプト本体(ps1)は[MIT License](https://github.com/so-c/soc-toolbox/blob/main/LICENSE)です
