BeforeAll {
  . $PSScriptRoot\..\..\src\functions\Speakers.ps1
}

Describe "test" {
  It "「八蜂鞠ククリ」" {
    $actual = Find-Speaker("八蜂鞠ククリ")
    $actual.uuid | should -Be "8b8d4e5e-33bd-11ed-915b-0242ac1c0002"
    $actual.styleId | should -Be 653068302
  }
}
