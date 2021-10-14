class PitagoeRecord {
    $FilePath
    [string]$DisplayName
    [string]$Serifu
    [string]$Yomigana
    [string]$Category

    static $replaceTable = @{
        '&#x2c7;'   = 'ˇ'
        '&#x2661;'  = '♡'
        '&#x266b;'  = '♫'
        '&#x2665;'  = '♥'
        '&#xff5e;'  = '～' # Windows IMEで変換できる波ダッシュ
        '&#xff0d;'  = 'ー' # Windows IMEで「ダッシュ」で変換できる文字
        '&#x25aa;'  = '▪'
        '&#x2042;'  = '⁂'
        '&#x303c;'  = '〼'
        '&#x2764;'  = '❤'
        '&#x1f479;' = '👹'
        '&#x1f356;' = '🍖'
        '&#x1f345;' = '🍅'
        '&#x2049;'  = '⁉'
        '&#x2573;'  = '╳'
        '&#x2028;'  = ''
        '&#x2763;'  = '❣'
        '&#xfe0f;'  = ''
        '&#x1f606;' = '😆'
        '&#x2469;'  = '⑩'
        '&#x301;'   = '́'
        '&#x167;'   = 'ŧ'
        '&#x2039;_' = '‹＂'
        '_'         = '/'    # ファイル名に使えないため置換された文字を戻す
    }

    # 最初から使われていた"_"が"/"にされてしまっているので戻し直す
    # 啓蒙動画はついでにアドホックに修正
    static $reReplaceTable = @{
        '1/ついなちゃん啓蒙動画/基本'  = 'ウチ、鬼っ子ハンターついな！　疫病の鬼をやっつける鬼退治師なんよ♡　今日はよいこのみんなに、風邪やインフルエンザの予防法を教えたるで♫　うがい・手洗い・マスクの正しいマナーを覚えて、みんな元気に疫病の鬼退治するんやで〜〜☆'
        '2/ついなちゃん啓蒙動画/うがい' = 'うがいの仕方は、３回、口やのどをゆすぐのがポイントや！ 最初は、まず水を口に含み、少し強めに口の中をクチュクチュゆすいで、ぺッて吐き出すで〜。続いて水を口に含み、上を向いて15秒ほどのどの奥でガラガラうがいをするで。１回１５秒、これを２回繰り返すんや！ クチュクチュぺッ、ガラガラぺッ、ガラガラぺッ☆　これ、覚えといてな〜♫'
        '3/ついなちゃん啓蒙動画/手洗い' = '手を洗う時は、蛇口から流れる水で手を濡らして、まず石鹸で丁寧に手のひらをこすり洗い。手の甲、指先、爪の間と順番に、念入りにこすること！　指と指の間もしっかり洗うてな☆　親指や手のひらをねじるように洗うのもポイント！　そうそう、手首も忘れずに洗うてな〜！　──そして手洗いの時間は１分くらい。洗った後は、 濡れた手はペーパータオルか清潔なタオルで拭いてね♡'
        '4/ついなちゃん啓蒙動画/マスク' = '疫病が流行しとる時は、忘れずにしっかりマスクするのがマナーやで〜。マスクを着けるときは、鼻と口の両方を覆って、隙間がないようにしっかりと装着してな！　マスクない時は、ティッシュやハンカチで口・鼻を覆ってね！　とっさの時は他の人のいない方を向いて、お洋服の袖で口・鼻をカバーしてな！　これぞ、必殺技「肘ブロック」やで☆'
        '(/ /////////` )'  = '(́ _________` )'
        '( ｰ`дｰ/)'         = '( ｰ`дｰ´)'
        'え/ち'              = 'えっち'
        '(/ /)'            = '(> <)'
        'ω/-)'             = 'ω´-)'
        '( ´∀｀)人(´∀｀ )'    = '( ´∀｀)人(´∀｀ )ﾅｶｰﾏ'
        'ξ(。・ˇ/ˇ・。)ξ'   = 'ξ(。・ˇ_ˇ・。)ξ'
    }

    static $categories
    static $displayNumbers
    static $yomiganaDic
    static PitagoeRecord() {
        [PitagoeRecord]::categories = (Get-Content $PSScriptRoot\category.json | ConvertFrom-Json)
        [PitagoeRecord]::displayNumbers = (Get-Content $PSScriptRoot\displayNumbers.json | ConvertFrom-Json)
        [PitagoeRecord]::yomiganaDic = (Get-Content $PSScriptRoot\yomigana.json | ConvertFrom-Json)
    }

    [string] GetSerif([string]$baseName) {

        # ファイル名が一貫していないケースの前処理
        $ret = $baseName -replace '^(116|859|860|861|862|863|864) ', ''

        $dic = [PitagoeRecord]::replaceTable
        foreach ($key in $dic.keys) {
            $ret = $ret.Replace($key, $dic[$key])
        }

        $reDic = [PitagoeRecord]::reReplaceTable
        foreach ($key in $reDic.keys) {
            $ret = $ret.Replace($key, $reDic[$key])
        }
        $ret = $ret -replace '/([0-9]+)', '_$1'
        
        $ret = $ret.Replace("（うめき声_4）/", "（うめき声_4）")
        $ret = $ret.Replace("おっ！ ？/", "おっ！？")
        $ret = $ret.Replace("（笑い_14）/", "（笑い_14）")
        $ret = $ret.Replace("（声にならない声_1）/", "（声にならない声_1）")
        $ret = $ret.Replace("（寝言_1）/", "（寝言_1）")

        return $ret
    }

    [string] GetCategory($relativePath) {
        $cats = [PitagoeRecord]::categories.PSObject.Properties
        foreach ($c in $cats) {
            foreach ($item in $c.Value) {
                if ($item.Contains($relativePath)) {
                    return $c.Name
                }
            }
        }
        return (Split-Path $relativePath -Parent | Split-Path -Leaf)
    }

    [string] GetDisplayName($relativePath, $baseName) {
        return [PitagoeRecord]::displayNumbers.$relativePath + " " + $this.GetSerif($BaseName)
    }

    [string] GetYomigana($relativePath) {
        return [PitagoeRecord]::yomiganaDic.$relativePath
    }

    PitagoeRecord(
        $f,
        [string]$bn,
        [string]$y,
        [string]$c
    ) {
        $this.FilePath = $f
        $this.DisplayName = $this.GetSerif($bn)
        $this.Serifu = $this.GetSerif($bn)
        $this.Yomigana = $y
        $this.Category = $c
    }

    PitagoeRecord(
        $fsi
    ) {
        $relativePath = ((Split-Path $fsi.DirectoryName -Leaf) + "\" + $fsi.Name)

        $this.FilePath = $relativePath
        $this.DisplayName = $this.GetDisplayName($relativePath, $fsi.BaseName)
        $this.Serifu = $this.GetSerif($fsi.BaseName)
        $this.Yomigana = $this.GetYomigana($relativePath)
        $this.Category = $this.GetCategory($relativePath)
    }

    static [PitagoeRecord[]] newPitagoeList([string]$pathToWavs) {
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
}
