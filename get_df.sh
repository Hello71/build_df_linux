#!/bin/sh
DF_VER=40_09

set -e

if [ -x ./build.sh ]; then
    BUILD="./build.sh"
elif [ -f Makefile ]; then
    BUILD="make $MAKEFLAGS"
else
    echo "You must select a build system, see README for details." >&2
    exit 1
fi

unpack() {
    tar -xj --exclude="df" --exclude="libs/*.so*" --exclude="README.linux" --exclude="sdl" --strip-components=1 "$@"
}

if [ -n "$1" ]; then
    echo "Unpacking Dwarf Fortress from ${1}..." >&2
    unpack -f "$1"
else
    echo "Downloading and unpacking Dwarf Fortress..." >&2
    curl http://www.bay12games.com/dwarves/df_${DF_VER}_linux.tar.bz2 | unpack
fi

echo "Building Dwarf Fortress..." >&2
exec $BUILD
