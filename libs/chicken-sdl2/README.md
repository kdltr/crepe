# chicken-sdl2

[CHICKEN Scheme](http://call-cc.org/) bindings to
[Simple DirectMedia Layer](http://libsdl.org/) 2 (SDL2).

- Version:     0.1 (in development)
- Project:     https://gitlab.com/chicken-sdl2/chicken-sdl2
- Issues:      https://gitlab.com/chicken-sdl2/chicken-sdl2/issues
- API Docs:    http://api.call-cc.org/doc/sdl2
- License:     [BSD 2-Clause](LICENSE-BSD.txt)
- Maintainer:  John Croisant (john+chicken at croisant dot net)


## Synopsis

chicken-sdl2 makes it easy to use Simple DirectMedia Layer (SDL)
version 2 from the CHICKEN Scheme language. SDL is a popular library
used in games and other media-rich software.

chicken-sdl2 provides a programmer-friendly, convenient, and
CHICKEN-idiomatic interface to SDL2. It takes care of the annoying
low-level C stuff for you, so you can focus on making your game.

If a feature you need is not yet available in chicken-sdl2, please
[file a feature request](CONTRIBUTING.md#filing-feature-requests) or
contact a maintainer, so we can prioritize adding it.


## Installation

This project is young, so these instructions are still quite sparse.
If you run into trouble installing chicken-sdl2, please
[file a support request](CONTRIBUTING.md#filing-support-requests) so
we can help you, and so we can improve the install process and
instructions for future users.

### Dependencies

chicken-sdl2 requires **SDL version 2.0.0 or higher**. It will not
work with SDL 1. (For SDL 1, try the
[sdl-base](http://wiki.call-cc.org/eggref/4/sdl-base) egg instead.)

chicken-sdl2 is expected to be compatible with any recent version of
CHICKEN Scheme 4 (e.g. 4.7 or higher). It might also work with some
earlier versions of CHICKEN 4.

### Installing from egg repository

chicken-sdl2 has not yet been submitted to the egg repository. For
now, you must install from source.

### Installing from source

To install chicken-sdl2, clone the repository or download the source
from the project page, then run this command from within the project's
directory (notice these are back ticks, not quotes):

```
SDL2_FLAGS=`sdl2-config --cflags --libs` chicken-install
```

If you do not have the sdl2-config helper program installed on your
computer, you may manually specify SDL-related compiler flags (notice
these are double quotes, not back ticks):

```
SDL2_FLAGS="-I/usr/local/include/SDL2 -L/usr/local/lib -lSDL2" chicken-install
```


## Demos and Examples

After you have installed chicken-sdl2, you can try compiling and
running chicken-sdl2 demos and examples.

The [demos directory](https://gitlab.com/chicken-sdl2/chicken-sdl2/tree/master/demos)
contains small programs demonstrating how to use various features
of chicken-sdl2. E.g. to compile and run the basics demo:

```
csc demos/basics.scm
demos/basics
```

The [chicken-sdl2-examples repository](https://gitlab.com/chicken-sdl2/chicken-sdl2-examples)
contains complete example games and programs made with chicken-sdl2.


## Related libraries

- [chicken-sdl2-image](https://gitlab.com/chicken-sdl2/chicken-sdl2-image):
  Bindings to [SDL_image](http://www.libsdl.org/projects/SDL_image/) 2


## Contributing

chicken-sdl2 is a volunteer effort, and your help is appreciated.
There are many ways to get involved in the project, whether you are an
experienced programmer or not. For more information about how you can
help, please see the [contribution guide](CONTRIBUTING.md).

Please be aware that all project participants are expected to abide by
the [Contributor Code of Conduct](CODE_OF_CONDUCT.md). We are
committed to making participation in this project a welcoming and
harassment-free experience.
