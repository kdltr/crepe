
(test-begin "rect")


(test-group "sdl2:make-rect"
  (test-assert (sdl2:rect? (sdl2:make-rect)))
  (test 0 (sdl2:rect-x (sdl2:make-rect)))
  (test 0 (sdl2:rect-y (sdl2:make-rect)))
  (test 0 (sdl2:rect-w (sdl2:make-rect)))
  (test 0 (sdl2:rect-h (sdl2:make-rect)))

  (test-assert (sdl2:rect? (sdl2:make-rect 1)))
  (test 1 (sdl2:rect-x (sdl2:make-rect 1)))
  (test 0 (sdl2:rect-y (sdl2:make-rect 1)))
  (test 0 (sdl2:rect-w (sdl2:make-rect 1)))
  (test 0 (sdl2:rect-h (sdl2:make-rect 1)))

  (test-assert (sdl2:rect? (sdl2:make-rect 1 2 3 4)))
  (test 1 (sdl2:rect-x (sdl2:make-rect 1 2 3 4)))
  (test 2 (sdl2:rect-y (sdl2:make-rect 1 2 3 4)))
  (test 3 (sdl2:rect-w (sdl2:make-rect 1 2 3 4)))
  (test 4 (sdl2:rect-h (sdl2:make-rect 1 2 3 4))))


(test-group "sdl2:rect?"
  (test-assert (sdl2:rect? (sdl2:make-rect)))
  (test-assert (sdl2:rect? (sdl2:make-rect 1 2 3 4)))
  (test-assert (not (sdl2:rect? '(1 2 3 4))))
  (test-assert (not (sdl2:rect? #(1 2 3 4))))
  (test-assert (not (sdl2:rect? (sdl2:make-point)))))


(test-integer-struct-fields
 make: (sdl2:make-rect)
 freer: sdl2:free-rect!
 (x
  getter: sdl2:rect-x
  setter: sdl2:rect-x-set!
  min: Sint32-min
  max: Sint32-max)
 (y
  getter: sdl2:rect-y
  setter: sdl2:rect-y-set!
  min: Sint32-min
  max: Sint32-max)
 (w
  getter: sdl2:rect-w
  setter: sdl2:rect-w-set!
  min: Sint32-min
  max: Sint32-max)
 (h
  getter: sdl2:rect-h
  setter: sdl2:rect-h-set!
  min: Sint32-min
  max: Sint32-max))


(test-group "sdl2:rect-set!"
  (let ((rect (sdl2:make-rect)))
    (test-assert "returns the rect"
                 (eq? rect (sdl2:rect-set! rect 5 6 7 8))))
  (test "sets all fields if all values are specified"
        '(5 6 7 8)
        (sdl2:rect->list
         (sdl2:rect-set! (sdl2:make-rect 1 2 3 4) 5 6 7 8)))
  (test "does not change fields where the value is omitted"
        '(5 6 3 4)
        (sdl2:rect->list
         (sdl2:rect-set! (sdl2:make-rect 1 2 3 4) 5 6)))
  (test "has no effect if all values are omitted"
        '(1 2 3 4)
        (sdl2:rect->list
         (sdl2:rect-set! (sdl2:make-rect 1 2 3 4))))
  (test "does not change fields where the value is #f"
        '(1 8 3 9)
        (sdl2:rect->list
         (sdl2:rect-set! (sdl2:make-rect 1 2 3 4) #f 8 #f 9)))
  (test "has no effect if all values are #f"
        '(1 2 3 4)
        (sdl2:rect->list
         (sdl2:rect-set! (sdl2:make-rect 1 2 3 4) #f #f #f #f))))


(test-group "sdl2:alloc-rect"
  (let ((rect (sdl2:alloc-rect)))
    (test-assert (sdl2:rect? rect))
    (test-assert (integer? (sdl2:rect-x rect)))
    (test-assert (integer? (sdl2:rect-y rect)))
    (test-assert (integer? (sdl2:rect-w rect)))
    (test-assert (integer? (sdl2:rect-h rect)))))

(test-group "sdl2:alloc-rect*"
  (let ((rect (sdl2:alloc-rect*)))
    (test-assert (sdl2:rect? rect))
    (test-assert (integer? (sdl2:rect-x rect)))
    (test-assert (integer? (sdl2:rect-y rect)))
    (test-assert (integer? (sdl2:rect-w rect)))
    (test-assert (integer? (sdl2:rect-h rect)))
    (sdl2:free-rect! rect)))


(test-group "sdl2:free-rect!"
  (let ((rect (sdl2:make-rect)))
    (sdl2:free-rect! rect)
    (test-assert "sets the record's pointer to null"
                 (sdl2:struct-null? rect)))

  (let ((rect (sdl2:make-rect)))
    (test-assert "returns the same instance"
                 (eq? rect (sdl2:free-rect! rect)))
    (test-assert "is safe to use multiple times on the same rect"
                 (eq? rect (sdl2:free-rect! rect))))

  (test-error (sdl2:free-rect! 0))
  (test-error (sdl2:free-rect! #f))
  (test-error (sdl2:free-rect! '(1 2 3 4)))
  (test-error (sdl2:free-rect! (sdl2:make-point))))


(test-end "rect")
