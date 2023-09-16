BeforeAll {
    . $PSScriptRoot\..\..\src\functions\Find-SpeakerParam.ps1
}

Describe "Find-SpeakerParam for SHAREVOX" {

    # 期待値は http://127.0.0.1:50025/speakers で取得する
    $SHAREVOX_URL = "http://127.0.0.1:50025"

    Context "スタイルあり音源にスタイル指定なし" {
        # TODO
    }

    Context "スタイルあり音源にスタイル指定あり" {
        # TODO
    }

    Context "スタイルなし音源" {
        Context "ゆき＆ユキ" {
            It "風花ゆきはid=23" {
                $actual = Find-SpeakerParam("風花ゆき")
                $actual.baseUrl | Should -Be $SHAREVOX_URL
                $actual.id | Should -Be 23
            }
            It "風花ユキもid=23" {
                $actual = Find-SpeakerParam("風花ユキ")
                $actual.baseUrl | Should -Be $SHAREVOX_URL
                $actual.id | Should -Be 23
            }
        }
        It "安倍広葉はid=24" {
            $actual = Find-SpeakerParam("安倍広葉")
            $actual.baseUrl | Should -Be $SHAREVOX_URL
            $actual.id | Should -Be 24
        }
        It "鈴乃はid=25" {
            $actual = Find-SpeakerParam("鈴乃")
            $actual.baseUrl | Should -Be $SHAREVOX_URL
            $actual.id | Should -Be 25
        }
    }
}
