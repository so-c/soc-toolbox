Param(
    [String]
    $exVoiceFolder
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

    # アドホックな修正
    $yomigana = switch ($yomigana) {
        #（ツヨゲリ）トォッ！ { "（キョウゲリ）トォッ！" }
        default { $yomigana }
    }

    return $yomigana
}

function Get-Category() {
    return "おまけボイス"    
}

$pitagoes = @()
Push-Location (Resolve-Path $exVoiceFolder)
Get-ChildItem "*.wav" -Recurse | Sort-Object {
    $_.Directory,
    [regex]::Replace($_.BaseName, '\d+', { $args[0].Value.PadLeft(2) })
} | ForEach-Object {
    [PitagoeRecord]$pitagoe = [PitagoeRecord]::new($_)
    $pitagoe.FilePath = (Resolve-Path $_ -Relative)
    $pitagoe.DisplayName = $pitagoe.DisplayName.Trim() -replace '^([0-9]{3})/', '$1_'
    $pitagoe.Serifu = $pitagoe.Serifu -replace '^[0-9]{3}/|_[0-9]{2}', ''
    $pitagoe.Yomigana = New-Yomigana($pitagoe.Serifu)

    # 例外対応
    if ($pitagoe.DisplayName -eq "041_フリモメン_0") {
        $pitagoe.DisplayName = "041_フリモメン_01"
        $pitagoe.Serifu = "フリモメン"
        $pitagoe.Yomigana = "フリモメン"
    }

    $pitagoe.Yomigana = ($pitagoe.Yomigana -replace 'miki(サン|チャン)', 'ミキ$1')
    $pitagoe.Yomigana = ($pitagoe.Yomigana -replace 'センフユ(サン|チャン)', 'チフユ$1')

    $pitagoe.Category = Get-Category
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
$destDir = (Resolve-Path $exVoiceFolder)
$csvFileName = (($destDir | Split-Path -Leaf) + ".csv")

$UTF8noBOM = [System.Text.UTF8Encoding]::new($false, $true)
$CsvContents = ($pitagoes | Sort-Object -Property DisplayName | ConvertTo-Csv -NoTypeInformation |
    ForEach-Object { $_.Replace('‹" ', "‹''") } |
    Select-Object -Skip 1)
[System.IO.File]::WriteAllLines("$destDir\$csvFileName", $CsvContents, $UTF8noBOM)
Copy-Item $workDir\character.ini $destDir -Force

Write-Host "$destDirフォルダに「$csvFileName」を作成しました"
