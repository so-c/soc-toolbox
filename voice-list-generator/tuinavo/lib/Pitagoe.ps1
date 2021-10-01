class PitagoeRecord {
    $FilePath
    [string]$DisplayName
    [string]$Serifu
    [string]$Yomigana
    [string]$Category

    PitagoeRecord(
        $f,
        [string]$dn,
        [string]$s,
        [string]$y,
        [string]$c
    ) {
        $this.FilePath = $f
        $this.DisplayName = $dn
        $this.Serifu = $s
        $this.Yomigana = $y
        $this.Category = $c
    }
}
