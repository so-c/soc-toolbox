BeforeAll {
    . $PSScriptRoot\..\..\src\functions\Find-SpeakerParam.ps1
}

Describe "Find-SpeakerParam for COEIROINK" {

    # 期待値は http://127.0.0.1:50031/speakers で取得する
    $COEIROINK_URL = "http://127.0.0.1:50031"

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

    Context "MANAさんたち" {
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
            It "MANA（ごきげん）はCOEIROINKのid=40" {
                $actual = Find-SpeakerParam("MANA（ごきげん）")
                $actual.baseUrl | Should -Be $COEIROINK_URL
                $actual.id | Should -Be 40
            }
        }

        Context "MANA+" {
            It "<_>はCOEIROINKのid=41" -ForEach @("MANA+", "mana+", "Mana+", "ＭＡＮＡ＋", "ｍａｎａ＋", "Ｍａｎａ＋") {
                $actual = Find-SpeakerParam($_)
                $actual.baseUrl | Should -Be $COEIROINK_URL
                $actual.id | Should -Be 41
            }
            It "MANA+（ふくれっつら）はCOEIROINKのid=41" {
                $actual = Find-SpeakerParam("MANA+（ふくれっつら）")
                $actual.baseUrl | Should -Be $COEIROINK_URL
                $actual.id | Should -Be 41
            }
            It "MANA+（しょんぼり）はCOEIROINKのid=42" {
                $actual = Find-SpeakerParam("MANA+（しょんぼり）")
                $actual.baseUrl | Should -Be $COEIROINK_URL
                $actual.id | Should -Be 42
            }
            It "MANA+（ないしょばなし）はCOEIROINKのid=43" {
                $actual = Find-SpeakerParam("MANA+（ないしょばなし）")
                $actual.baseUrl | Should -Be $COEIROINK_URL
                $actual.id | Should -Be 43
            }
            It "MANA+（ひっさつわざ）はCOEIROINKのid=44" {
                $actual = Find-SpeakerParam("MANA+（ひっさつわざ）")
                $actual.baseUrl | Should -Be $COEIROINK_URL
                $actual.id | Should -Be 44
            }
        }

        Context "KANA" {
            It "<_>はCOEIROINKのid=30" -ForEach @("KANA", "kana", "Kana+", "ＫＡＮＡ", "ｋａｎａ", "Ｋａｎａ") {
                $actual = Find-SpeakerParam($_)
                $actual.baseUrl | Should -Be $COEIROINK_URL
                $actual.id | Should -Be 30
            }
            It "KANA（のーまる）はCOEIROINKのid=30" {
                $actual = Find-SpeakerParam("KANA（のーまる）")
                $actual.baseUrl | Should -Be $COEIROINK_URL
                $actual.id | Should -Be 30
            }
            It "KANA（えんげき）はCOEIROINKのid=31" {
                $actual = Find-SpeakerParam("KANA（えんげき）")
                $actual.baseUrl | Should -Be $COEIROINK_URL
                $actual.id | Should -Be 31
            }
            It "KANA（ほうかご）はCOEIROINKのid=32" {
                $actual = Find-SpeakerParam("KANA（ほうかご）")
                $actual.baseUrl | Should -Be $COEIROINK_URL
                $actual.id | Should -Be 32
            }
        }
    }

    Context "おふとんPシリーズ" {
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
            It "おふとんP（のーまるv2）はCOEIROINKのid=2" {
                $actual = Find-SpeakerParam("おふとんP（のーまるv2）")
                $actual.baseUrl | Should -Be $COEIROINK_URL
                $actual.id | Should -Be 2
            }
            It "おふとんP（よろこび）はCOEIROINKのid=21" {
                $actual = Find-SpeakerParam("おふとんP（よろこび）")
                $actual.baseUrl | Should -Be $COEIROINK_URL
                $actual.id | Should -Be 21
            }
            It "おふとんP（かなしみ）はCOEIROINKのid=9" {
                $actual = Find-SpeakerParam("おふとんP（かなしみ）")
                $actual.baseUrl | Should -Be $COEIROINK_URL
                $actual.id | Should -Be 9
            }
            It "おふとんP（あせり）はCOEIROINKのid=20" {
                $actual = Find-SpeakerParam("おふとんP（あせり）")
                $actual.baseUrl | Should -Be $COEIROINK_URL
                $actual.id | Should -Be 20
            }
        }

        Context "おふとんP+" {
            It "おふとんP+（ささやき）はCOEIROINKのid=22" {
                $actual = Find-SpeakerParam("おふとんP+（ささやき）")
                $actual.baseUrl | Should -Be $COEIROINK_URL
                $actual.id | Should -Be 22
            }
            It "おふとんP+（ナレーション）はCOEIROINKのid=8" {
                $actual = Find-SpeakerParam("おふとんP+（ナレーション）")
                $actual.baseUrl | Should -Be $COEIROINK_URL
                $actual.id | Should -Be 8
            }
            It "おふとんP+（きざ）はCOEIROINKのid=23" {
                $actual = Find-SpeakerParam("おふとんP+（きざ）")
                $actual.baseUrl | Should -Be $COEIROINK_URL
                $actual.id | Should -Be 23
            }
            It "おふとんP+（きざささやき）はCOEIROINKのid=24" {
                $actual = Find-SpeakerParam("おふとんP+（きざささやき）")
                $actual.baseUrl | Should -Be $COEIROINK_URL
                $actual.id | Should -Be 24
            }
        }

        Context "おふとんP++" {
            It "おふとんP++（はくしん）はCOEIROINKのid=25" {
                $actual = Find-SpeakerParam("おふとんP++（さくしん）")
                $actual.baseUrl | Should -Be $COEIROINK_URL
                $actual.id | Should -Be 25
            }
            It "おふとんP++（いらだち）はCOEIROINKのid=26" {
                $actual = Find-SpeakerParam("おふとんP++（いらだち）")
                $actual.baseUrl | Should -Be $COEIROINK_URL
                $actual.id | Should -Be 26
            }
            It "おふとんP++（よわり）はCOEIROINKのid=27" {
                $actual = Find-SpeakerParam("おふとんP++（よわり）")
                $actual.baseUrl | Should -Be $COEIROINK_URL
                $actual.id | Should -Be 27
            }
            It "おふとんP++（めんよう）はCOEIROINKのid=28" {
                $actual = Find-SpeakerParam("おふとんP++（めんよう）")
                $actual.baseUrl | Should -Be $COEIROINK_URL
                $actual.id | Should -Be 28
            }
        }

        Context "おふとんP+++" {
            It "おふとんP+++（どくはく）はCOEIROINKのid=80" {
                $actual = Find-SpeakerParam("おふとんP+++（どくはく）")
                $actual.baseUrl | Should -Be $COEIROINK_URL
                $actual.id | Should -Be 80
            }
            It "おふとんP+++（ホラー）はCOEIROINKのid=81" {
                $actual = Find-SpeakerParam("おふとんP+++（ホラー）")
                $actual.baseUrl | Should -Be $COEIROINK_URL
                $actual.id | Should -Be 81
            }
            It "おふとんP+++（おちつき）はCOEIROINKのid=82" {
                $actual = Find-SpeakerParam("おふとんP+++（おちつき）")
                $actual.baseUrl | Should -Be $COEIROINK_URL
                $actual.id | Should -Be 82
            }
            It "おふとんP+++（無声ささやき）はCOEIROINKのid=83" {
                $actual = Find-SpeakerParam("おふとんP+++（無声ささやき）")
                $actual.baseUrl | Should -Be $COEIROINK_URL
                $actual.id | Should -Be 83
            }
        }
    }

    Context "LKP" {
        Context "ディアちゃん" {
            It "<_>はCOEIROINKのid=3" -ForEach @("ディアちゃん") {
                $actual = Find-SpeakerParam($_)
                $actual.baseUrl | Should -Be $COEIROINK_URL
                $actual.id | Should -Be 3
            }
        }

        Context "アルマちゃん" {
            It "<_>はCOEIROINKのid=4" -ForEach @("アルマちゃん", "アルマちゃん（表-v1）") {
                $actual = Find-SpeakerParam($_)
                $actual.baseUrl | Should -Be $COEIROINK_URL
                $actual.id | Should -Be 4
            }
            It "アルマちゃん（表-v2）はCOEIROINKのid=10" {
                $actual = Find-SpeakerParam("アルマちゃん（表-v2）")
                $actual.baseUrl | Should -Be $COEIROINK_URL
                $actual.id | Should -Be 10
            }
            It "アルマちゃん（裏）はCOEIROINKのid=11" {
                $actual = Find-SpeakerParam("アルマちゃん（裏）")
                $actual.baseUrl | Should -Be $COEIROINK_URL
                $actual.id | Should -Be 11
            }
        }

        Context "リリンちゃん" {
            It "<_>はCOEIROINKのid=90 (のーまる)" -ForEach @("リリンちゃん") {
                $actual = Find-SpeakerParam($_)
                $actual.baseUrl | Should -Be $COEIROINK_URL
                $actual.id | Should -Be 90
            }
            It "リリンちゃん（のーまる）はCOEIROINKのid=90" {
                $actual = Find-SpeakerParam("リリンちゃん（のーまる）")
                $actual.baseUrl | Should -Be $COEIROINK_URL
                $actual.id | Should -Be 90
            }
            It "リリンちゃん（ささやき）はCOEIROINKのid=91" {
                $actual = Find-SpeakerParam("リリンちゃん（ささやき）")
                $actual.baseUrl | Should -Be $COEIROINK_URL
                $actual.id | Should -Be 91
            }
            It "リリンちゃん（メスガキ）はCOEIROINKのid=92" {
                $actual = Find-SpeakerParam("リリンちゃん（メスガキ）")
                $actual.baseUrl | Should -Be $COEIROINK_URL
                $actual.id | Should -Be 92
            }
        }
    }

    Context "AI声優" {
        It "朱花はCOEIROINKのid=50" {
            $actual = Find-SpeakerParam("朱花")
            $actual.baseUrl | Should -Be $COEIROINK_URL
            $actual.id | Should -Be 50
        }
        It "青葉はCOEIROINKのid=60" {
            $actual = Find-SpeakerParam("青葉")
            $actual.baseUrl | Should -Be $COEIROINK_URL
            $actual.id | Should -Be 60
        }
        Context "銀芽" {
            It "銀芽はCOEIROINKのid=70" {
                $actual = Find-SpeakerParam("銀芽")
                $actual.baseUrl | Should -Be $COEIROINK_URL
                $actual.id | Should -Be 70
            }
            It "銀芽（のーまる）はCOEIROINKのid=70" {
                $actual = Find-SpeakerParam("銀芽（のーまる）")
                $actual.baseUrl | Should -Be $COEIROINK_URL
                $actual.id | Should -Be 70
            }
            It "銀芽（感情的）はCOEIROINKのid=71" {
                $actual = Find-SpeakerParam("銀芽（感情的）")
                $actual.baseUrl | Should -Be $COEIROINK_URL
                $actual.id | Should -Be 71
            }
        }
    }
}
