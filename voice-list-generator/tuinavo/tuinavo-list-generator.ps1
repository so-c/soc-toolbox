# usage: 下記のように配置して実行
# .\
#   + tuinavo-list-generator.ps1
#   + zip-archives\
#       + [a-z0-9]+_Sample_voice_[0-9]{2}_wav_.zip

Push-Location
Set-Location $PSScriptRoot

if (Test-Path .\wav) {
    Remove-Item .\wav -Force -Confirm:$false -Recurse
}
New-Item .\wav -ItemType Directory

Add-Type -AssemblyName System.IO.Compression.FileSystem
function Expand-MacZip($zipPath) {
    $archive = [System.IO.Compression.ZipFile]::OpenRead($zipPath)
    foreach($e in $archive.Entries) {
        if ($e.FullName.EndsWith('/')) {
            $dirName = "wav\" + $e.FullName.TrimEnd('/') + "\"
            
            New-Item -Path $dirName -ItemType Directory
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

Get-ChildItem .\zip-archives\*.zip | ForEach-Object {
    Expand-MacZip($_.FullName)
}

# ファイル名置換は止めて表示名だけ置換する
# ファイル名に使えない文字があるので（例：'/'）
Get-ChildItem .\wav\ -Recurse -Include *.wav | Rename-Item -NewName {$_.name -replace '&#x2c7;', 'ˇ'}
Get-ChildItem .\wav\ -Recurse -Include *.wav | Rename-Item -NewName { $_.name -replace '#x2661;', '♡' }

Pop-Location