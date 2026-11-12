#-----------------------------------------------------------------------------
# TimePilot-CX16/web/build.ps1
# Builds the Commander X16 PRG with an external, self-fetched llvm-mos SDK.
#
# Set LLVM_MOS_SDK to an existing install directory to skip the download, or
# TIMEPILOT_TOOLS to choose the cache directory.  The SDK release and checksum
# are pinned so the same sources and compiler are used in CI.
#-----------------------------------------------------------------------------
$ErrorActionPreference = 'Stop'
$ProgressPreference = 'SilentlyContinue'

$here = Split-Path -Parent $MyInvocation.MyCommand.Path
$port = Split-Path -Parent $here
$repo = Split-Path -Parent $port
$src  = Join-Path $port 'src'
$inc  = Join-Path $here 'include'
$out  = Join-Path $here 'dist'

$version = 'v23.4.0'
$asset   = 'llvm-mos-windows.7z'
$url     = "https://github.com/llvm-mos/llvm-mos-sdk/releases/download/$version/$asset"
$sha     = '1ccfee003fd0cbbe9311b285ebb8c46548f036d3a32ac9cf2881fe46e9cb0a52'

$cache = if ($env:TIMEPILOT_TOOLS) { $env:TIMEPILOT_TOOLS } else { Join-Path $env:LOCALAPPDATA 'TimePilotWeb\toolchain' }
$sdk = if ($env:LLVM_MOS_SDK) { $env:LLVM_MOS_SDK } else { Join-Path $cache 'llvm-mos' }
$clang = Join-Path $sdk 'bin\mos-cx16-clang.bat'

if (-not (Test-Path $clang)) {
    Write-Host "llvm-mos SDK not found; fetching $version into $cache"
    New-Item -ItemType Directory -Force -Path $cache | Out-Null
    $archive = Join-Path $cache $asset
    if (-not (Test-Path $archive)) {
        & curl.exe -L --fail --max-time 600 --retry 5 --retry-delay 5 --retry-connrefused -o $archive $url
        if ($LASTEXITCODE -ne 0) { throw "Could not download $url" }
    }
    $actual = (Get-FileHash $archive -Algorithm SHA256).Hash.ToLowerInvariant()
    if ($actual -ne $sha) { throw "llvm-mos archive checksum mismatch: $actual" }

    $tmp = Join-Path $cache 'llvm-mos-extract'
    Remove-Item $tmp -Recurse -Force -ErrorAction SilentlyContinue
    New-Item -ItemType Directory -Force -Path $tmp | Out-Null
    # Windows bsdtar (libarchive) reads 7z archives.
    & tar.exe -xf $archive -C $tmp
    if ($LASTEXITCODE -ne 0) {
        throw "Could not extract $asset. Install 7-Zip or set LLVM_MOS_SDK to an SDK directory."
    }
    $found = Get-ChildItem $tmp -Recurse -Filter 'mos-cx16-clang.bat' | Select-Object -First 1
    if (-not $found) { throw "The archive did not contain mos-cx16-clang.bat" }
    $sdkRoot = Split-Path -Parent (Split-Path -Parent $found.FullName)
    if (Test-Path $sdk) { Remove-Item $sdk -Recurse -Force }
    Move-Item $sdkRoot $sdk
    Remove-Item $tmp -Recurse -Force
}

New-Item -ItemType Directory -Force -Path $out | Out-Null

$sources = Get-ChildItem $src -Filter '*.c' | Sort-Object Name | ForEach-Object { $_.FullName }
$args = @(
    '-Os',
    '-I', $src,
    '-I', $inc,
    '-include', (Join-Path $inc 'cx16_newapi_compat.h'),
    '-DTP_CX16_ASSET_PREFIX=""',
    '-DTP_CX16_NO_JOYSTICK=1',
    '-DTP_CX16_AUDIO_NONBLOCKING=1',
    '-o', (Join-Path $out 'time_pilot.prg')
) + $sources

Write-Host "Building Commander X16 PRG -> $out\time_pilot.prg"
& $clang @args
if ($LASTEXITCODE -ne 0) { throw 'mos-cx16-clang failed.' }

# Copy the flat HostFS assets the web player will expose at the drive root.
$assets = Join-Path $here 'assets'
New-Item -ItemType Directory -Force -Path $assets | Out-Null
Get-ChildItem (Join-Path $port 'assets') -File | ForEach-Object {
    Copy-Item $_.FullName (Join-Path $assets $_.Name.ToLowerInvariant()) -Force
}

Get-Item (Join-Path $out 'time_pilot.prg') | Select-Object FullName,Length
$assetCount = @(Get-ChildItem $assets -File).Count
Write-Host "Built $assetCount asset files."
