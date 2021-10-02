Param(
    [switch]$Expand
)
# usage: 下記のように配置して実行
# .\
#   + tuinavo-list-generator.ps1
#   + zip-archives\
#       + [a-z0-9]+_Sample_voice_[0-9]{2}_wav_.zip
$workDir = $PSScriptRoot

. "$workDir\lib\Expand-MacZip.ps1"
. "$workDir\lib\PitagoeRecord.ps1"

if ($Expand) {
    if (Test-Path $workDir\wav) {
        Get-ChildItem $workDir\wav\* -Recurse |
        ForEach-Object {
            if ($_.FullName.Contains("第5回") -or $_.FullName.Contains("第8回") -or $_.FullName.Contains("第21回")) {
                
            } else {
                Remove-Item $_.FullName -Recurse -Force -Confirm:$false
            }
        }
    }
    else {
        New-Item $workDir\wav -ItemType Directory > $null
    }
    Get-ChildItem $workDir\zip-archives\*.zip | ForEach-Object {
        Expand-MacZip($_.FullName)
    }
}

$pitagoes = @()
Get-ChildItem "$workDir\wav\*.wav" -Recurse | ForEach-Object {
    [PitagoeRecord]$pitagoe = [PitagoeRecord]::new($_)
    $pitagoes += $pitagoe
}

$pitagoes | ConvertTo-Csv -NoTypeInformation | Select-Object -Skip 1 |
Set-Content "$workDir\wav\ついなちゃんサンプルボイス.csv" -Encoding UTF8
