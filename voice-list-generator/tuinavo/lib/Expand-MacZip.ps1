Add-Type -AssemblyName System.IO.Compression.FileSystem
function NeedsSubDirectory {
    param (
        [string]$FullName
    )

    if ($FullName.EndsWith('_free/wav/') -or $FullName.EndsWith('_for500/wav/') -or $FullName.EndsWith('_for1000/wav/')) {
        return $false
    }

    return $true
}

function Expand-MacZip {
    [CmdletBinding()]
    param (
        $zipPath
    )
    $archive = [System.IO.Compression.ZipFile]::OpenRead($zipPath)
    foreach ($e in $archive.Entries) {

        if ($e.FullName.Contains("/mp3")) {
            continue
        }

        if ($e.FullName.EndsWith('/')) {
            if (-not (NeedsSubDirectory($e.FullName))) {
                continue
            }
            $dirName = 'wav\' + ($e.FullName -replace '/', '\')
            New-Item -Path $dirName -ItemType Directory > $null
            continue
        }

        # Windowsのファイルシステムでは使えない文字の置換
        $entryName = $e.FullName.Normalize() -replace '/', '\'
        $entryName = $entryName -replace ':', '_'
        $entryName = $entryName -replace '!\?', '！？' # !？[半角・全角]は表示が乱れるのでペアで置換
        # 濁音、半濁音の置換
        # TODO：
        # ad-hocなファイル名誤り修正
        $entryName = $entryName -replace '116 ウチが主催しとる妖怪系オンリー', 'ウチが主催しとる妖怪系オンリー'
        $entryName = $entryName -replace '\\wav', '' # 第43回以降のフォルダ構造を第42回以前に合わせる
        $dest = [System.IO.Path]::Combine((Resolve-Path '.\wav'), $entryName)
        try {
            [System.IO.Compression.ZipFileExtensions]::ExtractToFile($e, $dest, $true)
        }
        catch [System.NotSupportedException] {
            Write-Host "$e to $dest"
            Write-Error ”パス：$dest”
            throw $PSItem
        }
    }
}
