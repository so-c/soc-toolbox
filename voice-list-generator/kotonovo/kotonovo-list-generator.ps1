Param(
    [Parameter(Mandatory)]
    [ValidateSet("Akane", "Aoi")]
    [String]
    $Voice
)

# XXX: 共通スクリプトがtuinavoに入っている
. "..\tuinavo\lib\PitagoeRecord.ps1"

$KanjiName = @{
    "Akane" = "茜"
    "Aoi"   = "葵"
}

$workDir = $PSScriptRoot
Set-Location $workDir

function New-Yomigana($displayName) {
    $yomigana = [Windows.Globalization.JapanesePhoneticAnalyzer, Windows.Globalization, ContentType = WindowsRuntime]::GetWords($displayName)
    $yomigana = $yomigana.YomiText -join ''
    Add-Type -AssemblyName "Microsoft.VisualBasic"
    $yomigana = [Microsoft.VisualBasic.Strings]::StrConv($yomigana, [Microsoft.VisualBasic.VbStrConv]::Katakana)
    return $yomigana
}

$displayNumbers = (Get-Content $PSScriptRoot\resource\displayNumbers.json | ConvertFrom-Json)

$pitagoes = @()

Push-Location ".\wav\$($KanjiName[$Voice])・ぴた声登録用"
Get-ChildItem "..\琴葉茜・葵 exVOICE1\$($KanjiName[$Voice])\*.wav" -Recurse | ForEach-Object {
    [PitagoeRecord]$pitagoe = [PitagoeRecord]::new($_)
    $pitagoe.FilePath = (Resolve-Path $_ -Relative)
    $id = $displayNumbers.$($pitagoe.FilePath)
    $pitagoe.DisplayName = "$id $($pitagoe.DisplayName.Trim())"
    $pitagoe.Yomigana = New-Yomigana($pitagoe.Serifu)
    $pitagoes += $pitagoe
}
Get-ChildItem "..\琴葉茜・葵 exVOICE1\共通\*.wav" -Recurse | ForEach-Object {
    [PitagoeRecord]$pitagoe = [PitagoeRecord]::new($_)
    $pitagoe.FilePath = (Resolve-Path $_ -Relative)
    $id = $displayNumbers.$($pitagoe.FilePath)
    $pitagoe.DisplayName = "$id $($pitagoe.DisplayName.Trim())"
    $pitagoe.Yomigana = New-Yomigana($pitagoe.Serifu)
    $pitagoes += $pitagoe
}
Get-ChildItem "..\琴葉茜・葵 exVOICE2\琴葉$($KanjiName[$Voice]) A.I.VOICE\*.wav" -Recurse | ForEach-Object {
    [PitagoeRecord]$pitagoe = [PitagoeRecord]::new($_)
    $pitagoe.FilePath = (Resolve-Path $_ -Relative)
    if ("Aoi".Equals($Voice)) {
        if ($pitagoe.FilePath.EndsWith("13_悪\18.wav")) {
            $pitagoe.DisplayName = $pitagoe.Serifu = "頂点は私たちだ！"
        }
        if ($pitagoe.FilePath.EndsWith("19_自慢\5.wav")) {
            $pitagoe.DisplayName = $pitagoe.Serifu = "どうだ！"
        }
        if ($pitagoe.FilePath.EndsWith("25_創作系\9.wav")) {
            $pitagoe.DisplayName = $pitagoe.Serifu = "それはお前が作るんだよ！！"
        }
        if ($pitagoe.FilePath.EndsWith("27_汎用型\32.wav")) {
            $pitagoe.DisplayName = $pitagoe.Serifu = "なぜ角を取らない！"
        }
        if ($pitagoe.FilePath.EndsWith("28_煽り\47.wav")) {
            $pitagoe.DisplayName = $pitagoe.Serifu = "みんな手を挙げてー！！"
        }
    }
    if ("Akane".Equals($Voice)) {
        if ($pitagoe.FilePath.EndsWith("10_謎\1.wav")) {
            $pitagoe.DisplayName = $pitagoe.Serifu = "なぞ…"
        }
        if ($pitagoe.FilePath.EndsWith("10_謎\2.wav")) {
            $pitagoe.DisplayName = $pitagoe.Serifu = "なんで…"
        }
        if ($pitagoe.FilePath.EndsWith("10_謎\3.wav")) {
            $pitagoe.DisplayName = $pitagoe.Serifu = "ハテ…"
        }
        if ($pitagoe.FilePath.EndsWith("10_謎\4.wav")) {
            $pitagoe.DisplayName = $pitagoe.Serifu = "な、なんで…"
        }
        if ($pitagoe.FilePath.EndsWith("10_謎\5.wav")) {
            $pitagoe.DisplayName = $pitagoe.Serifu = "な…"
        }
        if ($pitagoe.FilePath.EndsWith("10_謎\6.wav")) {
            $pitagoe.DisplayName = $pitagoe.Serifu = "ん～…"
        }
        if ($pitagoe.FilePath.EndsWith("10_謎\7.wav")) {
            $pitagoe.DisplayName = $pitagoe.Serifu = "ん～～～？"
        }
        if ($pitagoe.FilePath.EndsWith("25_創作系\1.wav")) {
            $pitagoe.DisplayName = $pitagoe.Serifu = "進捗どう？"
        }
        if ($pitagoe.FilePath.EndsWith("25_創作系\1-1 進捗どう？.wav")) {
            $pitagoe.DisplayName = $pitagoe.Serifu = "進捗どうですか？"
        }
        if ($pitagoe.FilePath.EndsWith("25_創作系\7.wav")) {
            $pitagoe.DisplayName = $pitagoe.Serifu = "もっと…もっと作るんやで！！！！"
        }
        if ($pitagoe.FilePath.EndsWith("27_汎用型\29.wav")) {
            $pitagoe.DisplayName = $pitagoe.Serifu = "閑話休題"
        }
        if ($pitagoe.FilePath.EndsWith("28_汎用型\36.wav")) {
            $pitagoe.DisplayName = $pitagoe.Serifu = "みんな～！"
        }
        if ($pitagoe.FilePath.EndsWith("28_汎用型\9.wav")) {
            $pitagoe.DisplayName = $pitagoe.Serifu = "ありがと～う！"
        }
        if ($pitagoe.FilePath.EndsWith("8_期待\5.wav")) {
            $pitagoe.DisplayName = $pitagoe.Serifu = "マジ！？"
        }
    }
    $dName = ($pitagoe.DisplayName -replace "[0-9]+(-[0-9])?").Trim()
    $id = $displayNumbers.$($pitagoe.FilePath)
    $pitagoe.DisplayName = "$id $dName"
    $pitagoe.Serifu = ($pitagoe.Serifu -replace "[0-9]+(-[0-9])?").Trim()
    $pitagoe.Yomigana = New-Yomigana($pitagoe.Serifu)
    $pitagoes += $pitagoe
}

