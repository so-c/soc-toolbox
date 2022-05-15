BeforeAll {
    . "$PSScriptRoot\..\..\src\functions\RS2DAction.ps1"
    . "$PSScriptRoot\..\..\src\functions\RS2DChara.ps1"
}

Describe "RS2DAction" {
    It "JSON文字列への変換" {

        $sut = [RS2DChara]::new("キャラクター名")

        # action
        $a1 = [RS2DAction]::new("動作1")
        $a2 = [RS2DAction]::new("動作2")
        

        $sut.actions += $a1
        $sut.actions += $a2

        $actual = $sut.ToRS2D()

        Write-Host $actual

    }
}
