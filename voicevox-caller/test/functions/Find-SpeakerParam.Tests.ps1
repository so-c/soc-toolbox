BeforeAll {
    . $PSScriptRoot\..\..\src\functions\Find-SpeakerParam.ps1
}

Describe "Find-SpeakerParam" {
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
            It "MANA (半角大文字) はCOEIROINKのid=0" {
                $actual = Find-SpeakerParam("MANA")
                $actual.baseUrl | Should -Be $COEIROINK_URL
                $actual.id | Should -Be 1
            }
            It "mana (半角小文字) はCOEIROINKのid=0" {
                $actual = Find-SpeakerParam("mana")
                $actual.baseUrl | Should -Be $COEIROINK_URL
                $actual.id | Should -Be 1
            }
            It "ＭＡＮＡ (全角大文字) はCOEIROINKのid=0" {
                $actual = Find-SpeakerParam("ＭＡＮＡ")
                $actual.baseUrl | Should -Be $COEIROINK_URL
                $actual.id | Should -Be 1
            }
            It "ｍａｎａ (全角小文字) はCOEIROINKのid=0" {
                $actual = Find-SpeakerParam("ｍａｎａ")
                $actual.baseUrl | Should -Be $COEIROINK_URL
                $actual.id | Should -Be 1
            }
        }
    }

}