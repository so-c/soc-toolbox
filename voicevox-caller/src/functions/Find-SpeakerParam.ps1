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
    elseif ($speaker -Like "つくよみちゃん*") {
        return @{
            baseUrl = $COEIROINK_URL
            id      = 0
        }
    }
    elseif ($speaker -Like "MANA*" -or $speaker -Like "ＭＡＮＡ*") {
        return @{
            baseUrl = $COEIROINK_URL
            id      = 1
        }
    }
    elseif ($speaker -match "おふとん(P|Ｐ).*") {
        return @{
            baseUrl = $COEIROINK_URL
            id      = 2
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
        Write-Log("VOICEVOXの場合、話者名(≠レイヤー名）を「四国めたん」、「ずんだもん」、「春日部つむぎ」、「雨晴はう」、「波音リツ」で始めてください。COEIROINKの場合、「つくよみちゃん」、「MANA」、「おふとんP」（大文字小文字全角半角問わず）、「ディアちゃん」、「アルマちゃん」で始めてください")
        return
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
    return 0 # 該当しなければずらさない
}