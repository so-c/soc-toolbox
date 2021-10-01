# usage: 下記のように配置して実行
# .\
#   + tuinavo-list-generator.ps1
#   + zip-archives\
#       + [a-z0-9]+_Sample_voice_[0-9]{2}_wav_.zip
Push-Location
Set-Location $PSScriptRoot

if (Test-Path .\wav) {
    Remove-Item .\wav\* -Force -Confirm:$false -Exclude *第5回*,*第8回*,*第21回* -Recurse
}

. .\lib\Expand-MacZip.ps1
Get-ChildItem .\zip-archives\*.zip | ForEach-Object {
    Expand-MacZip($_.FullName)
}

class PitagoeRecord {
    $FilePath
    [string]$DisplayName
    [string]$Serifu
    [string]$Yomigana
    [string]$Category

    PitagoeRecord(
        $f,
        [string]$dn,
        [string]$s,
        [string]$y,
        [string]$c
    ) {
        $this.FilePath = $f
        $this.DisplayName = $dn
        $this.Serifu = $s
        $this.Yomigana = $y
        $this.Category = $c
    }
}

$pitagoes = @()
Get-ChildItem '.\wav\*.wav' -Recurse | ForEach-Object {

    $displayName = if ($_.BaseName.StartsWith('116 ')) {
        ($_.BaseName -replace '116 ', '')
    }
    else {
        $_.BaseName
    }

    $replaceTable = @{}
    $replaceTable.Add('&#x2c7;', 'ˇ')
    $replaceTable.Add('&#x2661;', '♡')
    $replaceTable.Add('&#x266b;', '♫')
    $replaceTable.Add('&#x2665;', '♥')
    $replaceTable.Add('&#xff5e;', '～') # Windows IMEで変換できる波ダッシュ
    $replaceTable.Add('&#xff0d;', 'ー') # Windows IMEで「ダッシュ」で変換できる文字
    $replaceTable.Add('&#x25aa;', '▪')
    $replaceTable.Add('&#x2042;', '⁂')
    $replaceTable.Add('&#x303c;', '〼')
    $replaceTable.Add('&#x2764;', '❤')
    $replaceTable.Add('&#x1f479;', '👹')
    $replaceTable.Add('&#x1f356;', '🍖')
    $replaceTable.Add('&#x1f345;', '🍅')
    $replaceTable.Add('&#x2049;', '⁉')
    $replaceTable.Add('&#x2573;', '・')
    $replaceTable.Add('&#x2028;', '')
    $replaceTable.Add('&#x2763;', '❣')
    $replaceTable.Add('&#xfe0f;', '')
    $replaceTable.Add('&#x1f606;', '😆')
    $replaceTable.Add('&#x2469;', '⑩')
    $replaceTable.Add('1_ついなちゃん啓蒙動画_基本', 'ウチ、鬼っ子ハンターついな！　疫病の鬼をやっつける鬼退治師なんよ♡　今日はよいこのみんなに、風邪やインフルエンザの予防法を教えたるで♫　うがい・手洗い・マスクの正しいマナーを覚えて、みんな元気に疫病の鬼退治するんやで〜〜☆')
    $replaceTable.Add('2_ついなちゃん啓蒙動画_うがい', 'うがいの仕方は、３回、口やのどをゆすぐのがポイントや！ 最初は、まず水を口に含み、少し強めに口の中をクチュクチュゆすいで、ぺッて吐き出すで〜。続いて水を口に含み、上を向いて15秒ほどのどの奥でガラガラうがいをするで。１回１５秒、これを２回繰り返すんや！ クチュクチュぺッ、ガラガラぺッ、ガラガラぺッ☆　これ、覚えといてな〜♫')
    $replaceTable.Add('3_ついなちゃん啓蒙動画_手洗い', '手を洗う時は、蛇口から流れる水で手を濡らして、まず石鹸で丁寧に手のひらをこすり洗い。手の甲、指先、爪の間と順番に、念入りにこすること！　指と指の間もしっかり洗うてな☆　親指や手のひらをねじるように洗うのもポイント！　そうそう、手首も忘れずに洗うてな〜！　──そして手洗いの時間は１分くらい。洗った後は、 濡れた手はペーパータオルか清潔なタオルで拭いてね♡')
    $replaceTable.Add('4_ついなちゃん啓蒙動画_マスク', '疫病が流行しとる時は、忘れずにしっかりマスクするのがマナーやで〜。マスクを着けるときは、鼻と口の両方を覆って、隙間がないようにしっかりと装着してな！　マスクない時は、ティッシュやハンカチで口・鼻を覆ってね！　とっさの時は他の人のいない方を向いて、お洋服の袖で口・鼻をカバーしてな！　これぞ、必殺技「肘ブロック」やで☆')
    $replaceTable.Add('_', '/')         # ファイル名に使えないため置換された文字を戻す
    $replaceTable.Add('(/ /////////` )', '(́ _________` )')
    $replaceTable.Add('( ｰ`дｰ/)', '( ｰ`дｰ´)')
    $replaceTable.Add('え/ち', 'えっち')  # Workaround

    foreach ($key in $replaceTable.keys) {
        $displayName = $displayName.Replace($key, $replaceTable[$key])
    }

    Push-Location
    Set-Location ".\wav\"
    [PitagoeRecord]$pitagoe = [PitagoeRecord]::new(
        (Resolve-Path $_.FullName -Relative),
        $displayName,
        $displayName,
        "",
        $_.Directory.Name
    )
    Pop-Location
    $pitagoes += $pitagoe
}

$pitagoes | ConvertTo-Csv -NoTypeInformation | Select-Object -Skip 1 |
    Set-Content ".\wav\ついなちゃんサンプルボイス.csv" -Encoding UTF8

Pop-Location
