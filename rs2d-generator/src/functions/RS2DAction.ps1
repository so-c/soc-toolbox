class RS2DAction {
    [string]$name = ""
    $n = [PSCustomObject]@{
        "path"       = ""
        "img-base64" = ""
    }
    $o = [PSCustomObject]@{
        "path"       = ""
        "img-base64" = ""
    }
    $c = [PSCustomObject]@{
        "path"       = ""
        "img-base64" = ""
    }

    RS2DAction([string]$name) {
        $this.name = $name
    }
}
