BeforeAll {
    . "$PSScriptRoot\..\..\src\functions\RS2DAction.ps1"
}

Describe "RS2DAction" {
    It "JSON文字列への変換" {
        $sut = [RS2DAction]::new("動作名")
        $sut.n.path = "パス"
        $sut.n."img-base64" = "base64文字列"

        $actual = ConvertTo-Json $sut -Compress
        $actual | Should -Be '{"name":"動作名","n":{"path":"パス","img-base64":"base64文字列"},"o":{"path":"","img-base64":""},"c":{"path":"","img-base64":""}}'                  
    }
}
