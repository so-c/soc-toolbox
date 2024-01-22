Param(
    [Parameter(Mandatory=$true)]
    [string]$number
)

function Get-VoicePaths {
    param(
        [Parameter(Mandatory=$true)]
        [string]$number
    )

    $baseFolderPath = "$PSScriptRoot\..\wav\Sample_voice_$number"

    $folders = @("free", "for500", "for1000")
    $result = ""

    foreach ($folder in $folders) {
        $folderPath = "$baseFolderPath`_$folder"
       
        $paths = Get-WavPathAsString($folderPath)

        $result += "$paths`r`n"
    }

    return $result
}

function Get-WavPathAsString {
    param(
        [Parameter(Mandatory=$true)]
        [string]$plan
    )

    $result = @()

    $files = (Get-ChildItem "$plan\*.wav")
    foreach ($f in $files) {
        $path = ((Resolve-Path $f.FullName -Relative).Substring(6) -replace '\\', '\\')
        $result += $path
    }

    return $result -join "`r`n"
}

Get-VoicePaths $number | Set-Clipboard


