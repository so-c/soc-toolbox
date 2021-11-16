Param(
)

$workDir = $PSScriptRoot
Set-Location $workDir

# XXX: 共通スクリプトがtuinavoに入っている
. "..\tuinavo\lib\PitagoeRecord.ps1"

function New-Yomigana($displayName) {
    $yomigana = [Windows.Globalization.JapanesePhoneticAnalyzer, Windows.Globalization, ContentType = WindowsRuntime]::GetWords($displayName)
    $yomigana = $yomigana.YomiText -join ''
    Add-Type -AssemblyName "Microsoft.VisualBasic"
    $yomigana = [Microsoft.VisualBasic.Strings]::StrConv($yomigana, [Microsoft.VisualBasic.VbStrConv]::Katakana)
    return $yomigana
}

function Get-Category($FilePath) {
    if ($FilePath -eq '') {
        Write-Error 'exVOICEフォルダが見つかりませんでした'
        return
    }

    $c = Split-Path $FilePath -Parent

    if ($c.EndsWith('exVOICE')) {
        return Split-Path $FilePath -Leaf
        break
    }
    else {
        Get-Category($c)
    }
}

$id = 1
$pitagoes = @()
Push-Location ".\wav\紲星あかり exVOICE Vol.1"
Get-ChildItem "*.wav" -Recurse | Sort-Object {
    $_.Directory,
    [regex]::Replace($_.BaseName, '\d+', { $args[0].Value.PadLeft(2) })
} | ForEach-Object {
    [PitagoeRecord]$pitagoe = [PitagoeRecord]::new($_)
    $pitagoe.FilePath = (Resolve-Path $_ -Relative)
    $pitagoe.DisplayName = "{0:D4} {1}" -f $id++, $pitagoe.DisplayName.Trim()
    $pitagoe.Serifu = $pitagoe.Serifu -replace '[0-9]+$', ''
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
$destDir = "$workDir\wav\紲星あかり exVOICE Vol.1"
$csvFileName = "紲星あかりexVOICE Vol.1.csv"

$UTF8noBOM = [System.Text.UTF8Encoding]::new($false, $true)
$CsvContents = ($pitagoes | Sort-Object -Property DisplayName | ConvertTo-Csv -NoTypeInformation |
    ForEach-Object { $_.Replace('‹" ', "‹''") } |
    Select-Object -Skip 1)
[System.IO.File]::WriteAllLines("$destDir\$csvFileName", $CsvContents, $UTF8noBOM)

# Copy-Item $workDir\resource\character.ini $destDir -Force

Write-Host "${Split-Path $destDir -Leaf}フォルダに「$csvFileName」を作成しました"
Write-Host "${Split-Path $destDir -Leaf}フォルダを好きな位置・名前に変更して、ぴた声アプリに追加してください"
