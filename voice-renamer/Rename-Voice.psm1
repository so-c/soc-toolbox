function Rename-Voice {

    <#
    .SYNOPSIS
        VOICEROID2の出力するwavとtxtのファイル名にtxtファイル1行目冒頭（最長20文字）を追加し、文字コードをUTF8にする
    .PARAMETER folder
        wavとtxtを出力したフォルダ
    #>

    [CmdletBinding(SupportsShouldProcess)]
    Param(
        [Parameter(Mandatory,
            ValueFromPipeline)]
        $Folder,
        $Encoding = [System.Text.Encoding]::GetEncoding("shift_jis")
    )

    PROCESS {
        Get-ChildItem "$folder\*.wav" | ForEach-Object {
            $textFilePath = "$folder\$($_.BaseName).txt"
            $firstLine = Get-Content $textFilePath -Head 1 -Encoding $Encoding
            $suffix = $firstLine.Substring(0, [Math]::Min(20, $firstLine.Length))

            $content = Get-Content $textFilePath -Encoding $Encoding
            Set-Content $textFilePath $content -Encoding UTF8

            Rename-Item -Path $_ -NewName ('{0}_{1}.wav' -f $_.BaseName, $suffix) -WhatIf:$WhatIfPreference
            $newTextFileName = ('{0}_{1}.txt' -f $_.BaseName, $suffix)
            Rename-Item -Path $textFilePath -NewName $newTextFileName -WhatIf:$WhatIfPreference
        }
    }
}
