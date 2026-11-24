@echo off
setlocal
title Neural Companion - runtime installer
set "NCSELF=%~f0"
rem Installs the Neural Companion runtime (Python, Ollama, the AI and speech models) into %LOCALAPPDATA%\NeuralCompanion\Runtime.
rem Everything it runs is the PowerShell below this file's marker line; it only downloads from this mod's GitHub release
rem and checks the download's SHA-256 before installing.
powershell -NoProfile -ExecutionPolicy Bypass -Command "$t = Get-Content -LiteralPath $env:NCSELF -Raw; $m = '#PS' + '-BEGIN#'; try { iex $t.Substring($t.IndexOf($m) + $m.Length) } catch { Write-Host ''; Write-Host ('  STOPPED: ' + $_.Exception.Message) -ForegroundColor Red; exit 1 }"
echo.
pause
exit /b
#PS-BEGIN#

$ErrorActionPreference = 'Stop'
$ProgressPreference = 'SilentlyContinue'
$base   = 'https://github.com/brrrrrrr-max/NeuralCompanion/releases/download/runtime-1.0.0'
$parts  = @('NeuralCompanion_Runtime-1.0.0.zip.001', 'NeuralCompanion_Runtime-1.0.0.zip.002', 'NeuralCompanion_Runtime-1.0.0.zip.003', 'NeuralCompanion_Runtime-1.0.0.zip.004')
$sizes  = @(1600000000, 1600000000, 1600000000, 1593038425)
$zipSha = 'BD307ADAA5FC3F7F412BEDA1E06F48AC67A1453A1BD70CB054D6ED5AF7E01341'
$home2  = Join-Path $env:LOCALAPPDATA 'NeuralCompanion'
$target = Join-Path $home2 'Runtime'
$work   = Join-Path $home2 'runtime-download'
$prefix = 'UserData/NeuralCompanion_Runtime/'

function Say($t) { Write-Host $t }
Say ''
Say '  Neural Companion - runtime installer (its AI, voice and ears)'
Say '  It downloads about 6 GB from this mod''s GitHub page and installs it in:'
Say "  $target"
Say ''

if (Get-Process -ErrorAction SilentlyContinue | Where-Object { try { $_.Path -and $_.Path.StartsWith($target, [StringComparison]::OrdinalIgnoreCase) } catch { $false } }) {
    throw 'The runtime is running (BONELAB or the brain is open). Close BONELAB, then run this again.'
}
$drive = (Get-Item $env:LOCALAPPDATA).PSDrive
if ($drive.Free -lt 16GB) { throw ('Not enough free space on drive ' + $drive.Name + ': it needs about 16 GB while it installs (8 GB after). Free some space, then run this again.') }

New-Item -ItemType Directory -Force -Path $work | Out-Null
$curl = Get-Command curl.exe -ErrorAction SilentlyContinue
for ($i = 0; $i -lt $parts.Count; $i++) {
    $file = Join-Path $work $parts[$i]
    $want = [int64]$sizes[$i]
    for ($try = 1; $try -le 30; $try++) {
        $have = 0; if (Test-Path $file) { $have = (Get-Item $file).Length }
        if ($have -eq $want) { break }
        if ($have -gt $want) { Remove-Item $file -Force; $have = 0 }
        Say ("  Downloading part {0} of {1} ({2:N1} of {3:N1} GB)..." -f ($i + 1), $parts.Count, ($have / 1GB), ($want / 1GB))
        try {
            if ($curl) { & $curl.Source -L --fail --silent --show-error --retry 5 -C - -o $file ($base + '/' + $parts[$i]); if ($LASTEXITCODE -ne 0) { throw "curl exit $LASTEXITCODE" } }
            else { Invoke-WebRequest -UseBasicParsing -Uri ($base + '/' + $parts[$i]) -OutFile $file }
        } catch { Say ('    (the download stopped: ' + $_.Exception.Message + ' - trying again)'); Start-Sleep -Seconds ([Math]::Min(60, 3 * $try)) }
    }
    if ((Get-Item $file).Length -ne $want) { throw ('Part ' + ($i + 1) + ' would not download. Check your internet connection and run this again - it carries on where it stopped.') }
}

Say '  Joining the parts...'
$zip = Join-Path $work 'NeuralCompanion_Runtime-1.0.0.zip'
$out = [IO.File]::Create($zip)
try { foreach ($p in $parts) { $in = [IO.File]::OpenRead((Join-Path $work $p)); try { $in.CopyTo($out, 4MB) } finally { $in.Dispose() } } } finally { $out.Dispose() }
foreach ($p in $parts) { Remove-Item -Force -LiteralPath (Join-Path $work $p) }   # (frees 6 GB before unpacking)
Say '  Checking it (SHA-256)...'
if ((Get-FileHash -Algorithm SHA256 -LiteralPath $zip).Hash -ne $zipSha) {
    Remove-Item -Force -LiteralPath $zip
    throw 'The download was damaged (its SHA-256 is wrong). It was thrown away - run this again.'
}

Say '  Installing (a few minutes)...'
Add-Type -AssemblyName System.IO.Compression.FileSystem
$new = $target + '.new'
if (Test-Path $new) { Remove-Item -Recurse -Force -LiteralPath $new }
New-Item -ItemType Directory -Force -Path $new | Out-Null
$root = [IO.Path]::GetFullPath($new) + '\'
$z = [IO.Compression.ZipFile]::OpenRead($zip)
try {
    foreach ($e in $z.Entries) {
        if (-not $e.FullName.StartsWith($prefix) -or $e.FullName.EndsWith('/')) { continue }
        $dest = [IO.Path]::GetFullPath((Join-Path $new ($e.FullName.Substring($prefix.Length) -replace '/', '\')))
        if (-not $dest.StartsWith($root, [StringComparison]::OrdinalIgnoreCase)) { throw ('A file in the download points outside its folder: ' + $e.FullName) }
        New-Item -ItemType Directory -Force -Path ([IO.Path]::GetDirectoryName($dest)) | Out-Null
        [IO.Compression.ZipFileExtensions]::ExtractToFile($e, $dest, $true)
    }
} finally { $z.Dispose() }
if (-not (Test-Path (Join-Path $new 'python\pythonw.exe')) -or -not (Test-Path (Join-Path $new 'ollama\ollama.exe'))) { throw 'The runtime is incomplete after unpacking - run this again.' }
if (Test-Path $target) { Remove-Item -Recurse -Force -LiteralPath $target }
Rename-Item -LiteralPath $new -NewName 'Runtime'
Remove-Item -Recurse -Force -LiteralPath $work
Say ''
Say '  DONE. The Neural Companion runtime is installed.'
Say '  Start BONELAB (from your mod manager), then BoneMenu > Neural Companion > Start the brain.'
Say ('  To remove it later: delete ' + $target)
