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

    return (Split-Path $FilePath -Parent)
}

$id = 1
$pitagoes = @()
Push-Location ".\wav\虚音イフexVOICE\"
Get-ChildItem "*.wav" -Recurse | Sort-Object {
    $_.Directory,
    [regex]::Replace($_.BaseName, '\d+', { $args[0].Value.PadLeft(2) })
} | ForEach-Object {
    [PitagoeRecord]$pitagoe = [PitagoeRecord]::new($_)
    $pitagoe.FilePath =  (Split-Path (Split-Path $_.FullName -Parent) -Leaf) + "\" + (Split-Path $_.FullName -Leaf)
    $pitagoe.DisplayName = "{0:D3} {1}" -f $id++, $pitagoe.DisplayName.Trim()
    $pitagoe.Serifu = $pitagoe.Serifu
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
$destDir = "$workDir\wav\虚音イフexVOICE"
$csvFileName = "虚音イフexVOICE.csv"

$UTF8noBOM = [System.Text.UTF8Encoding]::new($false, $true)
$CsvContents = ($pitagoes | Sort-Object -Property DisplayName | ConvertTo-Csv -NoTypeInformation |
    ForEach-Object { $_.Replace('‹" ', "‹''") } |
    Select-Object -Skip 1)
[System.IO.File]::WriteAllLines("$destDir\$csvFileName", $CsvContents, $UTF8noBOM)

# Copy-Item $workDir\resource\character.ini $destDir -Force

Write-Host "${Split-Path $destDir -Leaf}フォルダに「$csvFileName」を作成しました"
Write-Host "${Split-Path $destDir -Leaf}フォルダを好きな位置・名前に変更して、ぴた声アプリに追加してください"
