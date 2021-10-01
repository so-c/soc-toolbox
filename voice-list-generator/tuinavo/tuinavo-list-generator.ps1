# usage: 下記のように配置して実行
# .\
#   + tuinavo-list-generator.ps1
#   + zip-archives\
#       + [a-z0-9]+_Sample_voice_[0-9]{2}_wav_.zip
$workDir = $PSScriptRoot

. "$workDir\lib\Expand-MacZip.ps1"
. "$workDir\lib\PitagoeRecord.ps1"

if (Test-Path $workDir\wav) {
    Remove-Item $workDir\wav\* -Force -Confirm:$false -Exclude *第5回*, *第8回*, *第21回* -Recurse
} else {
    New-Item $workDir\wav -ItemType Directory > $null
}
Get-ChildItem $workDir\zip-archives\*.zip | ForEach-Object {
    Expand-MacZip($_.FullName)
}

$pitagoes = @()
Get-ChildItem "$workDir\wav\*.wav" -Recurse | ForEach-Object {
    [PitagoeRecord]$pitagoe = [PitagoeRecord]::new($_)
    $pitagoes += $pitagoe
}

$pitagoes | ConvertTo-Csv -NoTypeInformation | Select-Object -Skip 1 |
    Set-Content "$workDir\wav\ついなちゃんサンプルボイス.csv" -Encoding UTF8

Pop-Location
