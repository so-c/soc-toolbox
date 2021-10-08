# usage: 下記のように配置して実行
# .\
#   + tuinavo-list-generator_exvp.ps1
#   + exVOICE\
#       + アクションボイス
#           + ...
$workDir = $PSScriptRoot

. "$workDir\lib\Expand-MacZip.ps1"
. "$workDir\lib\PitagoeRecord.ps1"

$pitagoes = [PitagoeRecord]::newPitagoeList("$workDir\exVOICE\")

# ぴた声アプリが表示名ではなくCSVでの登場順に表示するのでソートを挟む
# XXX：下記対応が不完全
# ・必ず引用符がつく
#   → ※マニュアルに規定なし。動いているように見える
# ・UTF8withBOMオンリー
#   → マニュアル上BOMなしだが読み込んでくれる
# ・1行目に空行
#   → スキップする
$pitagoes | Sort-Object -Property DisplayName | ConvertTo-Csv -NoTypeInformation |
Select-Object -Skip 1 | Set-Content "$workDir\exVOICE\ついなちゃん exVOICE.csv" -Encoding UTF8

Copy-Item $workDir\resource\character.ini $workDir\exVOICE -Force

Write-Host "exVOICEフォルダに「ついなちゃん exVOICE.csv」を作成しました"
Write-Host "exVOICEフォルダを好きな位置・名前に変更して、ぴた声アプリに追加してください"
