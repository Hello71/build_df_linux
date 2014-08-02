#!/bin/sh
[ "$(git rev-parse --abbrev-ref HEAD)" = master ] && exit 0
sudo apt-get update
sudo apt-get install build-essential libglew-dev:i386 libglu-dev:i386 \
    libgtk2.0-dev:i386 libopenal-dev:i386 libsdl1.2-dev:i386 \
    libsdl-image1.2-dev:i386 libsdl-ttf2.0-dev:i386 libsndfile1-dev:i386 \
    zlib1g-dev:i386
