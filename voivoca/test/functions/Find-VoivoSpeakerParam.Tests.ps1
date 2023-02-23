BeforeAll {
    . $PSScriptRoot\..\..\src\functions\Find-SpeakerParam.ps1
}

Describe "Find-SpeakerParam for VOICEVOX" {

    # 期待値は http://127.0.0.1:50021/speakers で取得する
    $VOICEVOX_URL = "http://127.0.0.1:50021"

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
        It "ささやきは、VOICEVOXのid=36" {
            $actual = Find-SpeakerParam("四国めたん（ささやき）")
            $actual.baseUrl | Should -Be $VOICEVOX_URL
            $actual.id | Should -Be 36
        }
        It "ヒソヒソは、VOICEVOXのid=37" {
            $actual = Find-SpeakerParam("四国めたん（ヒソヒソ）")
            $actual.baseUrl | Should -Be $VOICEVOX_URL
            $actual.id | Should -Be 37
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
        It "ヒソヒソは、VOICEVOXのid=38" {
            $actual = Find-SpeakerParam("ずんだもん（ヒソヒソ）")
            $actual.baseUrl | Should -Be $VOICEVOX_URL
            $actual.id | Should -Be 38
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
        It "指定なしはid=10" {
            $actual = Find-SpeakerParam("玄野武宏")
            $actual.baseUrl | Should -Be $VOICEVOX_URL
            $actual.id | Should -Be 11
        }
        It "ノーマルはid=10" {
            $actual = Find-SpeakerParam("玄野武宏（ノーマル）")
            $actual.baseUrl | Should -Be $VOICEVOX_URL
            $actual.id | Should -Be 11
        }
        It "喜びはid=39" {
            $actual = Find-SpeakerParam("玄野武宏（喜び）")
            $actual.baseUrl | Should -Be $VOICEVOX_URL
            $actual.id | Should -Be 39
        }
        It "ツンギレはid=40" {
            $actual = Find-SpeakerParam("玄野武宏（ツンギレ）")
            $actual.baseUrl | Should -Be $VOICEVOX_URL
            $actual.id | Should -Be 40
        }
        It "悲しみはid=41" {
            $actual = Find-SpeakerParam("玄野武宏（悲しみ）")
            $actual.baseUrl | Should -Be $VOICEVOX_URL
            $actual.id | Should -Be 41
        }
    }

    Context "白上虎太郎" {
        It "白上虎太郎は、VOICEVOXのid=12" {
            $actual = Find-SpeakerParam("白上虎太郎")
            $actual.baseUrl | Should -Be $VOICEVOX_URL
            $actual.id | Should -Be 12
        }
        It "白上虎太郎 (ふつう) は、VOICEVOXのid=12" {
            $actual = Find-SpeakerParam("白上虎太郎 (ふつう) ")
            $actual.baseUrl | Should -Be $VOICEVOX_URL
            $actual.id | Should -Be 12
        }
        It "白上虎太郎 (わーい) は、VOICEVOXのid=32" {
            $actual = Find-SpeakerParam("白上虎太郎 (わーい) ")
            $actual.baseUrl | Should -Be $VOICEVOX_URL
            $actual.id | Should -Be 32
        }
        It "白上虎太郎 (びくびく) は、VOICEVOXのid=33" {
            $actual = Find-SpeakerParam("白上虎太郎 (びくびく)")
            $actual.baseUrl | Should -Be $VOICEVOX_URL
            $actual.id | Should -Be 33
        }
        It "白上虎太郎 (おこ) は、VOICEVOXのid=34" {
            $actual = Find-SpeakerParam("白上虎太郎 (おこ)")
            $actual.baseUrl | Should -Be $VOICEVOX_URL
            $actual.id | Should -Be 34
        }
        It "白上虎太郎 (びえーん) は、VOICEVOXのid=35" {
            $actual = Find-SpeakerParam("白上虎太郎 (びえーん)")
            $actual.baseUrl | Should -Be $VOICEVOX_URL
            $actual.id | Should -Be 35
        }
    }

    Context "青山龍星" {
        It "青山龍星は、VOICEVOXのid=13" {
            $actual = Find-SpeakerParam("青山龍星")
            $actual.baseUrl | Should -Be $VOICEVOX_URL
            $actual.id | Should -Be 13
        }
    }

    Context "冥鳴ひまり" {
        It "冥鳴ひまりは、VOICEVOXのid=14" {
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

    Context "WhiteCUL" {
        It "指定なしは、VOICEVOXのid=23" {
            $actual = Find-SpeakerParam("WhiteCUL")
            $actual.baseUrl | Should -Be $VOICEVOX_URL
            $actual.id | Should -Be 23
        }
        It "ノーマルは、VOICEVOXのid=23" {
            $actual = Find-SpeakerParam("WhiteCUL（ノーマル）")
            $actual.baseUrl | Should -Be $VOICEVOX_URL
            $actual.id | Should -Be 23
        }
        It "たのしいは、VOICEVOXのid=24" {
            $actual = Find-SpeakerParam("WhiteCUL（たのしい）")
            $actual.baseUrl | Should -Be $VOICEVOX_URL
            $actual.id | Should -Be 24
        }
        It "かなしいは、VOICEVOXのid=25" {
            $actual = Find-SpeakerParam("WhiteCUL（かなしい）")
            $actual.baseUrl | Should -Be $VOICEVOX_URL
            $actual.id | Should -Be 25
        }
        It "びえーんは、VOICEVOXのid=26" {
            $actual = Find-SpeakerParam("WhiteCUL（びえーん）")
            $actual.baseUrl | Should -Be $VOICEVOX_URL
            $actual.id | Should -Be 26
        }
    }

    Context "後鬼" {
        It "指定なしは、VOICEVOXのid=27" {
            $actual = Find-SpeakerParam("後鬼")
            $actual.baseUrl | Should -Be $VOICEVOX_URL
            $actual.id | Should -Be 27
        }
        It "人間ver.は、VOICEVOXのid=27" {
            $actual = Find-SpeakerParam("後鬼（人間ver.）")
            $actual.baseUrl | Should -Be $VOICEVOX_URL
            $actual.id | Should -Be 27
        }
        It "ぬいぐるみver.は、VOICEVOXのid=28" {
            $actual = Find-SpeakerParam("後鬼（ぬいぐるみver.）")
            $actual.baseUrl | Should -Be $VOICEVOX_URL
            $actual.id | Should -Be 28
        }
    }

    Context "No.7" {
        It "指定なしは、VOICEVOXのid=29" {
            $actual = Find-SpeakerParam("No.7")
            $actual.baseUrl | Should -Be $VOICEVOX_URL
            $actual.id | Should -Be 29
        }
        It "ノーマルは、VOICEVOXのid=29" {
            $actual = Find-SpeakerParam("No.7（ノーマル）")
            $actual.baseUrl | Should -Be $VOICEVOX_URL
            $actual.id | Should -Be 29
        }
        It "アナウンスは、VOICEVOXのid=30" {
            $actual = Find-SpeakerParam("No.7（アナウンス）")
            $actual.baseUrl | Should -Be $VOICEVOX_URL
            $actual.id | Should -Be 30
        }
        It "読み聞かせは、VOICEVOXのid=31" {
            $actual = Find-SpeakerParam("No.7（読み聞かせ）")
            $actual.baseUrl | Should -Be $VOICEVOX_URL
            $actual.id | Should -Be 31
        }
    }

    Context "ちび式じい" {
        It "ちび式じいはid=42" {
            $actual = Find-SpeakerParam("ちび式じい")
            $actual.baseUrl | Should -Be $VOICEVOX_URL
            $actual.id | Should -Be 42
        }
    }

    Context "櫻歌ミコ" {
        It "指定なしはid=43" {
            $actual = Find-SpeakerParam("櫻歌ミコ")
            $actual.baseUrl | Should -Be $VOICEVOX_URL
            $actual.id | Should -Be 43
        }
        It "ノーマルはid=43" {
            $actual = Find-SpeakerParam("櫻歌ミコ（ノーマル）")
            $actual.baseUrl | Should -Be $VOICEVOX_URL
            $actual.id | Should -Be 43
        }
        It "第二形態はid=44" {
            $actual = Find-SpeakerParam("櫻歌ミコ（第二形態）")
            $actual.baseUrl | Should -Be $VOICEVOX_URL
            $actual.id | Should -Be 44
        }
        It "ロリはid=45" {
            $actual = Find-SpeakerParam("櫻歌ミコ（ロリ）")
            $actual.baseUrl | Should -Be $VOICEVOX_URL
            $actual.id | Should -Be 45
        }
    }

    Context "小夜/SAYO" {
        It "小夜/SAYOはid=46" {
            $actual = Find-SpeakerParam("小夜/SAYO")
            $actual.baseUrl | Should -Be $VOICEVOX_URL
            $actual.id | Should -Be 46
        }
    }

    Context "ナースロボ_タイプT" {
        It "指定なしはid=47" {
            $actual = Find-SpeakerParam("ナースロボ_タイプT")
            $actual.baseUrl | Should -Be $VOICEVOX_URL
            $actual.id | Should -Be 47
        }
        It "ノーマルはid=47" {
            $actual = Find-SpeakerParam("ナースロボ_タイプT（ノーマル）")
            $actual.baseUrl | Should -Be $VOICEVOX_URL
            $actual.id | Should -Be 47
        }
        It "楽々はid=48" {
            $actual = Find-SpeakerParam("ナースロボ_タイプT（楽々）")
            $actual.baseUrl | Should -Be $VOICEVOX_URL
            $actual.id | Should -Be 48
        }
        It "恐怖はid=49" {
            $actual = Find-SpeakerParam("ナースロボ_タイプT（恐怖）")
            $actual.baseUrl | Should -Be $VOICEVOX_URL
            $actual.id | Should -Be 49
        }
        It "内緒話はid=50" {
            $actual = Find-SpeakerParam("ナースロボ_タイプT（内緒話）")
            $actual.baseUrl | Should -Be $VOICEVOX_URL
            $actual.id | Should -Be 50
        }
    }

    Context "†聖騎士 紅桜†" {
        It "<_>はVOICEVOXのid=51" -ForEach @("†聖騎士 紅桜†", "聖騎士 紅桜", "聖騎士紅桜") {
            $actual = Find-SpeakerParam("$_")
            $actual.baseUrl | Should -Be $VOICEVOX_URL
            $actual.id | Should -Be 51
        }
    }

    Context "雀松朱司" {
        It "雀松朱司はid=52" {
            $actual = Find-SpeakerParam("雀松朱司")
            $actual.baseUrl | Should -Be $VOICEVOX_URL
            $actual.id | Should -Be 52
        }
    }

    Context "麒ヶ島宗麟" {
        It "麒ヶ島宗麟はid=53" {
            $actual = Find-SpeakerParam("麒ヶ島宗麟")
            $actual.baseUrl | Should -Be $VOICEVOX_URL
            $actual.id | Should -Be 53
        }
    }

}
