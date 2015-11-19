
(test-begin "point")


(test-group "sdl2:make-point"
  (test-assert (sdl2:point? (sdl2:make-point)))
  (test 0 (sdl2:point-x (sdl2:make-point)))
  (test 0 (sdl2:point-y (sdl2:make-point)))

  (test-assert (sdl2:point? (sdl2:make-point 1)))
  (test 1 (sdl2:point-x (sdl2:make-point 1)))
  (test 0 (sdl2:point-y (sdl2:make-point 1)))

  (test-assert (sdl2:point? (sdl2:make-point 1 2)))
  (test 1 (sdl2:point-x (sdl2:make-point 1 2)))
  (test 2 (sdl2:point-y (sdl2:make-point 1 2))))


(test-group "sdl2:point?"
  (test-assert (sdl2:point? (sdl2:make-point)))
  (test-assert (sdl2:point? (sdl2:make-point 1 2)))
  (test-assert (not (sdl2:point? '(1 2))))
  (test-assert (not (sdl2:point? #(1 2))))
  (test-assert (not (sdl2:point? (sdl2:make-rect)))))


(test-integer-struct-fields
 make: (sdl2:make-point)
 freer: sdl2:free-point!
 (x
  getter: sdl2:point-x
  setter: sdl2:point-x-set!
  min: Sint32-min
  max: Sint32-max)
 (y
  getter: sdl2:point-y
  setter: sdl2:point-y-set!
  min: Sint32-min
  max: Sint32-max))


(test-group "sdl2:point-set!"
  (let ((point (sdl2:make-point)))
    (test-assert "returns the point"
                 (eq? point (sdl2:point-set! point 3 4))))
  (test "sets all fields if all values are specified"
        '(3 4)
        (sdl2:point->list
         (sdl2:point-set! (sdl2:make-point 1 2) 3 4)))
  (test "does not change fields where the value is omitted"
        '(3 2)
        (sdl2:point->list
         (sdl2:point-set! (sdl2:make-point 1 2) 3)))
  (test "has no effect if all values are omitted"
        '(1 2)
        (sdl2:point->list
         (sdl2:point-set! (sdl2:make-point 1 2))))
  (test "does not change fields where the value is #f"
        '(1 4)
        (sdl2:point->list
         (sdl2:point-set! (sdl2:make-point 1 2) #f 4)))
  (test "has no effect if all values are #f"
        '(1 2)
        (sdl2:point->list
         (sdl2:point-set! (sdl2:make-point 1 2) #f #f))))


(test-group "sdl2:alloc-point"
  (let ((point (sdl2:alloc-point)))
    (test-assert (sdl2:point? point))
    (test-assert (integer? (sdl2:point-x point)))
    (test-assert (integer? (sdl2:point-y point)))))

(test-group "sdl2:alloc-point*"
  (let ((point (sdl2:alloc-point*)))
    (test-assert (sdl2:point? point))
    (test-assert (integer? (sdl2:point-x point)))
    (test-assert (integer? (sdl2:point-y point)))
    (sdl2:free-point! point)))


(test-group "sdl2:free-point!"
  (let ((point (sdl2:make-point)))
    (sdl2:free-point! point)
    (test-assert "sets the record's pointer to null"
                 (sdl2:struct-null? point)))

  (let ((point (sdl2:make-point)))
    (test-assert "returns the same instance"
                 (eq? point (sdl2:free-point! point)))
    (test-assert "is safe to use multiple times on the same point"
                 (eq? point (sdl2:free-point! point))))

  (test-error (sdl2:free-point! 0))
  (test-error (sdl2:free-point! #f))
  (test-error (sdl2:free-point! '(1 2)))
  (test-error (sdl2:free-point! (sdl2:make-rect))))


(test-end "point")
