BeforeAll {
    . $PSScriptRoot\..\..\src\functions\Find-SpeakerParam.ps1
}

Describe "Find-SpeakerParam" {
    # 期待値は http://127.0.0.1:50021/speakers で取得する
    $VOICEVOX_URL = "http://127.0.0.1:50021"
    $COEIROINK_URL = "http://127.0.0.1:50031"

    Context VOICEVOX {
        Context "四国めたん" {
            It "あまあまは、VOICEVOXのid=0" {
                $actual = Find-SpeakerParam("四国めたん（あまあま）")
                $actual.baseUrl | Should -Be $VOICEVOX_URL
                $actual.id | Should -Be 0
            }
    
            It "ノーマルは、VOICEVOXのid=2" {
                $actual = Find-SpeakerParam("四国めたん（ノーマル）")
                $actual.baseUrl | Should -Be $VOICEVOX_URL
                $actual.id | Should -Be 2
            }
    
            It "セクシーは、VOICEVOXのid=4" {
                $actual = Find-SpeakerParam("四国めたん（セクシー）")
                $actual.baseUrl | Should -Be $VOICEVOX_URL
                $actual.id | Should -Be 4
            }
    
            It "ツンツンは、VOICEVOXのid=6" {
                $actual = Find-SpeakerParam("四国めたん（ツンツン）")
                $actual.baseUrl | Should -Be $VOICEVOX_URL
                $actual.id | Should -Be 6
            }    
        }
    
        Context "ずんだもん" {
            It "あまあまは、VOICEVOXのid=1" {
                $actual = Find-SpeakerParam("ずんだもん（あまあま）")
                $actual.baseUrl | Should -Be $VOICEVOX_URL
                $actual.id | Should -Be 1
            }
    
            It "ノーマルは、VOICEVOXのid=3" {
                $actual = Find-SpeakerParam("ずんだもん（ノーマル）")
                $actual.baseUrl | Should -Be $VOICEVOX_URL
                $actual.id | Should -Be 3
            }
    
            It "セクシーは、VOICEVOXのid=5" {
                $actual = Find-SpeakerParam("ずんだもん（セクシー）")
                $actual.baseUrl | Should -Be $VOICEVOX_URL
                $actual.id | Should -Be 5
            }
    
            It "ツンツンは、VOICEVOXのid=7" {
                $actual = Find-SpeakerParam("ずんだもん（ツンツン）")
                $actual.baseUrl | Should -Be $VOICEVOX_URL
                $actual.id | Should -Be 7
            }    
        }

        Context "春日部つむぎ" {
            It "あまあまは、VOICEVOXのid=8" {
                $actual = Find-SpeakerParam("春日部つむぎ")
                $actual.baseUrl | Should -Be $VOICEVOX_URL
                $actual.id | Should -Be 8
            }
        }

        Context "雨晴はう" {
            It "雨晴はうはVOICEVOXのid=10" {
                $actual = Find-SpeakerParam("雨晴はう")
                $actual.baseUrl | Should -Be $VOICEVOX_URL
                $actual.id | Should -Be 10
            }
        }

        Context "波音リツ" {
            It "波音リツは、VOICEVOXのid=9" {
                $actual = Find-SpeakerParam("波音リツ")
                $actual.baseUrl | Should -Be $VOICEVOX_URL
                $actual.id | Should -Be 9
            }
        }
    }

    Context "COEIROINK" {
        Context "つくよみちゃん" {
            It "つくよみちゃんはCOEIROINKのid=0" {
                $actual = Find-SpeakerParam("つくよみちゃん")
                $actual.baseUrl | Should -Be $COEIROINK_URL
                $actual.id | Should -Be 0
            }
        }

        Context "MANA" {
            It "<_>はCOEIROINKのid=1" -ForEach @("MANA", "mana", "Mana", "ＭＡＮＡ", "ｍａｎａ", "Ｍａｎａ") {
                $actual = Find-SpeakerParam($_)
                $actual.baseUrl | Should -Be $COEIROINK_URL
                $actual.id | Should -Be 1
            }
        }
    }
}
