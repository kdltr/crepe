default: build

build:
	chicken-install -n

install:
	chicken-install

install-test:
	chicken-install -test

uninstall:
	chicken-uninstall sdl2-image

test:
	cd tests && csi -s run.scm

clean:
	rm -f *.import.scm *.types *.c *.o *.so

sdl2-image.o: sdl2-image.scm
	csc $< ${CSCFLAGS} -c -J -unit sdl2-image -uses sdl2-internals ${CFLAGS} -o $@
