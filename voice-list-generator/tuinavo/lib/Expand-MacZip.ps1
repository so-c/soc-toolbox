Add-Type -AssemblyName System.IO.Compression.FileSystem
function Expand-MacZip {
    [CmdletBinding()]
    param (
        $zipPath
    )
    $archive = [System.IO.Compression.ZipFile]::OpenRead($zipPath)
    foreach ($e in $archive.Entries) {
        if ($e.FullName.EndsWith('/')) {
            $dirName = "wav\" + $e.FullName.TrimEnd('/') + "\"
            New-Item -Path $dirName -ItemType Directory > $null
            continue
        }
        $entryName = $e.FullName.Normalize() -replace '/', '\'
        # Windowsのファイルシステムでは使えない文字の置換
        $entryName = $entryName -replace ':', '_'
        $entryName = $entryName -replace "!\?", "！？" # !？[半角・全角]は表示が乱れるのでペアで置換
        # 濁音、半濁音の置換
        # TODO：
        # ad-hocなファイル名誤り修正
        $entryName = $entryName -replace '116 ウチが主催しとる妖怪系オンリー', 'ウチが主催しとる妖怪系オンリー'
        $dest = [System.IO.Path]::Combine((Resolve-Path ".\wav"), $entryName)
        try {
            [System.IO.Compression.ZipFileExtensions]::ExtractToFile($e, $dest, $true)
        }
        catch [System.NotSupportedException] {
            Write-Error ”パス：$dest”
            Write-Error $PSItem
        }
        catch {
            Set-Content "log.txt" -Value  $e -Encoding UTF8 
            Set-Content "log2.txt" -Value  ”パス：$dest” -Encoding UTF8
            Write-Error $PSItem
        }
    }
}
