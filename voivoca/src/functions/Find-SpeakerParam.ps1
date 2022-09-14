# 環境パラメータ
# VOICEVOX/COEIROINKの.env参照
$VOICEVOX_URL = "http://127.0.0.1:50021"
$COEIROINK_URL = "http://127.0.0.1:50031"

function Find-SpeakerParam($speaker) {
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
            id      = 9
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
            id      = 11
        }
    }
    
    if ($speaker -Like "白上虎太郎*") {
        return @{
            baseUrl = $VOICEVOX_URL
            id      = 12
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
            id      = 20
        }
    }

    if ($speaker -match "剣崎雌雄.*") {
        return @{
            baseUrl = $VOICEVOX_URL
            id      = 21
        }
    }

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
                id      = 41 # ふくれっつら
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
                default {
                    30
                }
            }
        }
    }
    
    if ($speaker -match "おふとん(P|Ｐ).*") {
        return @{
            baseUrl = $COEIROINK_URL
            id      = switch -Wildcard ($speaker) {
                '*のーまる*' {
                    2
                }
                '*ナレーション*' {
                    8
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
                '*ささやき*' {
                    22
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
・モチノ・キョウコ
・剣崎雌雄
COEIROINK
・つくよみちゃん
・MANA
・MANA+
・KANA
・おふとんP
・ディアちゃん
・アルマちゃん
'@
    )
}
