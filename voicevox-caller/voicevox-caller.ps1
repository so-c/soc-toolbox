Param(
    [string]$speaker,
    $text,
    $output,
    # パラメータのリファレンス：
    # VOICEVOX  http://127.0.0.1:50021/docs
    # COEIROINK http://127.0.0.1:50031/docs
    $speedScale         = 1.0,
    $pitchScale         = 0.0,
    $intonationScale    = 1.0,
    $volumeScale        = 1.0,
    $prePhonemeLength   = 0.1,
    $postPhonemeLength  = 0.1,
    $outputSamplingRate = 24000,
    $outputStereo       = $false
)

# 環境パラメータ
# VOICEVOX/COEIROINKの.env参照
$VOICEVOX_URL  = "http://127.0.0.1:50021"
$COEIROINK_URL = "http://127.0.0.1:50031"

# ロガー定義
$logFile = "$PSScriptRoot\last_error.txt"
function Write-Log($msg) {
    $date = Get-Date -Format "yyyy/MM/dd HH:mm:ss"
    Write-Error "$date`t$msg" 2>&1 > $logFile
}

# パラメータ変換
## エンジン・話者・スタイル

$baseUrl = $null
if ($speaker -Like "四国めたん*") {
    $baseUrl = $VOICEVOX_URL
    $speaker_param = 0
}
elseif ($speaker -Like "ずんだもん*") {
    $baseUrl = $VOICEVOX_URL
    $speaker_param = 1
}
elseif ($speaker -Like "つくよみちゃん*") {
    $baseUrl = $COEIROINK_URL
    $speaker_param = 0
}
else {
    Write-Log("VOICEVOXの場合、話者名(≠レイヤー名）を「四国めたん」か「ずんだもん」で始めてください。COEIROINKの場合、「つくよみちゃん」で始めてください")
    return
}

# VOICEVOXのスタイル設定
if ($baseUrl -eq $VOICEVOX_URL) {
    switch -Wildcard ($speaker) {
        '*あまあま*' {
            $speaker_param += 0 # do nothing
            break
        }
        '*ノーマル*' {
            $speaker_param += 2
            break
        }
        '*セクシー*' {
            $speaker_param += 4
            break
        }
        '*ツンツン*' {
            $speaker_param += 6
            break
        }
    }
}

## セリフ
if (-not $text) {
    Write-Log("１文字以上のテキストを入力してください")
    return
}
Add-Type -AssemblyName System.Web
$encoded_text = [System.Web.HttpUtility]::UrlEncode($text)

## 出力音声ファイル名
if (-not $output) {
    Write-Log("出力音声ファイル名を指定してください")
    return
}

# VOICEVOX 音声合成クエリ作成
[System.Console]::OutputEncoding = [System.Text.Encoding]::UTF8
try {
    $query = Invoke-RestMethod `
        -Method POST `
        -Uri "$baseUrl/audio_query?text=$encoded_text&speaker=$speaker_param"
}
catch {
    Write-Log($PSItem)
    return
}

# 調整パラメータをユーザ指定に置き換え
$query.speedScale         = $speedScale
$query.pitchScale         = $pitchScale
$query.intonationScale    = $intonationScale
$query.volumeScale        = $volumeScale
$query.prePhonemeLength   = $prePhonemeLength
$query.postPhonemeLength  = $postPhonemeLength
$query.outputSamplingRate = $outputSamplingRate
$query.outputStereo       = $outputStereo

$configured_query = ConvertTo-Json $query -Depth 8

# VOICEVOX 音声合成API実行
try {
    Invoke-RestMethod `
        -Method POST `
        -Uri "$baseUrl/synthesis?speaker=$speaker_param" `
        -ContentType "application/json" `
        -Body $configured_query `
        -OutFile $output
}
catch {
    Write-Log($PSItem)
    return
}
