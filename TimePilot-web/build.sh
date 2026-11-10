#!/usr/bin/env bash
#-----------------------------------------------------------------------------
# TimePilot-web/build.sh
# Self-contained POSIX build for the Time Pilot WebAssembly port.
#
# Downloads Emscripten into an external cache when it is not already available.
# Honors TIMEPILOT_EMSDK (existing checkout), TIMEPILOT_EMSDK_VERSION (pin) and
# TIMEPILOT_TOOLS (cache directory).
#-----------------------------------------------------------------------------
set -euo pipefail

here="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
repo="$(cd "$here/.." && pwd)"
src="$repo/TimePilot-16bit-C"
dist="$here/dist"

cache="${TIMEPILOT_TOOLS:-${XDG_CACHE_HOME:-$HOME/.cache}/timepilot-toolchain}"
emsdk="${TIMEPILOT_EMSDK:-$cache/emsdk}"
version="${TIMEPILOT_EMSDK_VERSION:-7.0.0}"
emcc="$emsdk/upstream/emscripten/emcc"

if [ ! -x "$emcc" ]; then
    echo "Emscripten not found; fetching SDK $version into $emsdk"
    mkdir -p "$cache"
    if [ ! -d "$emsdk/.git" ]; then
        git clone --depth 1 https://github.com/emscripten-core/emsdk.git "$emsdk"
    fi
    (
        cd "$emsdk"
        ./emsdk install "$version"
        ./emsdk activate "$version"
    )
fi

# shellcheck disable=SC1090
source "$emsdk/emsdk_env.sh" >/dev/null 2>&1 || true

mkdir -p "$dist/assets"

# Title art and site icon used by shell.html and by the landing page.
cp "$src/sprites/logo.png" "$dist/assets/timepilot-logo.png"
cp "$repo/TimePilot-IIgs/png/splash.png" "$dist/assets/timepilot-splash.png"
cp "$repo/web/assets/favicon.png" "$dist/assets/favicon.png"
cp "$repo/web/assets/favicon-180.png" "$dist/assets/favicon-180.png"

sources=(
    "$src/src/ai.c"
    "$src/src/audio.c"
    "$src/src/collide.c"
    "$src/src/data.c"
    "$src/src/draw.c"
    "$src/src/erase.c"
    "$src/src/game.c"
    "$src/src/globals.c"
    "$src/src/input.c"
    "$src/src/main.c"
    "$src/src/print.c"
    "$src/src/screen.c"
    "$src/src/text.c"
    "$src/src/things.c"
    "$src/src/tigr.c"
    "$src/src/ui.c"
)
existing=()
for source in "${sources[@]}"; do
    [ -f "$source" ] && existing+=("$source")
done

echo "Building Time Pilot WebAssembly -> $dist"
"$emcc" \
    -O2 -std=gnu11 -DTIGR_HEADLESS -DTP_WEB=1 \
    -I "$src/src" -I "$here/include" \
    -sASYNCIFY=1 \
    -sASYNCIFY_STACK_SIZE=262144 \
    -sALLOW_MEMORY_GROWTH=1 \
    -sINITIAL_MEMORY=67108864 \
    -sSTACK_SIZE=1048576 \
    -sFORCE_FILESYSTEM=1 \
    -sEXPORTED_RUNTIME_METHODS=FS \
    -sENVIRONMENT=web \
    -sEXIT_RUNTIME=0 \
    --preload-file "$src/sprites@sprites" \
    --preload-file "$src/audio@audio" \
    --shell-file "$here/shell.html" \
    -o "$dist/index.html" \
    "${existing[@]}" "$here/src/web_platform.c" "$here/src/web_audio.c"

echo "Built $dist"
ls -lh "$dist"
