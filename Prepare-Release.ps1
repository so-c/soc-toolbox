﻿Param(
    [Parameter(Mandatory)]
    [ValidatePattern("^v[0-9]+\.[0-9]+\.[0-9]+.*$")]
    $version
)

if (-not (Test-Path $PSScriptRoot\release)) {
    New-Item $PSScriptRoot\release -ItemType Directory > $null
}
Remove-Item $PSScriptRoot\release\* -Recurse -Force

function Zip-Tuinavo($tuinavo) {
    # ついなボリストジェネレータ
    New-Item "$PSScriptRoot\release\$tuinavo" -ItemType Directory > $null

    Copy-Item $PSScriptRoot\voice-list-generator\tuinavo\*.* $PSScriptRoot\release\$tuinavo\
    Copy-Item $PSScriptRoot\voice-list-generator\tuinavo\lib $PSScriptRoot\release\$tuinavo\ -Recurse
    Copy-Item $PSScriptRoot\voice-list-generator\tuinavo\resource $PSScriptRoot\release\$tuinavo\ -Recurse
    Copy-Item $PSScriptRoot\voice-list-generator\tuinavo\omake $PSScriptRoot\release\$tuinavo\ -Recurse
    New-Item -Path $PSScriptRoot\release\$tuinavo\ex, `
        $PSScriptRoot\release\$tuinavo\wav, `
        $PSScriptRoot\release\$tuinavo\zip, `
        $PSScriptRoot\release\$tuinavo\Saki_wav, `
        $PSScriptRoot\release\$tuinavo\Saki_zip `
        -ItemType Directory >$null
    Copy-Item -Path $PSScriptRoot\README.md, $PSScriptRoot\LICENSE -Destination $PSScriptRoot\release\$tuinavo
    Compress-Archive -Path $PSScriptRoot\release\$tuinavo -DestinationPath $PSScriptRoot\release\$tuinavo.zip
}

$tuinavo = "tuinavo-list-generator-$version"
Zip-Tuinavo($tuinavo)

@("voivoca", "coeica") | ForEach-Object {
    $caller = "$_-$version"
    New-Item "$PSScriptRoot\release\$caller" -ItemType Directory > $null

    if (Test-Path $PSScriptRoot\$_\src\last_error.txt) {
        Remove-Item $PSScriptRoot\$_\src\last_error.txt
    }
    Copy-Item $PSScriptRoot\$_\src\*.* $PSScriptRoot\release\$caller\
    Copy-Item $PSScriptRoot\$_\src\functions -Recurse $PSScriptRoot\release\$caller\
    Copy-Item $PSScriptRoot\$_\create-rvls.bat $PSScriptRoot\release\$caller\
    Copy-Item $PSScriptRoot\$_\template -Recurse $PSScriptRoot\release\$caller\
    Copy-Item -Path $PSScriptRoot\README.md, $PSScriptRoot\LICENSE -Destination $PSScriptRoot\release\$caller
    Compress-Archive -Path $PSScriptRoot\release\$caller -DestinationPath $PSScriptRoot\release\$caller.zip
}

# aivos-userdef
$aivosUserDef = "aivos-userdef-$version"
Compress-Archive -Path $PSScriptRoot\aivos-userdef -DestinationPath $PSScriptRoot\release\$aivosUserDef.zip
Compress-Archive -Path $PSScriptRoot\README.md, $PSScriptRoot\LICENSE -Update -DestinationPath $PSScriptRoot\release\$aivosUserDef.zip

# voice-list-generatorセット
$vlgSet = "voice-list-generator-set-$version"

New-Item "$PSScriptRoot\release\$vlgSet" -ItemType Directory > $null
Copy-Item "$PSScriptRoot\voice-list-generator\akarivo" "$PSScriptRoot\release\$vlgSet\" -Recurse
Copy-Item "$PSScriptRoot\voice-list-generator\frimovo" "$PSScriptRoot\release\$vlgSet\" -Recurse
Copy-Item "$PSScriptRoot\voice-list-generator\sakivo" "$PSScriptRoot\release\$vlgSet\" -Recurse
Copy-Item "$PSScriptRoot\release\$tuinavo" "$PSScriptRoot\release\$vlgSet\" -Recurse
Rename-Item "$PSScriptRoot\release\$vlgSet\$tuinavo" "tuinavo"
Copy-Item -Path $PSScriptRoot\README.md, $PSScriptRoot\LICENSE -Destination $PSScriptRoot\release\$vlgSet
Compress-Archive -Path $PSScriptRoot\release\$vlgSet -DestinationPath $PSScriptRoot\release\$vlgSet.zip
