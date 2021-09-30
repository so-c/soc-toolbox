# usage: 下記のように配置して実行
# .\
#   + tuinavo-list-generator.ps1
#   + zip-archives\
#       + [a-z0-9]+_Sample_voice_[0-9]{2}_wav_.zip
Push-Location
Set-Location $PSScriptRoot

if (Test-Path .\wav) {
    Remove-Item .\wav -Force -Confirm:$false -Recurse
}
New-Item .\wav -ItemType Directory > $null

. .\lib\Expand-MacZip.ps1
Get-ChildItem .\zip-archives\*.zip | ForEach-Object {
    Expand-MacZip($_.FullName)
}

class PitagoeRecord {
    $FilePath
    [string]$DisplayName
    [string]$Serifu
    [string]$Yomigana
    [string]$Category

    PitagoeRecord(
        $f,
        [string]$dn,
        [string]$s,
        [string]$y,
        [string]$c
    ) {
        $this.FilePath = $f
        $this.DisplayName = $dn
        $this.Serifu = $s
        $this.Yomigana = $y
        $this.Category = $c
    }
}

Get-ChildItem '.\wav\*.wav' -Recurse | ForEach-Object {

    $displayName = if ($_.BaseName.StartsWith('116 ')) {
        ($_.BaseName -replace '116 ', '')
    }
    else {
        $_.BaseName
    }

    [PitagoeRecord]$pitagoe = [PitagoeRecord]::new(
        (Resolve-Path $_.FullName -Relative),
        $displayName,
        "",
        "",
        $tmp.Directory.Name
    )
    # $pitagoe
}

# ファイル名置換は止めて表示名だけ置換する
# ファイル名に使えない文字があるので（例：'/'）

$replaceTable = @{}
$replaceTable.Add('&#x2c7;', 'ˇ')
$replaceTable.Add('&#x2661;', '♡')
$replaceTable.Add('&#x266b;', '♫')
$replaceTable.Add('&#x2665;', '♥')
$replaceTable.Add('&#xff5e;', '～') # Windows IMEで変換できる波ダッシュ
$replaceTable.Add('&#xff0d;', 'ー') # Windows IMEで「ダッシュ」で変換できる文字
$replaceTable.Add('&#x25aa;', '▪')
$replaceTable.Add('&#x2042;', '⁂')

foreach ($key in $replaceTable.keys) {
    Get-ChildItem .\wav\ -Recurse -Include *.wav |
        Rename-Item -NewName { $_.name -replace $key, $replaceTable[$key] }
}

Pop-Location
