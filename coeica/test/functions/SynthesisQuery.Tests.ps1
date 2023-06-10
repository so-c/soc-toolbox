BeforeAll {
  . $PSScriptRoot\..\..\src\functions\SynthesisQuery.ps1
}

Describe "音声合成クエリのJSON文字列のテスト" {
  It "prosodyDetailにValueやCountなどが入らないことのテスト" {
    # Windows PowersShellのConvertTo-Json, ConvertFrom-Jsonの仕様上、
    # Arrayの取り扱いには特殊な処理が必要
    # https://stackoverflow.com/questions/20848507/why-does-powershell-give-different-result-in-one-liner-than-two-liner-when-conve/38212718#38212718
    $sut = [SynthesisQuery]::new(@{
        uuid    = ""
        styleId = 0 
      },
      "あ",
      @{})
    $actual = $sut.ToJsonString()
    $actual | Should -Match ([regex]::Escape('"prosodyDetail":[[{"phoneme":"a","hira":"あ","accent":0}]]'))
  }
}
