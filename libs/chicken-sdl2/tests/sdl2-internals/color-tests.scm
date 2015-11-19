
(test-begin "color")


(test-group "sdl2:make-color"
  (test-assert (sdl2:color? (sdl2:make-color)))
  (test 0 (sdl2:color-r (sdl2:make-color)))
  (test 0 (sdl2:color-g (sdl2:make-color)))
  (test 0 (sdl2:color-b (sdl2:make-color)))
  (test 255 (sdl2:color-a (sdl2:make-color)))

  (test-assert (sdl2:color? (sdl2:make-color 1)))
  (test 1 (sdl2:color-r (sdl2:make-color 1)))
  (test 0 (sdl2:color-g (sdl2:make-color 1)))
  (test 0 (sdl2:color-b (sdl2:make-color 1)))
  (test 255 (sdl2:color-a (sdl2:make-color 1)))

  (test-assert (sdl2:color? (sdl2:make-color 1 2 3 4)))
  (test 1 (sdl2:color-r (sdl2:make-color 1 2 3 4)))
  (test 2 (sdl2:color-g (sdl2:make-color 1 2 3 4)))
  (test 3 (sdl2:color-b (sdl2:make-color 1 2 3 4)))
  (test 4 (sdl2:color-a (sdl2:make-color 1 2 3 4))))


(test-group "sdl2:color?"
  (test-assert (sdl2:color? (sdl2:make-color)))
  (test-assert (sdl2:color? (sdl2:make-color 1 2 3 4)))
  (test-assert (not (sdl2:color? '(1 2 3 4))))
  (test-assert (not (sdl2:color? #(1 2 3 4))))
  (test-assert (not (sdl2:color? (sdl2:make-point)))))


(test-integer-struct-fields
 make: (sdl2:make-color)
 freer: sdl2:free-color!
 (x
  getter: sdl2:color-r
  setter: sdl2:color-r-set!
  min: Uint8-min
  max: Uint8-max)
 (y
  getter: sdl2:color-g
  setter: sdl2:color-g-set!
  min: Uint8-min
  max: Uint8-max)
 (w
  getter: sdl2:color-b
  setter: sdl2:color-b-set!
  min: Uint8-min
  max: Uint8-max)
 (h
  getter: sdl2:color-a
  setter: sdl2:color-a-set!
  min: Uint8-min
  max: Uint8-max))


(test-group "sdl2:color-set!"
  (let ((color (sdl2:make-color)))
    (test-assert "returns the color"
                 (eq? color (sdl2:color-set! color 5 6 7 8))))
  (test "sets all fields if all values are specified"
        '(5 6 7 8)
        (sdl2:color->list
         (sdl2:color-set! (sdl2:make-color 1 2 3 4) 5 6 7 8)))
  (test "does not change fields where the value is omitted"
        '(5 6 3 4)
        (sdl2:color->list
         (sdl2:color-set! (sdl2:make-color 1 2 3 4) 5 6)))
  (test "has no effect if all values are omitted"
        '(1 2 3 4)
        (sdl2:color->list
         (sdl2:color-set! (sdl2:make-color 1 2 3 4))))
  (test "does not change fields where the value is #f"
        '(1 8 3 9)
        (sdl2:color->list
         (sdl2:color-set! (sdl2:make-color 1 2 3 4) #f 8 #f 9)))
  (test "has no effect if all values are #f"
        '(1 2 3 4)
        (sdl2:color->list
         (sdl2:color-set! (sdl2:make-color 1 2 3 4) #f #f #f #f))))


(test-group "sdl2:alloc-color"
  (let ((color (sdl2:alloc-color)))
    (test-assert (sdl2:color? color))
    (test-assert (integer? (sdl2:color-r color)))
    (test-assert (integer? (sdl2:color-g color)))
    (test-assert (integer? (sdl2:color-b color)))
    (test-assert (integer? (sdl2:color-a color)))))

(test-group "sdl2:alloc-color*"
  (let ((color (sdl2:alloc-color*)))
    (test-assert (sdl2:color? color))
    (test-assert (integer? (sdl2:color-r color)))
    (test-assert (integer? (sdl2:color-g color)))
    (test-assert (integer? (sdl2:color-b color)))
    (test-assert (integer? (sdl2:color-a color)))
    (sdl2:free-color! color)))


(test-group "sdl2:free-color!"
  (let ((color (sdl2:make-color)))
    (sdl2:free-color! color)
    (test-assert "sets the record's pointer to null"
                 (sdl2:struct-null? color)))

  (let ((color (sdl2:make-color)))
    (test-assert "returns the same instance"
                 (eq? color (sdl2:free-color! color)))
    (test-assert "is safe to use multiple times on the same color"
                 (eq? color (sdl2:free-color! color))))

  (test-error (sdl2:free-color! 0))
  (test-error (sdl2:free-color! #f))
  (test-error (sdl2:free-color! '(1 2 3 4)))
  (test-error (sdl2:free-color! (sdl2:make-point))))


(test-group "aliases"
  (test-assert (eq? sdl2:colour?       sdl2:color?))
  (test-assert (eq? sdl2:free-colour!  sdl2:free-color!))
  (test-assert (eq? sdl2:alloc-colour* sdl2:alloc-color*))
  (test-assert (eq? sdl2:alloc-colour  sdl2:alloc-color))
  (test-assert (eq? sdl2:colour-r      sdl2:color-r))
  (test-assert (eq? sdl2:colour-g      sdl2:color-g))
  (test-assert (eq? sdl2:colour-b      sdl2:color-b))
  (test-assert (eq? sdl2:colour-a      sdl2:color-a))
  (test-assert (eq? sdl2:colour-r-set! sdl2:color-r-set!))
  (test-assert (eq? sdl2:colour-g-set! sdl2:color-g-set!))
  (test-assert (eq? sdl2:colour-b-set! sdl2:color-b-set!))
  (test-assert (eq? sdl2:colour-a-set! sdl2:color-a-set!))
  (test-assert (eq? sdl2:make-colour   sdl2:make-color))
  (test-assert (eq? sdl2:colour-set!   sdl2:color-set!))
  (test-assert (eq? sdl2:colour->list  sdl2:color->list))

  (let ((colour (sdl2:make-colour 1 2 3 4)))
    (set! (sdl2:colour-r colour) 5)
    (set! (sdl2:colour-g colour) 6)
    (set! (sdl2:colour-b colour) 7)
    (set! (sdl2:colour-a colour) 8)
    (test '(5 6 7 8) (sdl2:colour->list colour))))


(test-end "color")
