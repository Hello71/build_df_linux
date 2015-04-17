#!/bin/sh

set -e

if [ -x build.sh ]; then
    BUILD="./build.sh"
elif [ -f Makefile ]; then
    BUILD="make $MAKEFLAGS"
else
    echo "You must select a build system, see README for details." >&2
    echo "Run this script from the root of the build directory." >&2
    exit 1
fi

unpack() {
    tar -xj --exclude="df" --exclude="libs/*.so*" --exclude="README.linux" --exclude="sdl" --strip-components=1 "$@"
}

if [ -f "$1" ]; then
    f=${1##*/}
    case "$f" in
        df_??_??_linux.tar.bz2) ;;
        *) printf "WARNING: %s does not look like an official DF tarball, continuing anyways.\n" "$f" >&2
    esac
    printf "Unpacking Dwarf Fortress from %s...\n" "$1" >&2
    unpack -f "$1"
else
    maj="0."
    case "$1" in
    *.*.*)
        min="${1#${maj}}"
        DF="df_${min//./_}_linux.tar.bz2"
        ver="$1"
        ;;
    *)
        printf "No argument provided, finding latest DF version...\n" >&2
        DF="$(curl http://www.bay12games.com/dwarves/ 2>/dev/null | grep -Eom1 'df_[0-9]{2}_[0-9]{2}_linux\.tar\.bz2')"
        tmp="${df#df_}"
        tmp="${tmp%%_linux*}"
        ver="${maj}${tmp//_/.}"
    esac
    printf "Downloading and unpacking DF %s...\n" "$ver" >&2
    curl http://www.bay12games.com/dwarves/"$DF" | unpack
fi

printf "Done. You can now run \`%s' to build DF." "$BUILD"
