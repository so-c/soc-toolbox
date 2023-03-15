$destDir = "$workDir\ex"
$csvFileName = "ついなちゃん exVOICE.csv"

$pitagoes = [PitagoeRecordExvo]::newPitagoeList("$destDir\")

# ぴた声アプリが表示名ではなくCSVでの登場順に表示するのでソートを挟む
# XXX：下記対応が不完全
# ・必ず引用符がつく
#   → ※マニュアルに規定なし。動いているように見える
# ・文字列の引用符はエスケープされて "" になる
#   → "" のまま表示されてしまうのでデータパッチ
$UTF8noBOM = [System.Text.UTF8Encoding]::new($false, $true)
$CsvContents = ($pitagoes | Sort-Object -Property DisplayName | ConvertTo-Csv -NoTypeInformation |
    ForEach-Object { $_.Replace('‹" ', "‹''") } |
    Select-Object -Skip 1)
[System.IO.File]::WriteAllLines("$destDir\$csvFileName", $CsvContents, $UTF8noBOM)
Copy-Item $workDir\resource\character.ini $destDir -Force
$folderName = (Split-Path $destDir -Leaf)
Write-Host "${folderName}フォルダに「$csvFileName」を作成しました"
Write-Host "${folderName}フォルダを好きな位置・名前に変更して、ぴた声アプリに追加してください"
