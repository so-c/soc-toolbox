BeforeAll {
  . $PSScriptRoot\..\..\src\functions\Speakers.ps1
}

Describe "スピーカー名からUUIDとStyleIDを検索する機能のテスト" {
  It "「八蜂鞠ククリ」" {
    $actual = Find-Speaker("八蜂鞠ククリ")
    $actual.uuid | should -Be "8b8d4e5e-33bd-11ed-915b-0242ac1c0002"
    $actual.styleId | should -Be 653068302
  }

  It "つくよみちゃん（げんき）" {
    $actual = Find-Speaker("つくよみちゃん（げんき）")
    $actual.uuid | should -Be "3c37646f-3881-5374-2a83-149267990abc"
    $actual.styleId | should -Be 6
  }
}
