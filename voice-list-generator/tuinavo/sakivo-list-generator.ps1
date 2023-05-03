Param(
    [switch]$NoExpand
)

# usage: 下記のように配置して実行
# .\
#   + sakivo-list-generator.ps1
#   + zip\
#       + c4c81a16_Saki_Sample_voice_001_free.zip
$WorkDir = $PSScriptRoot
. $WorkDir\lib\PitagoeRecord.ps1
$DestDir = "$WorkDir\Saki_wav"

function Expand-SampeZips {
    [CmdletBinding()]
    param (
        $WorkDir
    )
    
    Add-Type -AssemblyName System.IO.Compression.FileSystem        
    Get-ChildItem $WorkDir\Saki_zip\*.zip | ForEach-Object {
        $DirPath = New-Directory $_

        $Archive = [System.IO.Compression.ZipFile]::OpenRead($_.FullName)
        $Archive.Entries | Where-Object { $_.Name -like "*.wav" } | ForEach-Object {
            $NewName = (Rename-Entry $_.Name)
            [System.IO.Compression.ZipFileExtensions]::ExtractToFile($_, "$DirPath\$NewName", $true)
        }
    }
}

function New-Directory {
    # Zipファイルの名前に基づいて展開先のディレクトリを作る
    [CmdletBinding()]
    param (
        $ZipFile
    )

    $DirName = $ZipFile.BaseName -replace "^[a-z0-9]{8}_", ""
    New-Item "$DestDir\$DirName" -ItemType Directory > $null
    $DirPath = "$DestDir\$DirName"

    return $DirPath
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

function Clear-Destination {
    if (Test-Path $DestDir) {
        Get-ChildItem $DestDir\* -Recurse | 
        Where-Object { -not (($_.Name -eq "thumbnail.png") -or ($_.FullName -like "*\【超神社CF】ニコ動公認☆咲ちゃん特典ボイス*")) } | 
        ForEach-Object {
            Remove-Item $_.FullName -Recurse -Force -Confirm:$false
        }
    }
    else {
        New-Item $DestDir -ItemType Directory > $null
    }
}

######## ここからmain相当 ########

if (-not $NoExpand) {
    Clear-Destination
    Expand-SampeZips $WorkDir
}

$Pitagoes = [PitagoeRecord]::newPitagoeList("$DestDir\")

# ぴた声アプリが表示名ではなくCSVでの登場順に表示するのでソートを挟む
# XXX：下記対応が不完全
# ・必ず引用符がつく
#   → ※マニュアルに規定なし。動いているように見える
# ・文字列の引用符はエスケープされて "" になる
#   → "" のまま表示されてしまうのでデータパッチ
# ・1行目に空行
#   → スキップする
$CsvFileName = "咲ちゃん セリフ集.csv"
$UTF8noBOM = [System.Text.UTF8Encoding]::new($false, $true)
$CsvContents = ($Pitagoes | Sort-Object -Property DisplayName | ConvertTo-Csv -NoTypeInformation |
    ForEach-Object { $_.Replace('‹" ', "‹''") } |
    Select-Object -Skip 1)
[System.IO.File]::WriteAllLines("$DestDir\$CsvFileName", $CsvContents, $UTF8noBOM)

Copy-Item $WorkDir\resource\Saki_character.ini -Destination "$DestDir\character.ini" -Force

Write-Host "${Split-Path $destDir -Leaf}フォルダに「$CsvFileName」を作成しました"
Write-Host "${Split-Path $destDir -Leaf}フォルダを好きな位置・名前に変更して、ぴた声アプリに追加してください"
