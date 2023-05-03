Param(
    [switch]$NoExpand
)

# usage: 下記のように配置して実行
#        zipファイルをwavフォルダに展開済みの場合、
#        -noExpandオプションをつけてください
# .\
#   + tuinavo-list-generator.ps1
#   + zip\
#     + abcd1234_Sample_voice_050.zip

$workDir = $PSScriptRoot
. "$workDir\lib\Expand-MacZip.ps1"
. "$workDir\lib\PitagoeRecord.ps1"
. "$workDir\lib\Rename-SVCFFolders.ps1"
$destDir = "$workDir\wav"
$csvFileName = "ついなちゃん セリフ集.csv"

function Expand-SampeZips {
    if (Test-Path $destDir) {
        Get-ChildItem $destDir -Recurse |
        ForEach-Object {
            if ($_.FullName -match '第(5|8|21)回') {
                # zipエラーで展開できないので同期しない
            }
            if ($_.FullName -match "【超神社CF】ニコ動公認☆ついなちゃん特典ボイス") {
                # Google DriveにフォルダなしでWAVファイル配布だった
                # ・フォルダ名はこちらで設計
                # ・削除しない
            }
            elseif ($_.Name -eq "thumbnail.png") {
                # zip外から持ってくるファイルなので同期しない
            }
            else {
                Remove-Item $_.FullName -Recurse -Force -Confirm:$false
            }
        }
    }
    else {
        New-Item $destDir -ItemType Directory > $null
    }

    Get-ChildItem $workDir\zip\*.zip | ForEach-Object {
        Expand-MacZip($_.FullName)
    }
}

if (-not $NoExpand) {
    Write-Host "zipフォルダ内のzipファイルを展開します"
    Expand-SampeZips
    Write-Host "展開を完了しました"
    Write-Host "第5, 8, 21回は展開できません。未展開なら手動で展開したあと、-NoExpandオプションをつけて再実行してください"

    Rename-SVCFFolders $destDir
}

$pitagoes = [PitagoeRecord]::newPitagoeList("$destDir")

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
