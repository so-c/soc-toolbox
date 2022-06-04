# 環境パラメータ
# VOICEVOX/COEIROINKの.env参照
$VOICEVOX_URL = "http://127.0.0.1:50021"
$COEIROINK_URL = "http://127.0.0.1:50031"

function Find-SpeakerParam($speaker) {
    if ($speaker -Like "四国めたん*") {
        return @{
            baseUrl = $VOICEVOX_URL
            id      = (0 + (Get-StyleIndex($speaker)))
        }
    }
    elseif ($speaker -Like "ずんだもん*") {
        return @{
            baseUrl = $VOICEVOX_URL
            id      = (1 + (Get-StyleIndex($speaker)))
        }
    }
    elseif ($speaker -Like "春日部つむぎ*") {
        return @{
            baseUrl = $VOICEVOX_URL
            id      = 8
        }
    }
    elseif ($speaker -Like "波音リツ*") {
        return @{
            baseUrl = $VOICEVOX_URL
            id      = 9
        }
    }
    elseif ($speaker -Like "雨晴はう*") {
        return @{
            baseUrl = $VOICEVOX_URL
            id      = 10
        }
    }
    elseif ($speaker -match "玄野武宏*") {
        return @{
            baseUrl = $VOICEVOX_URL
            id      = 11
        }
    }
    elseif ($speaker -match "白上虎太郎*") {
        return @{
            baseUrl = $VOICEVOX_URL
            id      = 12
        }
    }
    elseif ($speaker -match "青山龍星*") {
        return @{
            baseUrl = $VOICEVOX_URL
            id      = 13
        }
    }
    elseif ($speaker -match "冥鳴ひまり*") {
        return @{
            baseUrl = $VOICEVOX_URL
            id      = 14
        }
    }
    elseif ($speaker -Like "九州そら*") {
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
    elseif ($speaker -Like "つくよみちゃん*") {
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
    elseif ($speaker -Like "MANA*" -or $speaker -Like "ＭＡＮＡ*") {
        return @{
            baseUrl = $COEIROINK_URL
            id      = switch -Wildcard ($speaker) {
                '*のーまる*' {
                    1
                }
                '*いっしょうけんめい*' {
                    7
                }
                default {
                    1
                }
            }
        }
    }
    elseif ($speaker -match "おふとん(P|Ｐ).*") {
        return @{
            baseUrl = $COEIROINK_URL
            id      = switch -Wildcard ($speaker) {
                '*のーまる*' {
                    2
                }
                '*ナレーション*' {
                    8
                }
                default {
                    2
                }
            }
        }
    }
    elseif ($speaker -match "ディアちゃん.*") {
        return @{
            baseUrl = $COEIROINK_URL
            id      = 3
        }
    }
    elseif ($speaker -match "アルマちゃん.*") {
        return @{
            baseUrl = $COEIROINK_URL
            id      = 4
        }
    }
    else {
        Write-Error(@'
話者名(≠レイヤー名）がキャラクター名で始まるようにしてください
このウィンドウを終了させるには何かキーを押してください

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
COEIROINK
・つくよみちゃん
・MANA
・おふとんP
・ディアちゃん
・アルマちゃん
'@
        )
        Read-Host
    }
}

# VOICEVOXのスタイル設定
function Get-StyleIndex($speaker) {
    switch -Wildcard ($speaker) {
        '*あまあま*' {
            return 0 # do nothing
        }
        '*ノーマル*' {
            return 2
        }
        '*セクシー*' {
            return 4
        }
        '*ツンツン*' {
            return 6
        } 
    }
    return 2 # 該当しなければノーマル
}