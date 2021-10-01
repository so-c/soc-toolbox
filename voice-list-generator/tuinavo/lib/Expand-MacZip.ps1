Add-Type -AssemblyName System.IO.Compression.FileSystem
function NeedsSubDirectory {
    param (
        [string]$FullName
    )

    if ($FullName.EndsWith('_free/wav/') `
            -or $FullName.EndsWith('_for500/wav/') `
            -or $FullName.EndsWith('_for1000/wav/') `
            -or $FullName.EndsWith('for3万円プラン以上（wav）/')) {
        return $false
    }

    return $true
}

function Expand-MacZip {
    [CmdletBinding()]
    param (
        $zipPath
    )

    $noEntryDirs = @(
        "wav_SynthesizerV CF向け限定ボイス（5000円プラン以上向け）" # Zipファイルにエントリーが存在しない
    )
    foreach ($d in $noEntryDirs) {
        if (-not (Test-Path "${workDir}\wav\$d")) {
            New-Item -Path "${workDir}\wav\$d" -ItemType Directory > $null
        }
    }

    $archive = [System.IO.Compression.ZipFile]::OpenRead($zipPath)
    foreach ($e in $archive.Entries) {

        if ($e.FullName.Contains("/mp3") `
                -or $e.FullName.Contains("（mp3）/") `
                -or $e.FullName.Contains(".pdf")) {
            continue
        }

        if ($e.FullName.EndsWith('/')) {
            if (-not (NeedsSubDirectory($e.FullName))) {
                continue
            }
            $dirName = "$workDir\wav\" + ($e.FullName -replace '/', '\')
            New-Item -Path $dirName -ItemType Directory > $null
            continue
        }

        # Windowsのファイルシステムでは使えない文字の置換
        $entryName = $e.FullName.Normalize() -replace '/', '\'
        $entryName = $entryName -replace ':', '_'
        $entryName = $entryName -replace '!\?', '！？' # !？[半角・全角]は表示が乱れるのでペアで置換
        $entryName = $entryName -replace '\\wav', ''  # 第43回以降のフォルダ構造を第42回以前に合わせる
        $entryName = $entryName -replace '\\ついなちゃんサンプルボイス SynthesizerV_追加25種_for3万円プラン以上（wav）', ''  # SynthesizerV_追加25種_for3万円プラン以上対応
        $dest = [System.IO.Path]::Combine("$PSScriptRoot\..\wav", $entryName)
        try {
            [System.IO.Compression.ZipFileExtensions]::ExtractToFile($e, $dest, $true)
        }
        catch {
            Write-Host "$e to $dest"
            Write-Error ”パス：$dest”
            throw $PSItem
        }
    }
}
