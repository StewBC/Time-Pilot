#-----------------------------------------------------------------------------
# TimePilot-web/build.ps1
# Self-contained Windows build for the Time Pilot WebAssembly port.
#
# The script fetches Emscripten into an external cache directory, so the repo
# contains no toolchain binaries and a fresh checkout can build on its own.
# Set TIMEPILOT_EMSDK to reuse an existing emsdk checkout, or
# TIMEPILOT_EMSDK_VERSION to pin a different Emscripten release.
#-----------------------------------------------------------------------------
$ErrorActionPreference = 'Stop'
$ProgressPreference = 'SilentlyContinue'

$here = Split-Path -Parent $MyInvocation.MyCommand.Path
$repo = Split-Path -Parent $here
$src  = Join-Path $repo 'TimePilot-16bit-C'
$dist = Join-Path $here 'dist'

$cache = if ($env:TIMEPILOT_TOOLS) { $env:TIMEPILOT_TOOLS } else { Join-Path $env:LOCALAPPDATA 'TimePilotWeb\toolchain' }
$emsdk = if ($env:TIMEPILOT_EMSDK) { $env:TIMEPILOT_EMSDK } else { Join-Path $cache 'emsdk' }
$version = if ($env:TIMEPILOT_EMSDK_VERSION) { $env:TIMEPILOT_EMSDK_VERSION } else { '7.0.0' }
$emcc = Join-Path (Join-Path $emsdk 'upstream\emscripten') 'emcc.exe'

if (-not (Test-Path $emcc)) {
    Write-Host "Emscripten not found; fetching SDK $version into $emsdk"
    New-Item -ItemType Directory -Force -Path $cache | Out-Null
    if (-not (Test-Path (Join-Path $emsdk '.git'))) {
        git clone --depth 1 https://github.com/emscripten-core/emsdk.git $emsdk
        if ($LASTEXITCODE -ne 0) { throw 'Could not clone emsdk.' }
    }
    Push-Location $emsdk
    try {
        python emsdk.py install $version
        if ($LASTEXITCODE -ne 0) { throw "Could not install Emscripten $version." }
        python emsdk.py activate $version
        if ($LASTEXITCODE -ne 0) { throw "Could not activate Emscripten $version." }
    } finally {
        Pop-Location
    }
}

# emcc needs its bundled node/python; emsdk records them next to emcc.
$env:EMSDK = $emsdk
$upstream = Join-Path $emsdk 'upstream'
if (Test-Path (Join-Path $upstream 'emscripten')) {
    $env:EMSDK_PYTHON = Join-Path (Join-Path $emsdk 'python') '3.13.3_64bit\python.exe'
    if (Test-Path $env:EMSDK_PYTHON) { $env:PATH = (Split-Path $env:EMSDK_PYTHON) + ';' + $env:PATH }
    $node = Get-ChildItem (Join-Path $emsdk 'node') -Directory -ErrorAction SilentlyContinue | Select-Object -First 1
    if ($node) { $env:PATH = $node.FullName + ';' + $env:PATH }
}

New-Item -ItemType Directory -Force -Path $dist | Out-Null
$distAssets = Join-Path $dist 'assets'
New-Item -ItemType Directory -Force -Path $distAssets | Out-Null

# Title art and site icon used by shell.html and by the landing page.
Copy-Item (Join-Path $src 'sprites\logo.png')       (Join-Path $distAssets 'timepilot-logo.png') -Force
Copy-Item (Join-Path $repo 'TimePilot-IIgs\png\splash.png') (Join-Path $distAssets 'timepilot-splash.png') -Force
Copy-Item (Join-Path $repo 'web\assets\favicon.png') (Join-Path $distAssets 'favicon.png') -Force
Copy-Item (Join-Path $repo 'web\assets\favicon-180.png') (Join-Path $distAssets 'favicon-180.png') -Force

$sources = @(
    (Join-Path $src 'src\ai.c'),
    (Join-Path $src 'src\audio.c'),
    (Join-Path $src 'src\collide.c'),
    (Join-Path $src 'src\data.c'),
    (Join-Path $src 'src\draw.c'),
    (Join-Path $src 'src\erase.c'),
    (Join-Path $src 'src\game.c'),
    (Join-Path $src 'src\globals.c'),
    (Join-Path $src 'src\input.c'),
    (Join-Path $src 'src\main.c'),
    (Join-Path $src 'src\print.c'),
    (Join-Path $src 'src\screen.c'),
    (Join-Path $src 'src\text.c'),
    (Join-Path $src 'src\things.c'),
    (Join-Path $src 'src\tigr.c'),
    (Join-Path $src 'src\ui.c')
)
# Only include sources that exist, so this keeps working if a file is renamed.
$sources = $sources | Where-Object { Test-Path $_ }
$webSources = @(
    (Join-Path $here 'src\web_platform.c'),
    (Join-Path $here 'src\web_audio.c')
)

$args = @(
    '-O2', '-std=gnu11', '-DTIGR_HEADLESS', '-DTP_WEB=1',
    '-I', (Join-Path $src 'src'),
    '-I', (Join-Path $here 'include'),
    '-sASYNCIFY=1',
    '-sASYNCIFY_STACK_SIZE=262144',
    '-sALLOW_MEMORY_GROWTH=1',
    '-sINITIAL_MEMORY=67108864',
    '-sSTACK_SIZE=1048576',
    '-sFORCE_FILESYSTEM=1',
    '-sEXPORTED_RUNTIME_METHODS=FS',
    '-sENVIRONMENT=web',
    '-sEXIT_RUNTIME=0',
    '--preload-file', ((Join-Path $src 'sprites') + '@sprites'),
    '--preload-file', ((Join-Path $src 'audio') + '@audio'),
    '--shell-file', (Join-Path $here 'shell.html'),
    '-o', (Join-Path $dist 'index.html')
) + $sources + $webSources

Write-Host "Building Time Pilot WebAssembly -> $dist"
& $emcc @args
if ($LASTEXITCODE -ne 0) { throw 'emcc failed.' }

Write-Host "Built $dist"
Get-ChildItem $dist -File | ForEach-Object { Write-Host ("  {0}  {1:N0} bytes" -f $_.Name, $_.Length) }
