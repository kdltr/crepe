
;;; chicken-sdl2 test suite entry point.

(use (prefix sdl2 sdl2:)
     (prefix sdl2-internals sdl2:)
     test)


(include "test-helpers.scm")


(define Uint8-min   0)
(define Uint8-max   255)
(define Sint32-min -2147483648)
(define Sint32-max  2147483647)


(test-begin "module sdl2-internals")
(include "sdl2-internals/struct-tests.scm")
(include "sdl2-internals/color-tests.scm")
(include "sdl2-internals/keysym-tests.scm")
(include "sdl2-internals/point-tests.scm")
(include "sdl2-internals/rect-tests.scm")
(test-end "module sdl2-internals")


(test-begin "module sdl2")
(include "sdl2/surface-tests.scm")
(test-end "module sdl2")


(test-exit)
