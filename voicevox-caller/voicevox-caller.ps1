Param($text, 
    [string]$speaker, $output,
    # パラメータの意味は VOICEVOXを起動して
    # http://127.0.0.1:50021/docs にアクセスして確認
    $speedScale         = 1.0,
    $pitchScale         = 0.0,
    $intonationScale    = 1.0,
    $volumeScale        = 1.0,
    $prePhonemeLength   = 0.1,
    $postPhonemeLength  = 0.1,
    $outputSamplingRate = 24000,
    $outputStereo       = $false
)

$logFile = "$PSScriptRoot\last_error.txt"
function Write-Log($msg) {
    $date = Get-Date -Format "yyyy/MM/dd HH:mm:ss"
    Write-Error "$date`t$msg" 2>&1 > $logFile
}

# 必須パラメータチェック
if (-not $text) {
    Write-Log("１文字以上のテキストを入力してください")
    return
}
Add-Type -AssemblyName System.Web
$encoded_text = [System.Web.HttpUtility]::UrlEncode($text)

if ($speaker -Like "四国めたん*") {
    $speaker_param = 0
} elseif ($speaker -Like "ずんだもん*") {
    $speaker_param = 1
} else {
    Write-Log("話者名(≠レイヤー名）を「四国めたん」か「ずんだもん」で始めてください")
    return
}

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

if (-not $output) {
    Write-Log("出力先ファイル名を指定してください")
    return
}

[System.Console]::OutputEncoding = [System.Text.Encoding]::UTF8

# VOICEVOX 音声合成クエリ作成
try {
    $query = Invoke-RestMethod `
        -Method POST `
        -Uri "http://127.0.0.1:50021/audio_query?text=$encoded_text&speaker=$speaker_param"
} catch {
    Write-Log($PSItem)
    return
}

# 調整パラメータをユーザ指定に置き換え
$query.speedScale = $speedScale
$query.pitchScale = $pitchScale
$query.intonationScale = $intonationScale
$query.volumeScale        = $volumeScale
$query.prePhonemeLength   = $prePhonemeLength
$query.postPhonemeLength  = $postPhonemeLength
$query.outputSamplingRate = $outputSamplingRate
$query.outputStereo       = $outputStereo

$configured_query = ConvertTo-Json $query -Depth 8

# VOICEVOX 音声合成API実行
try  {
    Invoke-RestMethod `
        -Method POST `
        -Uri http://127.0.0.1:50021/synthesis?speaker=$speaker_param `
        -ContentType "application/json" `
        -Body $configured_query `
        -OutFile $output
} catch {
    Write-Log($PSItem)
    return
}
