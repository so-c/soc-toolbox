Param(
    [switch]$NoExpand
)
# usage: 下記のように配置して実行
# .\
#   + sakivo-list-generator.ps1
#   + zip\
#       + c4c81a16_Saki_Sample_voice_001_free.zip
$WorkDir = $PSScriptRoot
$LibDir = "$WorkDir\..\tuinavo\lib"
. $LibDir\PitagoeRecord.ps1

$DestDir = "$WorkDir\wav"
$csvFileName = "咲ちゃん セリフ集.csv"

function Expand-SampeZips {
    [CmdletBinding()]
    param (
        $WorkDir
    )
    # 個別にアドホックな処理が必要ならここで
    
    Get-ChildItem $WorkDir\zip\*.zip | ForEach-Object {
        $DirName = $_.BaseName -replace "^[a-z0-9]{8}_", ""
        New-Item ".\wav\$DirName" -ItemType Directory > $null
        $DirPath = (Resolve-Path ".\wav\$DirName").Path

        $Archive = [System.IO.Compression.ZipFile]::OpenRead($_.FullName)
        $Archive.Entries | Where-Object { $_.Name -like "*.wav" } | ForEach-Object {
            $NewName = (Rename-Entry $_.Name)
            [System.IO.Compression.ZipFileExtensions]::ExtractToFile($_, "$DirPath\$NewName", $true)
        }
    }
}

function Rename-Entry {
    [CmdletBinding()]
    param (
        $Name
    )

    $ret = $_.Name.Normalize() -replace '/', '\'
    $ret = $ret -replace ':', '_'
    $ret = $ret -replace '!\?', '！？' # !？[半角・全角]は表示が乱れるのでペアで置換    

    return $ret

}

######## ここからmain相当 ########

if (-not $NoExpand) {
    Expand-SampeZips $WorkDir
}

[PitagoeRecord]::newPitagoeList("$DestDir\")

# ぴた声アプリが表示名ではなくCSVでの登場順に表示するのでソートを挟む
# XXX：下記対応が不完全
# ・必ず引用符がつく
#   → ※マニュアルに規定なし。動いているように見える
# ・文字列の引用符はエスケープされて "" になる
#   → "" のまま表示されてしまうのでデータパッチ
# ・1行目に空行
#   → スキップする
$UTF8noBOM = [System.Text.UTF8Encoding]::new($false, $true)
$CsvContents = ($pitagoes | Sort-Object -Property DisplayName | ConvertTo-Csv -NoTypeInformation |
    ForEach-Object { $_.Replace('‹" ', "‹''") } |
    Select-Object -Skip 1)
[System.IO.File]::WriteAllLines("$destDir\$csvFileName", $CsvContents, $UTF8noBOM)

Copy-Item $workDir\resource\character.ini $destDir -Force

Write-Host "${Split-Path $destDir -Leaf}フォルダに「$csvFileName」を作成しました"
Write-Host "${Split-Path $destDir -Leaf}フォルダを好きな位置・名前に変更して、ぴた声アプリに追加してください"
