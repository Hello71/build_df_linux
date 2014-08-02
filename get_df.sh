#!/bin/sh
DF_VER=40_05

set -e

unpack() {
    tar -xj --exclude="df" --exclude="libs/*.so*" --exclude="README.linux" --exclude="sdl" --strip-components=1 "$@"
}

if [[ -n "$1" ]]; then
    unpack -f "$1"
else
    curl http://www.bay12games.com/dwarves/df_${DF_VER}_linux.tar.bz2 | unpack
fi

[[ -x ./build.sh ]] && exec ./build.sh
[[ -f Makefile ]] && exec make "$MAKEFLAGS"
echo "You must select a build system, see README for details." >&2
exit 1
