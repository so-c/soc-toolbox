class PitagoeRecord {
    $FilePath
    [string]$DisplayName
    [string]$Serifu
    [string]$Yomigana
    [string]$Category

    static $replaceTable = @{
        '&#x2c7;'          = 'ˇ'
        '&#x2661;'         = '♡'
        '&#x266b;'         = '♫'
        '&#x2665;'         = '♥'
        '&#xff5e;'         = '～' # Windows IMEで変換できる波ダッシュ
        '&#xff0d;'         = 'ー' # Windows IMEで「ダッシュ」で変換できる文字
        '&#x25aa;'         = '▪'
        '&#x2042;'         = '⁂'
        '&#x303c;'         = '〼'
        '&#x2764;'         = '❤'
        '&#x1f479;'        = '👹'
        '&#x1f356;'        = '🍖'
        '&#x1f345;'        = '🍅'
        '&#x2049;'         = '⁉'
        '&#x2573;'         = '・'
        '&#x2028;'         = ''
        '&#x2763;'         = '❣'
        '&#xfe0f;'         = ''
        '&#x1f606;'        = '😆'
        '&#x2469;'         = '⑩'
        '1_ついなちゃん啓蒙動画_基本'  = 'ウチ、鬼っ子ハンターついな！　疫病の鬼をやっつける鬼退治師なんよ♡　今日はよいこのみんなに、風邪やインフルエンザの予防法を教えたるで♫　うがい・手洗い・マスクの正しいマナーを覚えて、みんな元気に疫病の鬼退治するんやで〜〜☆'
        '2_ついなちゃん啓蒙動画_うがい' = 'うがいの仕方は、３回、口やのどをゆすぐのがポイントや！ 最初は、まず水を口に含み、少し強めに口の中をクチュクチュゆすいで、ぺッて吐き出すで〜。続いて水を口に含み、上を向いて15秒ほどのどの奥でガラガラうがいをするで。１回１５秒、これを２回繰り返すんや！ クチュクチュぺッ、ガラガラぺッ、ガラガラぺッ☆　これ、覚えといてな〜♫'
        '3_ついなちゃん啓蒙動画_手洗い' = '手を洗う時は、蛇口から流れる水で手を濡らして、まず石鹸で丁寧に手のひらをこすり洗い。手の甲、指先、爪の間と順番に、念入りにこすること！　指と指の間もしっかり洗うてな☆　親指や手のひらをねじるように洗うのもポイント！　そうそう、手首も忘れずに洗うてな〜！　──そして手洗いの時間は１分くらい。洗った後は、 濡れた手はペーパータオルか清潔なタオルで拭いてね♡'
        '4_ついなちゃん啓蒙動画_マスク' = '疫病が流行しとる時は、忘れずにしっかりマスクするのがマナーやで〜。マスクを着けるときは、鼻と口の両方を覆って、隙間がないようにしっかりと装着してな！　マスクない時は、ティッシュやハンカチで口・鼻を覆ってね！　とっさの時は他の人のいない方を向いて、お洋服の袖で口・鼻をカバーしてな！　これぞ、必殺技「肘ブロック」やで☆'
        '_'                = '/'         # ファイル名に使えないため置換された文字を戻す
        # Workaround
        '(/ /////////` )'  = '(́ _________` )'
        '( ｰ`дｰ/)'         = '( ｰ`дｰ´)'
        'え/ち'              = 'えっち'
    }

    [string] GetDisplayName([string]$baseName) {
        $ret = if ($baseName.StartsWith('116 ')) {
            ($baseName -replace '116 ', '')
        }
        else {
            $baseName
        }

        $dic = [PitagoeRecord]::replaceTable
        foreach ($key in $dic.keys) {
            $ret = ($ret -replace $key, $dic[$key])
        }

        return $ret
    }

    PitagoeRecord(
        $f,
        [string]$bn,
        [string]$y,
        [string]$c
    ) {
        $this.FilePath = $f
        $this.DisplayName = $this.GetDisplayName($bn)
        $this.Serifu = $this.GetDisplayName($bn)
        $this.Yomigana = $y
        $this.Category = $c
    }

    PitagoeRecord(
        $fsi
    ) {
        $this.FilePath = ((Split-Path $fsi.DirectoryName -Leaf) + "\" + $fsi.Name)
        $this.DisplayName = $this.GetDisplayName($fsi.BaseName)
        $this.Serifu = $this.GetDisplayName($fsi.BaseName)
        $this.Yomigana = ""
        $this.Category = $fsi.Directory.Name
    }
}
