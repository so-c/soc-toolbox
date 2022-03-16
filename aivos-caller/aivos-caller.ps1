Param(
    [string]$speaker,
    $text,
    $output
)

$settings = Get-Content $PSScriptRoot\settings.json | ConvertFrom-Json
Add-Type -Path $settings.path

$TTS = [AI.Talk.Editor.Api.TtsControl]::new()

if ($TTS.GetAvailableHostNames().Length -eq 0) {
    Write-Error "A.I.VOICE Editorが未インストールです" -ErrorAction Stop
}

try {
    if (-not $TTS.IsInitialized) {
        $TTS.Initialize(($TTS.GetAvailableHostNames()[0])) # 冪等なら過剰防御
    }
}
catch {
    Write-Error "A.I.Editor APIの初期化に失敗しました。" -ErrorAction Stop # 発生条件がよくわからない
}

if ($TTS.Status -eq [AI.Talk.Editor.Api.HostStatus]::NotRunning) {
    Write-Error "起動中のA.I.VOICE Editorが見つかりません。起動後に再実行してください。" -ErrorAction Stop
}

try {
    $TTS.Connect()
} catch {
    Write-Error "A.I.VOICE Editorと接続できませんでした。" -ErrorAction Stop
}

try {
    $TTS.TextEditMode = [AI.Talk.Editor.Api.TextEditMode]::List

    $i = 0
    try {
        $TTS.AddListItem($speaker, $text)
        while ($True) {
          $TTS.SetListSelectionIndex($i)
          $i++
        }
    }
    catch [InvalidOperationException] {
        # Listの行数を取得するAPIがないので
        # エラーを握りつぶす
    }

    $TTS.SaveAudioToFile($output)
}
catch {
    Write-Error "何かしらのエラーが発生しました。"
}
finally {
    $TTS.Disconnect();
}
