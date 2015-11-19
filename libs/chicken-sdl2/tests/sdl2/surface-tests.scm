
(test-begin "surface")


(test-group "sdl2:free-surface!"
  (let ((surface (sdl2:SDL_CreateRGBSurface 0 10 10 24 0 0 0 0)))
    (assert (not (sdl2:struct-null? surface)))
    (test "returns void"
          (void) (sdl2:free-surface! surface))
    (test-assert "nullifies the surface"
                 (sdl2:struct-null? surface)))

  (test-error "throws error if given non-surface"
              (sdl2:free-surface! (sdl2:make-rect))))



(test-group "sdl2:make-surface"
  (define test-make-surface-with-valid-depth
    (lambda (depth)
      (test-group (sprintf "depth ~A" depth)
        (let ((surface (sdl2:make-surface 10 20 depth)))
          (test-assert "creates and returns a new sdl2:surface"
            (and (sdl2:surface? surface)
                 (not (sdl2:struct-null? surface))))

          (test "surface has the correct width and height"
                '(10 20) (list (sdl2:surface-w surface)
                               (sdl2:surface-h surface)))

          (let ((format (sdl2:surface-format surface)))
            (test "surface has the correct depth"
                  depth (sdl2:pixel-format-bits-per-pixel format))

            (when (<= depth 8)
              (test "surface has all zero masks"
                    (list 0 0 0 0)
                    (list (sdl2:pixel-format-rmask format)
                          (sdl2:pixel-format-gmask format)
                          (sdl2:pixel-format-bmask format)
                          (sdl2:pixel-format-amask format)))
              (test-assert "surface has a palette"
                (not (sdl2:struct-null?
                      (sdl2:pixel-format-palette format)))))

            (when (<= 15 depth 24)
              (test-assert "surface has non-zero Rmask"
                (positive? (sdl2:pixel-format-rmask format)))
              (test-assert "surface has non-zero Gmask"
                (positive? (sdl2:pixel-format-gmask format)))
              (test-assert "surface has non-zero Bmask"
                (positive? (sdl2:pixel-format-bmask format)))
              (test-assert "surface has zero Amask"
                (zero? (sdl2:pixel-format-amask format))))

            (when (= depth 32)
              (test "surface has appropriate masks for system byte order"
                    (if (= sdl2:SDL_BYTEORDER sdl2:SDL_BIG_ENDIAN)
                        (list #xff000000
                              #x00ff0000
                              #x0000ff00
                              #x000000ff)
                        (list #x000000ff
                              #x0000ff00
                              #x00ff0000
                              #xff000000))
                    (list (sdl2:pixel-format-rmask format)
                          (sdl2:pixel-format-gmask format)
                          (sdl2:pixel-format-bmask format)
                          (sdl2:pixel-format-amask format)))))))))

  (for-each test-make-surface-with-valid-depth
            '(1 4 8 12 15 16 24 32))

  (test-error "throws error if width is not an integer"
    (sdl2:make-surface 10.5 20 32))
  (test-error "throws error if width is negative"
    (sdl2:make-surface -1 20 32))

  (test-error "throws error if height is not an integer"
    (sdl2:make-surface 10 20.5 32))
  (test-error "throws error if height is negative"
    (sdl2:make-surface 10 -1 32))

  (test-error "throws error if depth is not an integer"
    (sdl2:make-surface 10 20 24.5))
  (test-error "throws error if depth is negative"
    (sdl2:make-surface 10 20 -24)))



(test-end "surface")
