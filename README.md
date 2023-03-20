# soc-toolbox

主に動画編集に使うちょっとしたツール類

1. [voivoca](#voivoca)：[VOICEVOX](https://voicevox.hiroshiba.jp/), [COEIROINK](https://coeiroink.com/)の音声合成エンジンを呼ぶスクリプト。Recotte Studioのユーザー定義音声連携に使えます
1. [aivos-userdef](#aivos-userdef)：Recotte StudioでA.I.VOICEをVOICEROD2と同じように連携させるためのユーザー定義音声連携設定ファイル
1. voice-list-generator
   * [セット](#voice-list-generatorセット)：音声合成キャラクター音声素材をぴた声アプリやRecotte Studioから使いやすくするためのスクリプト詰合せ
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

## voice-list-generatorセット

音声合成キャラクタの音声素材をぴた声やRecotte Studioから便利に使えるようにするスクリプトの詰合せです。下記のボイス用のスクリプトがあります。

* [紲星あかり exVOICE vol.1](https://www.ah-soft.com/exvoice/)
* [A.I.VOICE 紲星あかり exVOICE](https://aivoice.jp/news/1637/)
* [A.I.VOICE 咲ちゃん exVOICE](https://aivoice.jp/product/sakichan/)
* [フリモメン おまけ音声素材](https://www.ah-soft.com/frimomen/)

※ついなちゃんがfantiaで配布しているサンプルボイスには、[tuinavo-list-generator](#tuinavo-list-generator)をお使いください

### 使い方

各種音声素材は取得したそのままのフォルダ構成、ファイル名を前提としています。変更されている場合、正常に動作しません。ご了承ください。

1. [Releaseページ](https://github.com/so-c/soc-toolbox/releases)から`voice-list-generator-vX.Y.Z.zip`をダウンロードして展開してください
2. スタートメニューから「Windows PowerShell ISE」または「Windows PowerShell」を起動します
3. まず今開いているウィンドウでスクリプトを実行できるようにします。`Set-ExecutionPolicy Bypass -Scope Process`をコピペしてEnterを押してください
4. メッセージを確認してこのスクリプトを信用して動かすなら「Y」を入力してEnterを押してください
5. スクリプトをShiftを押しながら右クリックして「パスのコピー」を選択します
6. 先頭に". "を入力、スクリプトのパスをペースト、`exVoiceFolder`オプションに音声素材フォルダのパスを入力して、Enterを押してください
7. 音声素材フォルダに設定ファイルが作成されていれば実行成功です。ぴた声アプリ、Recotte Studioへの登録は各ソフトのマニュアルを参照してください

```PowerShell
# 入力例：A.I.VOICE紲星あかり exVOICEが、C:\exVOICE_KizunaAkari_vo1にある場合
. "C:\Users\YourName\Documents\soc-toolbox\voice-list-generator\akarivo\akarivo-aivos-list-generator.ps1" -exVoiceFolder "C:\exVOICE_KizunaAkari_vo1"
```

----

## tuinavo-list-generator

* [tuinavo – Mirror House Annex](https://so-c.github.io/toolbox/tuinavo)をご覧ください

----

### 利用規約

* ユーザ向け
  * このリポジトリで公開しているスクリプトなどはインターネット全般で非商用・商用問わず利用できます
  * Recotte StudioやVOICEVOX、各キャラクターなどそれぞれの利用規約に従ってください
  * （任意）ニコニコ動画で使う際はニコニ･コモンズをコンテンツツリーに登録してもらえると作者が喜びます
    * [voivoca](https://commons.nicovideo.jp/material/nc252957)
    * voice-list-generatorセット（ニコニ・コモンズ登録作業中）
    * [tuinavo\-list\-generator（ついなボリストジェネレータ）](https://commons.nicovideo.jp/material/nc254607)
* 開発者向け
  * スクリプト本体(ps1)は[MIT License](https://github.com/so-c/soc-toolbox/blob/main/LICENSE)です

### PR

主に[soc - ニコニコ](https://www.nicovideo.jp/user/13145014)で動画、イラスト、DTMもしています。よかったらご覧ください。ご無理なければクリエイターサポート（月額￥3３0）もしていただけると幸いです
