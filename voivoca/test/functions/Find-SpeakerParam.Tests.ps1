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

            It "ささやきは、VOICEVOXのid=22" {
                $actual = Find-SpeakerParam("ずんだもん（ささやき）")
                $actual.baseUrl | Should -Be $VOICEVOX_URL
                $actual.id | Should -Be 22
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

        Context "玄野武宏" {
            It "玄野武宏は、VOICEVOXのid=10" {
                $actual = Find-SpeakerParam("玄野武宏")
                $actual.baseUrl | Should -Be $VOICEVOX_URL
                $actual.id | Should -Be 11
            }
        }
        Context "白上虎太郎" {
            It "白上虎太郎は、VOICEVOXのid=11" {
                $actual = Find-SpeakerParam("白上虎太郎")
                $actual.baseUrl | Should -Be $VOICEVOX_URL
                $actual.id | Should -Be 12
            }
        }
        Context "青山龍星" {
            It "青山龍星は、VOICEVOXのid=12" {
                $actual = Find-SpeakerParam("青山龍星")
                $actual.baseUrl | Should -Be $VOICEVOX_URL
                $actual.id | Should -Be 13
            }
        }
        Context "冥鳴ひまり" {
            It "冥鳴ひまりは、VOICEVOXのid=13" {
                $actual = Find-SpeakerParam("冥鳴ひまり")
                $actual.baseUrl | Should -Be $VOICEVOX_URL
                $actual.id | Should -Be 14
            }
        }

        Context "九州そら" {
            It "あまあまは、VOICEVOXのid=15" {
                $actual = Find-SpeakerParam("九州そら（あまあま）")
                $actual.baseUrl | Should -Be $VOICEVOX_URL
                $actual.id | Should -Be 15
            }
    
            It "ノーマルは、VOICEVOXのid=16" {
                $actual = Find-SpeakerParam("九州そら（ノーマル）")
                $actual.baseUrl | Should -Be $VOICEVOX_URL
                $actual.id | Should -Be 16
            }
    
            It "セクシーは、VOICEVOXのid=17" {
                $actual = Find-SpeakerParam("九州そら（セクシー）")
                $actual.baseUrl | Should -Be $VOICEVOX_URL
                $actual.id | Should -Be 17
            }
            It "ツンツンは、VOICEVOXのid=18" {
                $actual = Find-SpeakerParam("九州そら（ツンツン）")
                $actual.baseUrl | Should -Be $VOICEVOX_URL
                $actual.id | Should -Be 18
            }
            It "ささやきは、VOICEVOXのid=19" {
                $actual = Find-SpeakerParam("九州そら（ささやき）")
                $actual.baseUrl | Should -Be $VOICEVOX_URL
                $actual.id | Should -Be 19
            }
        }

        Context "モチノ・キョウコ" {
            It "<_>はVOICEVOXのid=20" -ForEach @("モチノ・キョウコ", "もち子さん", "もち子") {
                $actual = Find-SpeakerParam($_)
                $actual.baseUrl | Should -Be $VOICEVOX_URL
                $actual.id | Should -Be 20
            }
        }

        Context "剣崎雌雄" {
            It "<_>はVOICEVOXのid=21" -ForEach @("剣崎雌雄") {
                $actual = Find-SpeakerParam($_)
                $actual.baseUrl | Should -Be $VOICEVOX_URL
                $actual.id | Should -Be 21
            }
        }
    }

    Context "COEIROINK" {
        Context "つくよみちゃん" {
            It "つくよみちゃんはCOEIROINKのid=5" {
                $actual = Find-SpeakerParam("つくよみちゃん")
                $actual.baseUrl | Should -Be $COEIROINK_URL
                $actual.id | Should -Be 5
            }
            It "つくよみちゃん（れいせい）はCOEIROINKのid=0" {
                $actual = Find-SpeakerParam("つくよみちゃん（れいせい）")
                $actual.baseUrl | Should -Be $COEIROINK_URL
                $actual.id | Should -Be 0
            }
            It "つくよみちゃん（おしとやか）はCOEIROINKのid=5" {
                $actual = Find-SpeakerParam("つくよみちゃん（おしとやか）")
                $actual.baseUrl | Should -Be $COEIROINK_URL
                $actual.id | Should -Be 5
            }
            It "つくよみちゃん（げんき）はCOEIROINKのid=6" {
                $actual = Find-SpeakerParam("つくよみちゃん（げんき）")
                $actual.baseUrl | Should -Be $COEIROINK_URL
                $actual.id | Should -Be 6
            }
        }

        Context "MANA" {
            It "<_>はCOEIROINKのid=1" -ForEach @("MANA", "mana", "Mana", "ＭＡＮＡ", "ｍａｎａ", "Ｍａｎａ") {
                $actual = Find-SpeakerParam($_)
                $actual.baseUrl | Should -Be $COEIROINK_URL
                $actual.id | Should -Be 1
            }
            It "MANA（のーまる）はCOEIROINKのid=1" {
                $actual = Find-SpeakerParam("MANA（のーまる）")
                $actual.baseUrl | Should -Be $COEIROINK_URL
                $actual.id | Should -Be 1
            }
            It "MANA（いっしょうけんめい）はCOEIROINKのid=7" {
                $actual = Find-SpeakerParam("MANA（いっしょうけんめい）")
                $actual.baseUrl | Should -Be $COEIROINK_URL
                $actual.id | Should -Be 7
            }
        }

        Context "おふとんP" {
            It "<_>はCOEIROINKのid=2" -ForEach @("おふとんｐ", "おふとんＰ", "おふとんp", "おふとんP") {
                $actual = Find-SpeakerParam($_)
                $actual.baseUrl | Should -Be $COEIROINK_URL
                $actual.id | Should -Be 2
            }
            It "おふとんP（のーまる）はCOEIROINKのid=2" {
                $actual = Find-SpeakerParam("おふとんP（のーまる）")
                $actual.baseUrl | Should -Be $COEIROINK_URL
                $actual.id | Should -Be 2
            }
            It "おふとんP（ナレーション）はCOEIROINKのid=8" {
                $actual = Find-SpeakerParam("おふとんP（ナレーション）")
                $actual.baseUrl | Should -Be $COEIROINK_URL
                $actual.id | Should -Be 8
            }
            It "おふとんP（かなしみ）はCOEIROINKのid=9" {
                $actual = Find-SpeakerParam("おふとんP（かなしみ）")
                $actual.baseUrl | Should -Be $COEIROINK_URL
                $actual.id | Should -Be 9
            }
        }

        Context "ディアちゃん" {
            It "<_>はCOEIROINKのid=3" -ForEach @("ディアちゃん") {
                $actual = Find-SpeakerParam($_)
                $actual.baseUrl | Should -Be $COEIROINK_URL
                $actual.id | Should -Be 3
            }
        }

        Context "アルマちゃん" {
            It "<_>はCOEIROINKのid=4" -ForEach @("アルマちゃん") {
                $actual = Find-SpeakerParam($_)
                $actual.baseUrl | Should -Be $COEIROINK_URL
                $actual.id | Should -Be 4
            }
        }

    }
}
