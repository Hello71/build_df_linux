==============
build_df_linux
==============

.. image:: https://travis-ci.org/Hello71/build_df_linux.png
  :target: https://travis-ci.org/Hello71/build_df_linux

This is yet another reimplementation of the Dwarf Fortress libgraphics.so build system.
There are two build options available, plain Makefile and autotools, with the former almost certainly working better on all Linux systems.
Select one with ``git checkout makefile`` or ``git checkout autotools``, then run get_df.sh with no arguments to download DF, or one argument to extract it from a pre-downloaded archive.
Manually extracting Dwarf Fortress is *NOT SUPPORTED*.
Do NOT copy all Dwarf Fortress files on top of this directory.

Requirements
============

Dwarf Fortress requires a sizable number of 32-bit libraries; the pkg-config names are given below.

- glew
- glu
- gtk+-2.0
- openal
- sdl
- SDL_image
- SDL_ttf
- sndfile
- zlib

Ubuntu 11.04 and before
-----------------------

Note: untested, probably does not contain important libraries.

::

    $ apt-get install build-essential ia32-libs

Ubuntu 11.10+
-------------

::

    $ apt-get install build-essential libglew-dev:i386 libglu-dev:i386 \
        libgtk2.0-dev:i386 libopenal-dev:i386 libsdl1.2-dev:i386 \
        libsdl-image1.2-dev:i386 libsdl-ttf2.0-dev:i386 libsndfile1-dev:i386 \
        zlib1g-dev:i386

Gentoo
------

https://bugs.gentoo.org/show_bug.cgi?id=290294

::

    $ emerge -o dwarf-fortress
