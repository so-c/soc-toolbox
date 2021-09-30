Add-Type -AssemblyName System.IO.Compression.FileSystem
function Expand-MacZip {
    [CmdletBinding()]
    param (
        $zipPath
    )
    $archive = [System.IO.Compression.ZipFile]::OpenRead($zipPath)
    foreach($e in $archive.Entries) {
        if ($e.FullName.EndsWith('/')) {
            $dirName = "wav\" + $e.FullName.TrimEnd('/') + "\"
            
            New-Item -Path $dirName -ItemType Directory > $null
            continue
        }
        $entryName = $e.FullName.Normalize() -replace '/', '\'
        $entryName = $entryName -replace ':', '_'

        $dest = [System.IO.Path]::Combine((Resolve-Path ".\wav"), $entryName)
        try {
            [System.IO.Compression.ZipFileExtensions]::ExtractToFile($e, $dest, $true)
        } catch [System.NotSupportedException] {
            Write-Error ”パス：$dest”
            Write-Error $PSItem
        }
    }
}
