Param(
    [String]
    $exVoiceFolder
)

$workDir = $PSScriptRoot
Set-Location $workDir

# XXX: 共通スクリプトがtuinavoに入っている
. "$workDir\..\tuinavo\lib\PitagoeRecord.ps1"

function New-Yomigana($DisplayName) {
    $yomigana = [Windows.Globalization.JapanesePhoneticAnalyzer, Windows.Globalization, ContentType = WindowsRuntime]::GetWords($DisplayName)
    $yomigana = $yomigana.YomiText -join ''
    Add-Type -AssemblyName "Microsoft.VisualBasic"
    $yomigana = [Microsoft.VisualBasic.Strings]::StrConv($yomigana, [Microsoft.VisualBasic.VbStrConv]::Katakana)

    # A.I.VOICE紲星あかり特化部分
    $yomigana = switch ($yomigana) {
        イオリユミゲンクン { "イオリユヅルクン" }
        ユズキュン { "ユヅキュン" }
        ユズルン { "ユヅルン" }
        ユウキカオル（ユウキカオリ）サン { "ユウキカオリ（ユウキカオリ）サン" }
        シキオオカミエン（シキロウエン） { "シキロウエン（シキロウエン）" }
        シキオオモト（シキタイゲン） { "シキタイゲン（シキタイゲン）" }
        エンゲオン { "エンカオン" }
        default { $yomigana }
    }

    return $yomigana
}

function Get-DisplayName($DisplayName) {
    $ret = $DisplayName -replace '^[0-9\-]+(/|_)', ''
    $ret = $ret -replace '[1-4]_1', '1' 
    return $ret
}

function Get-Category($FilePath) {
    $c = Split-Path $FilePath -Parent
    return Split-Path $c -Leaf
}

$id = 1
$pitagoes = @()
Push-Location "$exVoiceFolder"
Get-ChildItem "*.wav" -Recurse | Sort-Object {
    $_.Directory,
    [regex]::Replace($_.BaseName, '\d+', { $args[0].Value.PadLeft(2) })
} | ForEach-Object {
    [PitagoeRecord]$pitagoe = [PitagoeRecord]::new($_)
    $pitagoe.FilePath = (Resolve-Path $_ -Relative)
    $pitagoe.DisplayName = "{0:D3} {1}" -f $id++, (Get-DisplayName($pitagoe.DisplayName.Trim()))
    $pitagoe.Serifu = $pitagoe.Serifu -replace '^[0-9\-]+(/|_)', ''
    $pitagoe.Yomigana = New-Yomigana($pitagoe.Serifu)
    
    $pitagoe.Category = Get-Category($pitagoe.FilePath)
    $pitagoes += $pitagoe
}
Pop-Location

# ぴた声アプリが表示名ではなくCSVでの登場順に表示するのでソートを挟む
# XXX：下記対応が不完全
# ・必ず引用符がつく
#   → ※マニュアルに規定なし。動いているように見える
# ・文字列の引用符はエスケープされて "" になる
#   → "" のまま表示されてしまうのでデータパッチ
# ・1行目に空行
#   → スキップする
$destDir = "$exVoiceFolder"
$csvFileName = "紲星あかり A.I.VOICE exVOICE Vol.1.csv"

$UTF8noBOM = [System.Text.UTF8Encoding]::new($false, $true)
$CsvContents = ($pitagoes | Sort-Object -Property DisplayName | ConvertTo-Csv -NoTypeInformation |
    ForEach-Object { $_.Replace('‹" ', "‹''") } |
    Select-Object -Skip 1)
[System.IO.File]::WriteAllLines("$destDir\$csvFileName", $CsvContents, $UTF8noBOM)

Copy-Item $workDir\character.ini $destDir -Force
Write-Host "$(Split-Path $destDir -Leaf)フォルダに「$csvFileName」,「character.ini」を作成しました"
