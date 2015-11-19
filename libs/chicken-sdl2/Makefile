default: build

build:
	chicken-install -n

install:
	chicken-install

install-test:
	chicken-install -test

uninstall:
	chicken-uninstall sdl2

test:
	cd tests && csi -s run.scm

clean:
	rm -f *.import.scm *.types *.c *.o *.so

sdl2.o: sdl2.scm
	csc $< ${CSCFLAGS} -c -J -unit sdl2 -uses sdl2-internals -o $@

sdl2-internals.o: sdl2-internals.scm
	csc $< ${CSCFLAGS} -c -J -unit sdl2-internals -uses data-structures ${CFLAGS} -o $@
