. "$PSScriptRoot\RS2DAction.ps1"

class RS2DChara {
    [string]${char-name} = ""
    [string]${char-desc} = ""
    [string]${copyrights} = ""
    $thumbnail = [PSCustomObject]@{
        "path"       = ""
        "img-base64" = ""
    }
    [RS2DAction[]]$actions = @()

    RS2DChara([string]$name) {
        $this.'char-name' = $name
    }

    
    [string]ToRS2D(){
        return ConvertTo-Json $this -Depth 3
    }

}
