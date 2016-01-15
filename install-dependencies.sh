#!/bin/sh

set -e

TMPDIR=`mktemp -d`
cd "$TMPDIR"

for p in chicken-sdl2 chicken-sdl2-image chicken-sdl2-mixer matchable defstruct; do
    git clone -b crepe-game git://upyum.com/${p}
    cd $p
    chicken-install -s
    cd ..
done

rm -rf "$TMPDIR"

