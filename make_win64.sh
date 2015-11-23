#!/bin/sh

set -ex

win64-chicken crepe.scm -output-file crepe.c -verbose

x86_64-w64-mingw32-gcc crepe.c -c -o crepe.o -I $HOME/target/win64/include/chicken/ -I $HOME/target/win64/SDL2-2.0.3/include/ -I $HOME/target/win64/SDL2_image-2.0.0/x86_64-w64-mingw32/include/SDL2/

x86_64-w64-mingw32-gcc -o crepe.exe crepe.o libs/defstruct.o libs/matchable.o -L $HOME/target/win64/lib/ -L $HOME/target/win64/SDL2-2.0.3/x86_64-w64-mingw32/lib/ -L $HOME/target/win64/SDL2_image-2.0.0/x86_64-w64-mingw32/lib/ -lchicken -lmingw32 -lSDL2main -lSDL2 -lSDL2_image
