class PitagoeRecordExvo {
    $FilePath
    [string]$DisplayName
    [string]$Serifu
    [string]$Yomigana
    [string]$Category

    static $displayNumbers
    static $yomiganaDic
    static PitagoeRecordExvo() {
        [PitagoeRecordExvo]::displayNumbers = (Get-Content $PSScriptRoot\displayNumbersExvo.json | ConvertFrom-Json)
        [PitagoeRecordExvo]::yomiganaDic = (Get-Content $PSScriptRoot\yomiganaExvo.json | ConvertFrom-Json)
    }

    [string] GetSerif([string]$baseName) {
        $ret = $baseName

        $dic = [PitagoeRecordExvo]::replaceTable
        foreach ($key in $dic.keys) {
            $ret = $ret.Replace($key, $dic[$key])
        }

        $reDic = [PitagoeRecordExvo]::reReplaceTable
        foreach ($key in $reDic.keys) {
            $ret = $ret.Replace($key, $reDic[$key])
        }

        return $ret
    }

    [string] GetCategory($relativePath) {
        $leafDirectory = (Split-Path $relativePath -Parent | Split-Path -Leaf)
        if ($leafDirectory -eq "ついなちゃんCF特典追加ボイス：追加300種") {
            return "追加300種"
        } else {
            return $leafDirectory
        }
    }

    [string] GetDisplayName($relativePath, $baseName) {
        return [PitagoeRecordExvo]::displayNumbers.$relativePath + " " + $this.GetSerif($BaseName)
    }

    [string] GetYomigana($relativePath) {
        return [PitagoeRecordExvo]::yomiganaDic.$relativePath
    }

    PitagoeRecordExvo(
        $f,
        [string]$bn,
        [string]$y,
        [string]$c
    ) {
        $this.FilePath = $f
        $this.DisplayName = $this.GetSerif($bn)
        $this.Serifu = $this.GetSerif($bn)
        $this.Yomigana = $y
        $this.Category = $c
    }

    PitagoeRecordExvo(
        $fsi
    ) {
        $relativePath = ((Split-Path $fsi.DirectoryName -Leaf) + "\" + $fsi.Name)
        $this.FilePath = $relativePath
        $this.DisplayName = $this.GetDisplayName($relativePath, $fsi.BaseName)
        $this.Serifu = $this.GetSerif($fsi.BaseName)
        $this.Yomigana = $this.GetYomigana($relativePath)
        $this.Category = $this.GetCategory($relativePath)
    }

    static [PitagoeRecordExvo[]] newPitagoeList([string]$pathToWavs) {
        if (-not $pathToWavs.EndsWith('\')) {
            $pathToWavs += '\'
        }

        $pitagoes = @()
        Get-ChildItem "${pathToWavs}*.wav" -Recurse | ForEach-Object {
            [PitagoeRecordExvo]$pitagoe = [PitagoeRecordExvo]::new($_)
            $pitagoes += $pitagoe
        }
        return $pitagoes
    }
}
