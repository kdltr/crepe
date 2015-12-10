REPO != csi -p '(repository-path)'

DEPS = ${REPO}/defstruct.o ${REPO}/matchable.o ${REPO}/sdl2.o ${REPO}/sdl2-internals.o ${REPO}/sdl2-image.o ${REPO}/sdl2-mixer.o

CSCFLAGS = -O3 -d0 -disable-interrupts

SDLCFLAGS != sdl2-config --cflags
SDLLDFLAGS != sdl2-config --libs

CFLAGS = ${SDLCFLAGS}
LDFLAGS = ${SDLLDFLAGS} -lSDL2_image -lSDL2_mixer


crepe: crepe.scm game.scm menu.scm logic.scm ${DEPS}
	csc crepe.scm -static-libs -O5 -strip -uses sdl2 -uses sdl2-internals -uses sdl2-image -uses sdl2-mixer -uses defstruct -uses matchable ${DEPS} ${LDFLAGS}

${DEPS}:
	@echo "You have to install the dependencies!"
	@exit 1

clean:
	rm -f crepe
