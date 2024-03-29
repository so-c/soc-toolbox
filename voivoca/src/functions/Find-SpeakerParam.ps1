﻿# 環境パラメータ
# VOICEVOX/COEIROINKの.env参照
$VOICEVOX_URL = "http://127.0.0.1:50021"
$COEIROINK_URL = "http://127.0.0.1:50031"

function Find-SpeakerParam($speaker) {
    # VOICEVOX    
    if ($speaker -Like "四国めたん*") {
        return @{
            baseUrl = $VOICEVOX_URL
            id      = switch -Wildcard ($speaker) {
                '*あまあま*' {
                    0 # do nothing
                }
                '*ノーマル*' {
                    2
                }
                '*セクシー*' {
                    4
                }
                '*ツンツン*' {
                    6
                }
                '*ささやき*' {
                    36
                } 
                '*ヒソヒソ*' {
                    37
                } 
                default {
                    2
                }
            }
        }
    }

    if ($speaker -Like "ずんだもん*") {
        return @{
            baseUrl = $VOICEVOX_URL
            id      = switch -Wildcard ($speaker) {
                '*あまあま*' {
                    1
                }
                '*ノーマル*' {
                    3
                }
                '*セクシー*' {
                    5
                }
                '*ツンツン*' {
                    7
                } 
                '*ささやき*' {
                    22
                }
                '*ヒソヒソ*' {
                    38
                }
                default {
                    3
                }
            }
        }
    }
    
    if ($speaker -Like "春日部つむぎ*") {
        return @{
            baseUrl = $VOICEVOX_URL
            id      = 8
        }
    }
    
    if ($speaker -Like "波音リツ*") {
        return @{
            baseUrl = $VOICEVOX_URL
            id      = switch ($speaker) {
                "ノーマル" {
                    9
                }
                "クイーン" {
                    65
                }
                default {
                    9
                }

            }
        }
    }
    
    if ($speaker -Like "雨晴はう*") {
        return @{
            baseUrl = $VOICEVOX_URL
            id      = 10
        }
    }
    
    if ($speaker -Like "玄野武宏*") {
        return @{
            baseUrl = $VOICEVOX_URL
            id      = switch -Wildcard ($speaker) {
                '*ノーマル*' {
                    11
                }
                '*喜び*' {
                    39
                }
                '*ツンギレ*' {
                    40
                }
                '*悲しみ*' {
                    41
                }
                default {
                    11
                }
            }
        }
    }
    
    if ($speaker -Like "白上虎太郎*") {
        return @{
            baseUrl = $VOICEVOX_URL
            id      = switch -Wildcard ($speaker) {
                '*ふつう*' {
                    12
                }
                '*わーい*' {
                    32
                }
                '*びくびく*' {
                    33
                }
                '*おこ*' {
                    34
                }
                '*びえーん*' {
                    35
                }
                default {
                    12
                }
            }
        }
    }
    
    if ($speaker -Like "青山龍星*") {
        return @{
            baseUrl = $VOICEVOX_URL
            id      = 13
        }
    }
    
    if ($speaker -Like "冥鳴ひまり*") {
        return @{
            baseUrl = $VOICEVOX_URL
            id      = 14
        }
    }
    
    if ($speaker -Like "九州そら*") {
        return @{
            baseUrl = $VOICEVOX_URL
            id      = switch -Wildcard ($speaker) {
                '*ノーマル*' {
                    16
                }
                '*あまあま*' {
                    15
                }
                '*ツンツン*' {
                    18
                }
                '*セクシー*' {
                    17
                }
                '*ささやき*' {
                    19
                }
                default {
                    16
                }
            }
        }
    }

    if ($speaker -match "モチノ・キョウコ|もち子(さん)?.*") {
        return @{
            baseUrl = $VOICEVOX_URL
            id      = switch -Regex ($speaker) {
                "ノーマル" {
                    20
                }
                "(セクシー|あん子)" {
                    66
                }
                default {
                    20
                }
            }
        }
    }

    if ($speaker -match "剣崎雌雄.*") {
        return @{
            baseUrl = $VOICEVOX_URL
            id      = 21
        }
    }

    if ($speaker -match "WhiteCUL*" -or $speaker -match "ＷｈｉｔｅＣＵＬ*") {
        return @{
            baseUrl = $VOICEVOX_URL
            id      = switch -Wildcard ($speaker) {
                '*ノーマル*' {
                    23
                }
                '*たのしい*' {
                    24
                }
                '*かなしい*' {
                    25
                }
                '*びえーん*' {
                    26
                }
                default {
                    23
                }
            }
        }
    }

    if ($speaker -match "後鬼*") {
        return @{
            baseUrl = $VOICEVOX_URL
            id      = switch -Wildcard ($speaker) {
                '*人間*' {
                    27
                }
                '*ぬいぐるみ*' {
                    28
                }
                default {
                    27
                }
            }
        }
    }

    if ($speaker -match "No.7*" -or $speaker -match "Ｎｏ．７*") {
        return @{
            baseUrl = $VOICEVOX_URL
            id      = switch -Wildcard ($speaker) {
                '*ノーマル*' {
                    29
                }
                '*アナウンス*' {
                    30
                }
                '*読み聞かせ*' {
                    31
                }
                default {
                    29
                }
            }
        }
    }

    if ($speaker -like "ちび式じい*") {
        return @{
            baseUrl = $VOICEVOX_URL
            id      = 42
        }
    }

    if ($speaker -like "櫻歌ミコ*") {
        return @{
            baseUrl = $VOICEVOX_URL
            id      = switch -Wildcard ($speaker) {
                '*ノーマル*' {
                    43
                }
                '*第二形態*' {
                    44
                }
                '*ロリ*' {
                    45
                }
                default {
                    43
                }
            }
        }
    }

    if ($speaker -match "小夜(/|／)(sayo|ｓａｙｏ|ＳＡＹＯ)*") {
        return @{
            baseUrl = $VOICEVOX_URL
            id      = 46
        }
    }

    if ($speaker -match "ナースロボ(_|＿)タイプ(t|ｔ|Ｔ)") {
        return @{
            baseUrl = $VOICEVOX_URL
            id      = switch -Wildcard ($speaker) {
                '*ノーマル*' {
                    47
                }
                '*楽々*' {
                    48
                }
                '*恐怖*' {
                    49
                }
                '*内緒話*' {
                    50
                }
                default {
                    47
                }
            }
        }
    }

    # †と半角スペースの有無の違いは許容する
    if ($speaker -match "^†?聖騎士\s?紅桜*") {
        return @{
            baseUrl = $VOICEVOX_URL
            id      = 51
        }
    }

    if ($speaker -match "雀松朱司*") {
        return @{
            baseUrl = $VOICEVOX_URL
            id      = 52
        }
    }

    if ($speaker -match "麒ヶ島宗麟*") {
        return @{
            baseUrl = $VOICEVOX_URL
            id      = 53
        }
    }

    if ($speaker -like "春歌ナナ*") {
        return @{
            baseUrl = $VOICEVOX_URL
            id      = 54
        }
    }

    if ($speaker -like "猫使アル*") {
        return @{
            baseUrl = $VOICEVOX_URL
            id      = switch -Wildcard ($speaker) {
                '*ノーマル*' {
                    55
                }
                '*おちつき*' {
                    56
                }
                '*うきうき*' {
                    57
                }
                default {
                    55
                }
            }
        }
    }

    if ($speaker -like "猫使ビィ*") {
        return @{
            baseUrl = $VOICEVOX_URL
            id      = switch -Wildcard ($speaker) {
                '*ノーマル*' {
                    58
                }
                '*おちつき*' {
                    59
                }
                '*人見知り*' {
                    60
                }
                default {
                    58
                }
            }
        }
    }

    if ($speaker -like "中国うさぎ*") {
        return @{
            baseUrl = $VOICEVOX_URL
            id      = switch -Wildcard ($speaker) {
                '*ノーマル*' {
                    61
                }
                '*おどろき*' {
                    62
                }
                '*こわがり*' {
                    63
                }
                '*へろへろ*' {
                    64
                }
                default {
                    61
                }
            }
        }
    }

    if ($speaker -like "栗田まろん*") {
        return @{
            baseUrl = $VOICEVOX_URL
            id      = 67
        }
    }

    if ($speaker -like "あいえるたん*") {
        return @{
            baseUrl = $VOICEVOX_URL
            id      = 68
        }
    }

    if ($speaker -like "満別花丸*") {
        return @{
            baseUrl = $VOICEVOX_URL
            id      = switch -Wildcard ($speaker) {
                '*ノーマル*' {
                    69
                }
                '*元気*' {
                    70
                }
                '*ささやき*' {
                    71
                }
                '*ぶりっ子*' {
                    72
                }
                '*ボーイ*' {
                    73
                }
                default {
                    69
                }
            }
        }
    }

    if ($speaker -like "琴詠ニア*") {
        return @{
            baseUrl = $VOICEVOX_URL
            id      = 74
        }
    }

    # COEIROINK
    if ($speaker -Like "つくよみちゃん*") {
        return @{
            baseUrl = $COEIROINK_URL
            id      = switch -Wildcard ($speaker) {
                '*れいせい*' {
                    0
                }
                '*おしとやか*' {
                    5
                }
                '*げんき*' {
                    6
                }
                default {
                    5
                }
            }
        }
    }
    
    if ($speaker -match "(MANA|ＭＡＮＡ).*") {
        if ($speaker -match "(MANA|ＭＡＮＡ)(\+|＋).*") {
            return @{
                baseUrl = $COEIROINK_URL
                id      = switch -Wildcard ($speaker) {
                    '*ふくれっつら*' {
                        41
                    }
                    '*しょんぼり*' {
                        42
                    }
                    '*ないしょばなし*' {
                        43
                    }
                    '*ひっさつわざ*' {
                        44
                    }
                    default {
                        41
                    }
                }
            }
        }

        return @{
            baseUrl = $COEIROINK_URL
            id      = switch -Wildcard ($speaker) {
                '*のーまる*' {
                    1
                }
                '*いっしょうけんめい*' {
                    7
                }
                '*ごきげん*' {
                    40
                }
                '*どやがお*' {
                    45
                }
                default {
                    1
                }
            }
        }
    }

    if ($speaker -match "KANA*" -or $speaker -match "ＫＡＮＡ*") {
        return @{
            baseUrl = $COEIROINK_URL
            id      = switch -Wildcard ($speaker) {
                '*のーまる*' {
                    30
                }
                '*えんげき*' {
                    31
                }
                '*ほうかご*' {
                    32
                }
                default {
                    30
                }
            }
        }
    }
    
    if ($speaker -match "おふとん(P|Ｐ).*") {
        if ($speaker -match "おふとん(P|Ｐ)(\+|＋){1}.*") {
            if ($speaker -match "おふとん(P|Ｐ)(\++|＋＋){2}.*") {
                if ($speaker -match "おふとん(P|Ｐ)(\++|＋＋){3}.*") {
                    return @{
                        baseUrl = $COEIROINK_URL
                        id      = switch -Wildcard ($speaker) {
                            '*どくはく*' {
                                80
                            }
                            '*ホラー*' {
                                81
                            }
                            '*おちつき*' {
                                82
                            }
                            '*無声ささやき*' {
                                83
                            }
                            default {
                                80
                            }
                        }
                    }    
                }
                return @{
                    baseUrl = $COEIROINK_URL
                    id      = switch -Wildcard ($speaker) {
                        '*はくしん*' {
                            25
                        }
                        '*いらだち*' {
                            26
                        }
                        '*よわり*' {
                            27
                        }
                        '*めんよう*' {
                            28
                        }
                        default {
                            25
                        }
                    }
                }
            }
            return @{
                baseUrl = $COEIROINK_URL
                id      = switch -Wildcard ($speaker) {
                    '*きざささやき*' {
                        24
                        break
                    }
                    '*ささやき*' {
                        22
                    }
                    '*ナレーション*' {
                        8
                    }
                    '*きざ*' {
                        23
                    }
                    default {
                        8
                    }
                }
            }
        }
        return @{
            baseUrl = $COEIROINK_URL
            id      = switch -Wildcard ($speaker) {
                '*のーまる*' {
                    2
                }
                '*かなしみ*' {
                    9
                }
                '*あせり*' {
                    20
                }
                '*よろこび*' {
                    21
                }
                default {
                    2
                }
            }
        }
    }
    
    if ($speaker -Like "ディアちゃん*") {
        return @{
            baseUrl = $COEIROINK_URL
            id      = 3
        }
    }
    
    if ($speaker -Like "アルマちゃん*") {
        return @{
            baseUrl = $COEIROINK_URL
            id      = switch -Wildcard ($speaker) {
                '*表-v1*' {
                    4
                }
                '*裏*' {
                    11
                }
                '*表-v2*' {
                    10
                }
                default {
                    4
                }
            }
        }
    }

    if ($speaker -Like "リリンちゃん*") {
        return @{
            baseUrl = $COEIROINK_URL
            id      = switch -Wildcard ($speaker) {
                '*のーまる*' {
                    90
                }
                '*ささやき*' {
                    91
                }
                '*メスガキ*' {
                    92
                }
                default {
                    90
                }
            }
        }
    }

    if ($speaker -match "(AI-声優)?朱花") {
        return @{
            baseUrl = $COEIROINK_URL
            id      = 50
        }
    }

    if ($speaker -match "(AI-声優)?青葉") {
        return @{
            baseUrl = $COEIROINK_URL
            id      = 60
        }
    }

    if ($speaker -match "(AI-声優)?銀芽*") {
        return @{
            baseUrl = $COEIROINK_URL
            id      = switch -Wildcard ($speaker) {
                '*のーまる*' { 70 }
                '*感情的*' { 71 }
                Default { 70 }
            }
        }
    }

    if ($speaker -match "(AI-声優)?金苗") {
        return @{
            baseUrl = $COEIROINK_URL
            id      = 100
        }
    }

    Write-Error(@'
話者名(≠レイヤー名）がキャラクター名で始まるようにしてください

VOICEVOX
・四国めたん
・ずんだもん
・春日部つむぎ
・雨晴はう
・波音リツ
・玄野武宏
・白上虎太郎
・青山龍星
・九州そら
・もち子さん
・剣崎雌雄
・No.7
・後鬼
・WhiteCUL
・ちび式じい
・櫻歌ミコ
・小夜/SAYO
・ナースロボ_タイプT
・†聖騎士 紅桜†
・雀松朱司
・麒ヶ島宗麟
・春歌ナナ
・猫使アル
・猫使ビィ
・中国うさぎ
・栗田まろん
・あいえるたん
・満別花丸
・琴詠ニア
COEIROINK
・つくよみちゃん
・MANA
・MANA+
・KANA
・おふとんP
・おふとんP+
・おふとんP++
・ディアちゃん
・アルマちゃん
・リリンちゃん
・朱花
・青葉
・銀芽
・金苗
'@
    )
}