Get-ChildItem "..\琴葉茜・葵 exVOICE3\$($KanjiName[$Voice])\*.wav" -Recurse | ForEach-Object {
    [PitagoeRecord]$pitagoe = [PitagoeRecord]::new($_)
    $pitagoe.FilePath = (Resolve-Path $_ -Relative)
    $id = $displayNumbers.$($pitagoe.FilePath)
    $pitagoe.DisplayName = "$id $($pitagoe.DisplayName.Trim())"
    $pitagoe.Yomigana = New-Yomigana($pitagoe.Serifu)
    $pitagoes += $pitagoe
}
Get-ChildItem "..\琴葉茜・葵 exVOICE3\共通\*.wav" -Recurse | ForEach-Object {
    [PitagoeRecord]$pitagoe = [PitagoeRecord]::new($_)
    $pitagoe.FilePath = (Resolve-Path $_ -Relative)
    $id = $displayNumbers.$($pitagoe.FilePath)
    $pitagoe.DisplayName = "$id $($pitagoe.DisplayName.Trim())"
    $pitagoe.Yomigana = New-Yomigana($pitagoe.Serifu)
    $pitagoes += $pitagoe
}
Pop-Location

# ぴた声アプリが表示名ではなくCSVでの登場順に表示するのでソートを挟む
# XXX：下記対応が不完全
# ・必ず引用符がつく
#   → ※マニュアルに規定なし。動いているように見える
# ・文字列の引用符はエスケープされて "" になる
#   → "" のまま表示されてしまうのでデータパッチ
# ・UTF8withBOMオンリー
#   → マニュアル上BOMなしだが読み込んでくれる
# ・1行目に空行
#   → スキップする
$destDir = "$workDir\wav\$($KanjiName[$Voice])・ぴた声登録用"
$csvFileName = "琴葉$($KanjiName[$Voice])exVOICE.csv"

$UTF8noBOM = [System.Text.UTF8Encoding]::new($false, $true)
$CsvContents = ($pitagoes | Sort-Object -Property DisplayName | ConvertTo-Csv -NoTypeInformation |
    ForEach-Object { $_.Replace('‹" ', "‹''") } |
    Select-Object -Skip 1)
[System.IO.File]::WriteAllLines("$destDir\$csvFileName", $CsvContents, $UTF8noBOM)

Copy-Item $workDir\resource\character.ini $destDir -Force

Write-Host "${Split-Path $destDir -Leaf}フォルダに「$csvFileName」を作成しました"
Write-Host "${Split-Path $destDir -Leaf}フォルダを好きな位置・名前に変更して、ぴた声アプリに追加してください"
