(test-group "sdl2:struct-null?"
  (test-group "with sdl2:color"
    (test "returns #t if record pointer is null"
          #t
          (sdl2:struct-null?
           (sdl2:wrap-color (address->pointer 0))))
    (test "returns #f if record pointer is non-null"
          #f (sdl2:struct-null? (sdl2:make-color))))

  (test-group "with sdl2:event"
    (test "returns #t if record pointer is null"
          #t
          (sdl2:struct-null?
           (sdl2:wrap-event (address->pointer 0))))
    (test "returns #f if record pointer is non-null"
          #f
          (sdl2:struct-null? (sdl2:alloc-event))))

  (test-group "with sdl2:point"
    (test "returns #t if record pointer is null"
          #t
          (sdl2:struct-null?
           (sdl2:wrap-point (address->pointer 0))))
    (test "returns #f if record pointer is non-null"
          #f
          (sdl2:struct-null? (sdl2:make-point))))

  (test-group "with sdl2:rect"
    (test "returns #t if record pointer is null"
          #t
          (sdl2:struct-null?
           (sdl2:wrap-rect (address->pointer 0))))
    (test "returns #f if record pointer is non-null"
          #f
          (sdl2:struct-null? (sdl2:make-rect))))

  (test-group "with sdl2:surface"
    (test "returns #t if record pointer is null"
          #t
          (sdl2:struct-null?
           (sdl2:wrap-surface (address->pointer 0))))
    (let ((surface (sdl2:SDL_CreateRGBSurface 0 1 1 16 0 0 0 0)))
      (test "returns #f if record pointer is non-null"
            #f
            (sdl2:struct-null? surface))
      (sdl2:SDL_FreeSurface surface)))

  (test-group "with invalid types"
    (test-error "throws error if given a non-null pointer"
      (sdl2:struct-null?
       (sdl2:unwrap-rect (sdl2:make-rect))))
    (test-error "throws error if given a null pointer"
      (sdl2:struct-null? (address->pointer 0)))
    (test-error "throws error if given #f"
      (sdl2:struct-null? #f))
    (test-error "throws error if given a number"
      (sdl2:struct-null? 0))))
