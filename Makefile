DEPS = libs/defstruct.o libs/matchable.o libs/sdl2.o libs/sdl2-internals.o libs/sdl2-image.o

CSCFLAGS = -O3 -d0 -disable-interrupts

SDLCFLAGS != sdl2-config --cflags
SDLLDFLAGS != sdl2-config --libs

CFLAGS = ${SDLCFLAGS}
LDFLAGS = ${SDLLDFLAGS} -lSDL2_image

crepe: crepe.scm logic.scm ${DEPS}
	csc -static-libs -O5 -strip -uses sdl2 -uses sdl2-image -uses defstruct -uses matchable crepe.scm ${DEPS} ${LDFLAGS}

libs/defstruct.o: libs/defstruct.scm
	csc $< ${CSCFLAGS} -c -J -unit defstruct -o $@

libs/matchable.o: libs/matchable.scm
	csc $< ${CSCFLAGS} -c -J -unit matchable -o $@

libs/sdl2.o: libs/chicken-sdl2/sdl2.scm libs/sdl2-internals.o
	${MAKE} -C libs/chicken-sdl2/ CSCFLAGS="${CSCFLAGS}" sdl2.o
	mv libs/chicken-sdl2/sdl2.o libs/chicken-sdl2/sdl2.import.scm libs/

libs/sdl2-internals.o: libs/chicken-sdl2/sdl2-internals.scm
	${MAKE} -C libs/chicken-sdl2/ CSCFLAGS="${CSCFLAGS}" CFLAGS="${CFLAGS}" sdl2-internals.o
	mv libs/chicken-sdl2/sdl2-internals.o libs/chicken-sdl2/sdl2-internals.import.scm libs/

libs/sdl2-image.o: libs/chicken-sdl2-image/sdl2-image.scm
	${MAKE} -C libs/chicken-sdl2-image/ CSCFLAGS="${CSCFLAGS}" CFLAGS="${CFLAGS}" sdl2-image.o
	mv libs/chicken-sdl2-image/sdl2-image.o libs/chicken-sdl2-image/sdl2-image.import.scm libs/

clean:
	rm -f crepe libs/*.o libs/*.import.* *.import.*
