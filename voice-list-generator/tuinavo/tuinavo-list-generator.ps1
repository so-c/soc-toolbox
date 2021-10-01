# usage: 下記のように配置して実行
# .\
#   + tuinavo-list-generator.ps1
#   + zip-archives\
#       + [a-z0-9]+_Sample_voice_[0-9]{2}_wav_.zip
Push-Location
Set-Location $PSScriptRoot

. ".\lib\Expand-MacZip.ps1"
. ".\lib\PitagoeRecord.ps1"

if (Test-Path .\wav) {
    Remove-Item .\wav\* -Force -Confirm:$false -Exclude *第5回*,*第8回*,*第21回* -Recurse
} else {
    New-Item .\wav\ > $null
}
Get-ChildItem .\zip-archives\*.zip | ForEach-Object {
    Expand-MacZip($_.FullName)
}

$pitagoes = @()
Get-ChildItem '.\wav\*.wav' -Recurse | ForEach-Object {
    Push-Location
    Set-Location ".\wav\"
    [PitagoeRecord]$pitagoe = [PitagoeRecord]::new(
        (Resolve-Path $_.FullName -Relative),
        $_.BaseName,
        "",
        $_.Directory.Name
    )
    Pop-Location
    $pitagoes += $pitagoe
}

$pitagoes | ConvertTo-Csv -NoTypeInformation | Select-Object -Skip 1 |
    Set-Content ".\wav\ついなちゃんサンプルボイス.csv" -Encoding UTF8

Pop-Location
