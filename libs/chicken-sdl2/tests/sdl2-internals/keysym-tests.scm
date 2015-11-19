
(test-begin "keysym")


(test-enum-field
 make: (sdl2:alloc-keysym)
 getter: (sdl2:keysym-scancode
          sdl2:keysym-scancode-raw)
 setter: (sdl2:keysym-scancode-set!
          sdl2:keysym-scancode-raw-set!)
 valid1: ('lang1
          sdl2:SDL_SCANCODE_LANG1)
 valid2: ('app1
          sdl2:SDL_SCANCODE_APP1)
 invalid: ('foobar
           1234))


(test-enum-field
 make: (sdl2:alloc-keysym)
 getter: (sdl2:keysym-sym
          sdl2:keysym-sym-raw)
 setter: (sdl2:keysym-sym-set!
          sdl2:keysym-sym-raw-set!)
 valid1: ('quote-dbl
          sdl2:SDLK_QUOTEDBL)
 valid2: ('at
          sdl2:SDLK_AT)
 invalid: ('foobar
           1234))


(test-group "sdl2:keysym-mod / sdl2:keysym-mod-set!"
  (let ((record (sdl2:alloc-keysym)))
    (sdl2:keysym-mod-raw-set! record 0)
    (test "Getter returns empty list if no masks match"
          '() (sdl2:keysym-mod record))

    (sdl2:keysym-mod-raw-set!
     record
     (bitwise-ior sdl2:KMOD_LSHIFT sdl2:KMOD_RALT sdl2:KMOD_CAPS))
    (test "Getter returns list of expected symbols"
          (sort-symbols '(shift lshift alt ralt caps))
          (sort-symbols (sdl2:keysym-mod record)))

    (test "Getter optional arg controls bitmask match exactness"
          (sort-symbols '(lshift ralt caps))
          (sort-symbols (sdl2:keysym-mod record #t)))

    (sdl2:keysym-mod-set! record '(alt shift))
    (test "Setting to list of recognized symbols works"
          (sort-symbols '(alt lalt ralt shift rshift lshift))
          (sort-symbols (sdl2:keysym-mod record)))

    (sdl2:keysym-mod-set! record (bitwise-ior sdl2:KMOD_RGUI sdl2:KMOD_NUM))
    (test "Setting to integer works"
          (sort-symbols '(gui rgui num))
          (sort-symbols (sdl2:keysym-mod record)))

    (test-error "Throws error if set to invalid type (symbol)"
                (sdl2:keysym-mod-set! record 'gui))
    (test-error "Throws error if set to invalid type (float)"
                (sdl2:keysym-mod-set! record 1.23))

    (test-error "Throws error if set to list containing unrecognized symbol"
                (sdl2:keysym-mod-set! record '(alt foo gui)))
    (test-error "Throws error if set to list containing integer"
                (sdl2:keysym-mod-set! record (list 'alt sdl2:KMOD_GUI)))))


(test-end "keysym")
