BeforeAll {
  . $PSScriptRoot\..\..\src\functions\Speakers.ps1
}

Describe "スピーカー名からUUIDとStyleIDを検索する機能のテスト" {
  Context "MYCOEIROINKでデフォルトスタイル" {
    It "八蜂鞠ククリ" {
      $actual = Find-Speaker("八蜂鞠ククリ")
      $actual.uuid | should -Be "8b8d4e5e-33bd-11ed-915b-0242ac1c0002"
      $actual.styleId | should -Be 653068302
    }
  }

  Context "公式音源で非デフォルトスタイル" {
    It "つくよみちゃん（げんき）" {
      $actual = Find-Speaker("つくよみちゃん（げんき）")
      $actual.uuid | should -Be "3c37646f-3881-5374-2a83-149267990abc"
      $actual.styleId | should -Be 6
    }
  }

  Context "一方が他方の音源名を含む場合" {
    It "おふとんP" {
      $actual = Find-Speaker("おふとんP")
      $actual.uuid | should -Be "a60ebf6c-626a-7ce6-5d69-c92bf2a1a1d0"
      $actual.styleId | should -Be 2
    }
  
    It "おふとんP+" {
      $actual = Find-Speaker("おふとんP+")
      $actual.uuid | should -Be "a61d6124-c2c1-48de-9afe-c675508f4789"
      $actual.styleId | should -Be 22
    }
  }

  Context "一方が他方のスタイル名を含む場合" {
    It "おふとんP+ (きざ)" {
      $actual = Find-Speaker("おふとんP+ (きざ)")
      $actual.uuid | should -Be "a61d6124-c2c1-48de-9afe-c675508f4789"
      $actual.styleId | should -Be 23
    }
  
    It "おふとんP+ (きざささやき)" {
      $actual = Find-Speaker("おふとんP+ (きざささやき)")
      $actual.uuid | should -Be "a61d6124-c2c1-48de-9afe-c675508f4789"
      $actual.styleId | should -Be 24
    }
  }
  
}
