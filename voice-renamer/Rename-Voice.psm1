function Rename-Voice {

    <#
    .SYNOPSIS
        VOICEROID2の出力するwavとtxtのファイル名にtxtファイル1行目冒頭（最長20文字）を追加する
    .PARAMETER folder
        wavとtxtを出力したフォルダ
    #>

    [CmdletBinding(SupportsShouldProcess)]
    Param(
        [Parameter(Mandatory,
            ValueFromPipeline)]
        $folder
    )

    PROCESS {
        Get-ChildItem "$folder\*.wav" | ForEach-Object {
            $textFilePath = "$folder\$($_.BaseName).txt"
            $firstLine = Get-Content $textFilePath -Head 1
            $suffix = $firstLine.Substring(0, [Math]::Min(20, $firstLine.Length))

            Rename-Item -Path $_ -NewName ('{0}_{1}.wav' -f $_.BaseName, $suffix) -WhatIf:$WhatIfPreference
            Rename-Item -Path $textFilePath -NewName ('{0}_{1}.txt' -f $_.BaseName, $suffix) -WhatIf:$WhatIfPreference
        }
    }

}
