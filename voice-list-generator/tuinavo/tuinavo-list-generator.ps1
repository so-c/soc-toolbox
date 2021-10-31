Param(
    [Parameter(Mandatory)]
    [ValidateSet("Sample", "Ex")]
    [String[]]
    $Voice,
    [switch]$NoExpand
)
# usage: 下記のように配置して実行
# .\
#   + tuinavo-list-generator.ps1
#   + zip\
#       + abcd1234_Sample_voice_050.zip
$workDir = $PSScriptRoot
. "$workDir\lib\Expand-MacZip.ps1"
. "$workDir\lib\PitagoeRecord.ps1"
. "$workDir\lib\PitagoeRecordExvo.ps1"

$destDir
$csvFileName

switch ($Voice) {
    "Sample" {
        $destDir = "$workDir\wav"
        $csvFileName = "ついなちゃん セリフ集.csv"
    }
    "Ex" {
        $destDir = "$workDir\ex"
        $csvFileName = "ついなちゃん exVOICE.csv"
    }
    Default {
        Write-Error "到達不能コード"
    }
}

if ($Voice -eq "Sample" -and -not $NoExpand) {
    Write-Host "zipフォルダ内のzipファイルを展開します"
    if (Test-Path $destDir) {
        Get-ChildItem $destDir\* -Recurse |
        ForEach-Object {
            if ($_.FullName.Contains("第5回") -or $_.FullName.Contains("第8回") -or $_.FullName.Contains("第21回")) {
                # zipエラーで展開できないので同期しない
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
    
    Write-Host "展開を完了しました"
    Write-Host "第5, 8, 21回は展開できないので、まだなら手動で展開したあと、実行し直してください"
    Write-Host "-NoExpandオプションをつけると再展開しないので気持ち速くなります"
}

if ($Voice -eq "SampleCF" -and -not $NoExpand) {
    Write-Host 'SynthV CFリターンとして配信されたzipファイルのうち、第43～52回はFantiaでの配布とフォルダ構成が違うのでFantiaの構成に合わせます'
    # TODO 1階層上げる
    # TODO 空フォルダ"wav_SynthesizerV CF向け限定ボイス（5000円プラン以上向け）"が作成されるので削除する
}

$pitagoes = switch ($Voice) {
    "Sample" { [PitagoeRecord]::newPitagoeList("$destDir\") }
    "Ex" { [PitagoeRecordExvo]::newPitagoeList("$destDir\") }
    Default {}
}

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
$UTF8noBOM = [System.Text.UTF8Encoding]::new($false, $true)
$CsvContents = ($pitagoes | Sort-Object -Property DisplayName | ConvertTo-Csv -NoTypeInformation |
ForEach-Object { $_.Replace('‹" ', "‹''") } |
Select-Object -Skip 1)
[System.IO.File]::WriteAllLines("$destDir\$csvFileName", $CsvContents, $UTF8noBOM)

Copy-Item $workDir\resource\character.ini $destDir -Force

Write-Host "${Split-Path $destDir -Leaf}フォルダに「$csvFileName」を作成しました"
Write-Host "${Split-Path $destDir -Leaf}フォルダを好きな位置・名前に変更して、ぴた声アプリに追加してください"
