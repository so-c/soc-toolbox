Param(
    [Parameter(Mandatory)]$version
)

$tuinavo = "tuinavo-list-generator-$version"
$voivoxCaller = "voicecox-caller-$version"
$aivosUserDef = "aivos-userdef-$version"

$PSScriptRoot

if (-not (Test-Path $PSScriptRoot\release)) {
    New-Item $PSScriptRoot\release -ItemType Directory > $null
}

Remove-Item $PSScriptRoot\release\* -Recurse -Force
New-Item "$PSScriptRoot\release\$tuinavo" -ItemType Directory > $null

Copy-Item $PSScriptRoot\voice-list-generator\tuinavo\*.* $PSScriptRoot\release\$tuinavo\
Copy-Item $PSScriptRoot\voice-list-generator\tuinavo\lib $PSScriptRoot\release\$tuinavo\ -Recurse
Copy-Item $PSScriptRoot\voice-list-generator\tuinavo\resource $PSScriptRoot\release\$tuinavo\ -Recurse
New-Item -Path $PSScriptRoot\release\$tuinavo\ex, `
               $PSScriptRoot\release\$tuinavo\wav, `
               $PSScriptRoot\release\$tuinavo\zip `
         -ItemType Directory >$null
Compress-Archive -Path $PSScriptRoot\release\$tuinavo -DestinationPath $PSScriptRoot\release\$tuinavo.zip

Compress-Archive -Path $PSScriptRoot\voicevox-caller -DestinationPath $PSScriptRoot\release\$voivoxCaller.zip
Compress-Archive -Path $PSScriptRoot\aivos-userdef -DestinationPath $PSScriptRoot\release\$aivosUserDef.zip
