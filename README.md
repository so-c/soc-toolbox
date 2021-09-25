# soc-toolbox

主に動画編集に使うちょっとしたツール類

## voicevox-caller

PowerShellからVOICEVOXの音声合成エンジンを呼ぶためのスクリプトです。

### Recotte Studioの「ユーザー定義音声連携」での使い方

#### インストール手順

1. `voicevox-caler.ps1`と`VOICEVOX(PowerShell 5.x).rvls`をダウンロードして好きなフォルダに保存する
1. Recotte Studioの [環境設定 > ユーザー定義音声連携の設定] を開く
1. インポートボタンを押して`VOICEVOX(PowerShell 5.x).rvls`を読み込む
1. [引数] で `-File ""` のダブルクォーテーションの中に`voicevox-caler.ps1`のフルパスを書き足す
   * `-ExecutionPolicy RemoteSigned -File "C:\Users\YourName\Documents\voicevox-caller\voicevox-caller.ps1" -text "%c" -speaker "%s" -output "%o"`
1. [適用]ボタンを押す

#### 準備

1. 話者レイヤーを追加してプロパティーを開く
1. [話者名] (≠名前) を「四国めたん」か「ずんだもん」で始まるようにする
1. [音声連携] でインストールした"VOICEVOX(PoerShell 5.x)" を選ぶ
1. [OK] ボタンを押す

#### 使い方

VOICEVOXを起動した状態で[音声の同期] をしてください

#### ヒント

* 音声が作成されない場合は`voicevox-caler.ps1`と同じフォルダの`last_error.txt`を確認してみてください。最後に発生したエラーが出力されています
* 調整パラメータを [ユーザ定義音声連携] の引数として渡せます。利用できるパラメータはVOICEVOXのドキュメント (http://127.0.0.1:50021/docs) を参照してください
* このスクリプトはWindowsに最初からインストールされてるWindows PowerShell ISEで変更・動作確認できます。好みに合わせてカスタマイズして使ってください
