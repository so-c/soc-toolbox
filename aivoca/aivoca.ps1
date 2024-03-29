﻿Param(
    [string]$speaker,
    $text,
    $output
)

Function Get-TTS($Path) {
    $Settings = Get-Content $PAth\settings.json | ConvertFrom-Json
    Add-Type -Path $settings.path
    
    return [AI.Talk.Editor.Api.TtsControl]::new()
}

Function Connect-TTS($TTS) {
    if ($TTS.GetAvailableHostNames().Length -eq 0) {
        Write-Error "$(Get-Date -Format "yyyy-MM-dd hh:mm:ss") A.I.VOICE Editorが未インストールです" -ErrorAction Stop
    }
    
    try {
        if (-not $TTS.IsInitialized) {
            $TTS.Initialize(($TTS.GetAvailableHostNames()[0])) # 冪等なら過剰防御
        }
    }
    catch {
        Write-Error "$(Get-Date -Format "yyyy-MM-dd hh:mm:ss")`tA.I.Editor APIの初期化に失敗しました。" -ErrorAction Stop # 発生条件がよくわからない
    }
    
    if ($TTS.Status -eq [AI.Talk.Editor.Api.HostStatus]::NotRunning) {
        Write-Error "$(Get-Date -Format "yyyy-MM-dd hh:mm:ss")`t起動中のA.I.VOICE Editorが見つかりません。起動後に再実行してください。" -ErrorAction Stop
    }
    
    try {
        $TTS.Connect()
    }
    catch {
        Write-Error "$(Get-Date -Format "yyyy-MM-dd hh:mm:ss")`tA.I.VOICE Editorと接続できませんでした。" -ErrorAction Stop
    }
}

Function Add-ItemToLast($TTS, $speaker, $text) {
    if ($text -eq '') {
        Write-Error "$(Get-Date -Format "yyyy-MM-dd hh:mm:ss")`tコメントには1文字以上のテキストを設定してください" -ErrorAction Stop
    }

    $TTS.TextEditMode = [AI.Talk.Editor.Api.TextEditMode]::List
 
    $TTS.AddListItem($speaker, $text)
    $TTS.SetListSelectionIndex($TTS.GetListCount() - 1)
}

try {
    $TTS = Get-TTS $PSScriptRoot
    Connect-TTS $TTS

    Add-ItemToLast -TTS $TTS -speaker $speaker -text $text
    $TTS.SaveAudioToFile($output)
}
catch {
    $_ 2>&1 >> $PSScriptRoot\error_log.txt
}
finally {
    $TTS.Disconnect();
}
