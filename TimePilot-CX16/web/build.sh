#!/usr/bin/env bash
#-----------------------------------------------------------------------------
# TimePilot-CX16/web/build.sh
# Builds the Commander X16 PRG with an external, self-fetched llvm-mos SDK.
#
# LLVM_MOS_SDK points at an existing install; TIMEPILOT_TOOLS selects the cache.
# The SDK release and checksum are pinned so CI gets the same compiler.
#-----------------------------------------------------------------------------
set -euo pipefail

here="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
port="$(cd "$here/.." && pwd)"
repo="$(cd "$port/.." && pwd)"
src="$port/src"
inc="$here/include"
out="$here/dist"

version="v23.4.0"
asset="llvm-mos-linux.tar.xz"
url="https://github.com/llvm-mos/llvm-mos-sdk/releases/download/$version/$asset"
sha="0b1dbc8a2b15db88a1a400a687ea24cf1a38548c5ba9fdd61a473e4580ba00c1"

cache="${TIMEPILOT_TOOLS:-${XDG_CACHE_HOME:-$HOME/.cache}/timepilot-toolchain}"
sdk="${LLVM_MOS_SDK:-$cache/llvm-mos}"
clang="$sdk/bin/mos-cx16-clang"

if [ ! -x "$clang" ]; then
    echo "llvm-mos SDK not found; fetching $version into $cache"
    mkdir -p "$cache"
    archive="$cache/$asset"
    archive_valid=0
    if [ -f "$archive" ] && [ "$(sha256sum "$archive" | awk '{print $1}')" = "$sha" ]; then
        archive_valid=1
    fi
    if [ "$archive_valid" -eq 0 ]; then
        rm -f "$archive"
        # GitHub's release CDN occasionally returns 502/504.  Retry the
        # transfer and re-check the checksum instead of failing the build.
        for attempt in 1 2 3 4 5; do
            echo "  downloading $asset (attempt $attempt/5)"
            if curl -L --fail --max-time 600 --retry 3 --retry-delay 5 \
                    --retry-connrefused -o "$archive" "$url"; then
                if [ "$(sha256sum "$archive" | awk '{print $1}')" = "$sha" ]; then
                    archive_valid=1
                    break
                fi
                echo "  llvm-mos archive checksum mismatch; retrying" >&2
            fi
            rm -f "$archive"
            sleep 5
        done
    fi
    if [ "$archive_valid" -ne 1 ]; then
        echo "could not download a valid llvm-mos archive from $url" >&2
        exit 1
    fi
    tmp="$(mktemp -d)"
    tar -xJf "$archive" -C "$tmp"
    # The Linux release ships the target drivers as symlinks to mos-clang, so
    # follow links as well as regular files when locating the SDK root.
    found="$(find "$tmp" \( -type f -o -type l \) -name mos-cx16-clang | head -n 1)"
    if [ -z "$found" ]; then
        echo "The archive did not contain mos-cx16-clang" >&2
        exit 1
    fi
    sdk_root="$(dirname "$(dirname "$found")")"
    rm -rf "$sdk"
    mv "$sdk_root" "$sdk"
    rm -rf "$tmp"
fi

mkdir -p "$out" "$here/assets"

sources=()
while IFS= read -r source; do
    sources+=("$source")
done < <(find "$src" -maxdepth 1 -name '*.c' | sort)

echo "Building Commander X16 PRG -> $out/time_pilot.prg"
"$clang" \
    -Os \
    -I "$src" \
    -I "$inc" \
    -include "$inc/cx16_newapi_compat.h" \
    -DTP_CX16_ASSET_PREFIX='""' \
    -DTP_CX16_NO_JOYSTICK=1 \
    -DTP_CX16_AUDIO_NONBLOCKING=1 \
    -o "$out/time_pilot.prg" \
    "${sources[@]}"

# Copy the flat HostFS assets the web player exposes at the drive root.
shopt -s nullglob
for source in "$port/assets"/*; do
    name="$(basename "$source" | tr '[:upper:]' '[:lower:]')"
    cp "$source" "$here/assets/$name"
done
shopt -u nullglob

ls -lh "$out/time_pilot.prg"
echo "Built $(find "$here/assets" -maxdepth 1 -type f | wc -l) asset files."
