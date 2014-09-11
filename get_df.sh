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

if [ -n "$1" ]; then
    f=${1##*/}
    [[ $f == df_??_??_linux.tar.bz2 ]] || echo "WARNING: $f does not look like an official DF tarball." >&2
    echo "Unpacking Dwarf Fortress from ${1}..." >&2
    unpack -f "$1"
else
    echo "Downloading and unpacking Dwarf Fortress..." >&2
    DF="$(curl http://www.bay12games.com/dwarves/ 2>/dev/null | grep -om1 'df_[0-9][0-9]_[0-9][0-9]_linux.tar.bz2')"
    curl http://www.bay12games.com/dwarves/"$DF_VER" | unpack
fi

echo "Building Dwarf Fortress..." >&2
exec $BUILD
