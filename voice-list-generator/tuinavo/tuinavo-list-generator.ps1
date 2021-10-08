Param(
    [switch]$NoExpand
)
# usage: 下記のように配置して実行
# .\
#   + tuinavo-list-generator.ps1
#   + zip\
#       + [a-z0-9]+_Sample_voice_[0-9]{2}_wav_.zip
$workDir = $PSScriptRoot

. "$workDir\lib\Expand-MacZip.ps1"
. "$workDir\lib\PitagoeRecord.ps1"

function NewPitagoeList {
    param (
        [string]$pathToWavs
    )

    if (-not $pathToWavs.EndsWith('\')) {
        $pathToWavs += '\'
    }

    $pitagoes = @()
    Get-ChildItem "${pathToWavs}*.wav" -Recurse | ForEach-Object {
        [PitagoeRecord]$pitagoe = [PitagoeRecord]::new($_)
        $pitagoes += $pitagoe
    }
    return $pitagoes
}

if (-not $NoExpand) {
    Write-Host "zipフォルダ内のzipファイルを展開します"
    if (Test-Path $workDir\wav) {
        Get-ChildItem $workDir\wav\* -Recurse |
        ForEach-Object {
            if ($_.FullName.Contains("第5回") -or $_.FullName.Contains("第8回") -or $_.FullName.Contains("第21回")) {
                # zipエラーで展開できないので同期しない
            } elseif ($_.Name -eq "thumbnail.png") {
                # zip外から持ってくるファイルなので同期しない
            }
            else {
                Remove-Item $_.FullName -Recurse -Force -Confirm:$false
            }
        }
    }
    else {
        New-Item $workDir\wav -ItemType Directory > $null
    }
    
    Get-ChildItem $workDir\zip\*.zip | ForEach-Object {
        Expand-MacZip($_.FullName)
    }
    
    Write-Host "展開を完了しました"
    Write-Host "第5, 8, 21回は展開できないので、まだなら手動で展開したあと、実行し直してください"
    Write-Host "-NoExpandオプションをつけると再展開しないので気持ち速くなります"
}

$pitagoes = NewPitagoeList("$workDir\wav\")

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
$pitagoes | Sort-Object -Property DisplayName | ConvertTo-Csv -NoTypeInformation |
ForEach-Object { $_.Replace('‹""', '‹"') } |
Select-Object -Skip 1 | Set-Content "$workDir\wav\ついなちゃんセリフ集.csv" -Encoding UTF8

Copy-Item $workDir\resource\character.ini $workDir\wav -Force

Write-Host "wavフォルダに「ついなちゃんセリフ集.csv」を作成しました"
Write-Host "wavフォルダを好きな位置・名前に変更して、ぴた声アプリに追加してください"
