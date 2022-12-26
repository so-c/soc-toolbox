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
        （ツヨゲリ）トォッ！ { "（キョウゲリ）トォッ！" }
        （ナカジャンプコウ）ソレッ！　{ "（チュウジャンプコウ）ソレッ！" }
        （ナカコウゲキ）エエィッ！　{ "（チュウコウゲキ）エエィッ！" }
        ヘン・・・ミ！ { "ヘン・・・シン！" }        
        カナマノモノカ、マショウノモノカ。ショウタイヲアラワセ・・・・・・！ { "ケショウノモノカ、マショウノモノカ。ショウタイヲアラワセ・・・・・・！" }
        サクラノキノシタニハシカバネカラダガウマッテイルノ、コレハシンジテイイコトナンダヨ { "サクラノキノシタニハシタイガウマッテイルノ、コレハシンジテイイコトナンダヨ" }
        ゴミバコヲソラニスルネ { "ゴミバコヲカラニスルネ" }
        オコッキロー！ { "オッキロー！" }
        マタバイグイシチャッタ・・・・・・ { "マタカイグイシチャッタ・・・・・・" }
        ユビキリゲンマン、ウソツイタラハリセンホンインーマス、ユビキッタ！ { "ユビキリゲンマン、ウソツイタラハリセンボンノーマス、ユビキッタ！" }
        ウｐヌシサン { "ウプヌシサン" }
        default { $yomigana }
    }

    return $yomigana
}

function Get-Category($id) {
    if ($id -le 60) {
        return "アクションボイス"
    }
    if ($id -le 85) {
        return "効果音"
    }
    if ($id -le 112) {
        return "ネタ系"
    }
    if ($id -le 136) {
        return "動画編集・PC系"
    }
    if ($id -le 267) {
        return "日常系"
    }
    if ($id -le 292) {
        return "笑い・泣き・怒り"
    }
    if ($id -le 300) {
        return "名前"
    }
    throw "$id のカテゴリが不明です"
}

$id = 1
$pitagoes = @()
Push-Location (Resolve-Path $exVoiceFolder)
Get-ChildItem "*.wav" -Recurse | Sort-Object {
    $_.Directory,
    [regex]::Replace($_.BaseName, '\d+', { $args[0].Value.PadLeft(2) })
} | ForEach-Object {
    [PitagoeRecord]$pitagoe = [PitagoeRecord]::new($_)
    $pitagoe.FilePath = (Resolve-Path $_ -Relative)
    $pitagoe.DisplayName = $pitagoe.DisplayName.Trim() -replace '^([0-9]{3})/', '$1_'
    $pitagoe.Serifu = $pitagoe.Serifu -replace '^[0-9]+/', ''

    if ($pitagoe.DisplayName -eq "055_Are/you/ready？") {
        $pitagoe.DisplayName = "055_Are you ready？"
        $pitagoe.Serifu = "Are you ready？"
    }

    $pitagoe.Yomigana = New-Yomigana($pitagoe.Serifu)
    $pitagoe.Category = Get-Category([int]($pitagoe.DisplayName -split '_')[0])
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
$csvFileName = (($destDir | Split-Path -Parent | Split-Path -Leaf) + ".csv")

$UTF8noBOM = [System.Text.UTF8Encoding]::new($false, $true)
$CsvContents = ($pitagoes | Sort-Object -Property DisplayName | ConvertTo-Csv -NoTypeInformation |
    ForEach-Object { $_.Replace('‹" ', "‹''") } |
    Select-Object -Skip 1)
[System.IO.File]::WriteAllLines("$destDir\$csvFileName", $CsvContents, $UTF8noBOM)
Copy-Item $workDir\character.ini $destDir -Force

Write-Host "$destDirフォルダに「$csvFileName」を作成しました"
