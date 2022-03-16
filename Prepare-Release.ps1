Param(
    [Parameter(Mandatory)]
    [ValidatePattern("^v[0-9]+\.[0-9]+\.[0-9]+\.[0-9]*$")]
    $version
)

$tuinavo = "tuinavo-list-generator-$version"
$voivoxCaller = "voicecox-caller-$version"
$aivosUserDef = "aivos-userdef-$version"

$PSScriptRoot

if (-not (Test-Path $PSScriptRoot\release)) {
    New-Item $PSScriptRoot\release -ItemType Directory > $null
}
Remove-Item $PSScriptRoot\release\* -Recurse -Force

# ついなボリストジェネレータ
New-Item "$PSScriptRoot\release\$tuinavo" -ItemType Directory > $null

Copy-Item $PSScriptRoot\voice-list-generator\tuinavo\*.* $PSScriptRoot\release\$tuinavo\
Copy-Item $PSScriptRoot\voice-list-generator\tuinavo\lib $PSScriptRoot\release\$tuinavo\ -Recurse
Copy-Item $PSScriptRoot\voice-list-generator\tuinavo\resource $PSScriptRoot\release\$tuinavo\ -Recurse
Copy-Item $PSScriptRoot\voice-list-generator\tuinavo\omake $PSScriptRoot\release\$tuinavo\ -Recurse
New-Item -Path $PSScriptRoot\release\$tuinavo\ex, `
               $PSScriptRoot\release\$tuinavo\wav, `
               $PSScriptRoot\release\$tuinavo\zip `
         -ItemType Directory >$null
Copy-Item -Path $PSScriptRoot\README.md, $PSScriptRoot\LICENSE -Destination $PSScriptRoot\release\$tuinavo
Compress-Archive -Path $PSScriptRoot\release\$tuinavo -DestinationPath $PSScriptRoot\release\$tuinavo.zip

# voicevox-caller
New-Item "$PSScriptRoot\release\$voivoxCaller" -ItemType Directory > $null

if(Test-Path $PSScriptRoot\voicevox-caller\src\last_error.txt) {
    Remove-Item $PSScriptRoot\voicevox-caller\src\last_error.txt
}
Copy-Item $PSScriptRoot\voicevox-caller\src\*.* $PSScriptRoot\release\$voivoxCaller\
Copy-Item $PSScriptRoot\voicevox-caller\src\functions -Recurse $PSScriptRoot\release\$voivoxCaller\
Copy-Item "$PSScriptRoot\voicevox-caller\VOICEVOX(PowerShell 5.x).rvls" $PSScriptRoot\release\$voivoxCaller\
Copy-Item -Path $PSScriptRoot\README.md, $PSScriptRoot\LICENSE -Destination $PSScriptRoot\release\$voivoxCaller
Compress-Archive -Path $PSScriptRoot\release\$voivoxCaller -DestinationPath $PSScriptRoot\release\$voivoxCaller.zip

# aivos-userdef
Compress-Archive -Path $PSScriptRoot\aivos-userdef -DestinationPath $PSScriptRoot\release\$aivosUserDef.zip
Compress-Archive -Path $PSScriptRoot\README.md, $PSScriptRoot\LICENSE -Update -DestinationPath $PSScriptRoot\release\$aivosUserDef.zip
