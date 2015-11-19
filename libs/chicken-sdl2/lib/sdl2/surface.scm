;;
;; chicken-sdl2: CHICKEN Scheme bindings to Simple DirectMedia Layer 2
;;
;; Copyright © 2013, 2015  John Croisant.
;; All rights reserved.
;;
;; Redistribution and use in source and binary forms, with or without
;; modification, are permitted provided that the following conditions
;; are met:
;;
;; - Redistributions of source code must retain the above copyright
;;   notice, this list of conditions and the following disclaimer.
;;
;; - Redistributions in binary form must reproduce the above copyright
;;   notice, this list of conditions and the following disclaimer in
;;   the documentation and/or other materials provided with the
;;   distribution.
;;
;; THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
;; "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
;; LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
;; FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE
;; COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT,
;; INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
;; (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
;; SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
;; HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
;; STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
;; ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED
;; OF THE POSSIBILITY OF SUCH DAMAGE.


(export free-surface!

        make-surface
        make-surface*
        create-rgb-surface
        create-rgb-surface-from

        convert-surface
        convert-surface*

        load-bmp
        load-bmp*
        load-bmp-rw
        load-bmp-rw*
        save-bmp!
        save-bmp-rw!

        lock-surface!
        unlock-surface!
        must-lock?

        blit-surface!
        blit-scaled!

        fill-rect!
        fill-rects!

        surface-ref  surface-set!
        surface-ref-raw

        surface-clip-rect   surface-clip-rect-set!
        surface-color-key   surface-color-key-set!
        surface-color-key-raw
        surface-colour-key  surface-colour-key-set!
        surface-colour-key-raw
        surface-alpha-mod   surface-alpha-mod-set!
        surface-blend-mode  surface-blend-mode-set!
        surface-color-mod   surface-color-mod-set!
        surface-colour-mod  surface-colour-mod-set!
        surface-palette     surface-palette-set!
        surface-rle-set!)



(define (%map-color-for-surface color surface fn-name)
  (cond
   ((color? color)
    (SDL_MapRGBA (surface-format surface)
                 (color-r color)
                 (color-g color)
                 (color-b color)
                 (color-a color)))
   ((and (integer? color)
         (not (negative? color)))
    color)
   (else
    (error fn-name
           "invalid color (expected sdl2:color or nonnegative integer)"
           color))))


(define (%unmap-color-for-surface pixel surface)
  (assert (and (integer? pixel) (not (negative? pixel))))
  (with-temp-mem ((r-out (%allocate-Uint8))
                  (g-out (%allocate-Uint8))
                  (b-out (%allocate-Uint8))
                  (a-out (%allocate-Uint8)))
    (SDL_GetRGBA pixel
                 (surface-format surface)
                 r-out g-out b-out a-out)
    (make-color (pointer-u8-ref r-out)
                    (pointer-u8-ref g-out)
                    (pointer-u8-ref b-out)
                    (pointer-u8-ref a-out))))



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; FREE SURFACE

(define (free-surface! surface)
  (assert (surface? surface))
  (SDL_FreeSurface surface)
  (%nullify-struct! surface)
  (void))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; MAKE / CREATE SURFACE

;;; Convenient way to create a new surface of a given size and pixel
;;; depth (bits per pixel). The surface RGBA masks will be chosen
;;; automatically based on the requested depth. The surface will have
;;; a palette if depth <= 8. The surface will automatically be freed
;;; by the garbage collector. Returns #f if the surface could not be
;;; created (use get-error to find out why).
(define (make-surface width height depth)
  (let ((surface (make-surface* width height depth)))
    (when surface
      (set-finalizer! surface free-surface!))
    surface))


;;; Like make-surface, except the surface will NOT automatically
;;; be freed by the garbage collector. You must manually free the
;;; surface (e.g. using free-surface!) when you are done with it.
(define (make-surface* width height depth)
  (assert (and (integer? width)  (positive? width)))
  (assert (and (integer? height) (positive? height)))
  (assert (and (integer? depth)  (positive? depth)))
  (let* ((masks (%surface-default-masks depth))
         (surface (SDL_CreateRGBSurface
                   0 width height depth
                   (list-ref masks 0)
                   (list-ref masks 1)
                   (list-ref masks 2)
                   (list-ref masks 3))))
    (if (and (surface? surface)
             (not (struct-null? surface)))
        surface
        #f)))

(define (%surface-default-masks depth)
  (if (= depth 32)
      ;; For depth 32, we need to give explicit masks because there
      ;; seems to be no way to specify a default alpha mask. For red,
      ;; green, and blue, 0 means to use the default, but for alpha, 0
      ;; means no alpha channel.
      (if (= SDL_BYTEORDER SDL_BIG_ENDIAN)
          (list #xff000000
                #x00ff0000
                #x0000ff00
                #x000000ff)
          (list #x000000ff
                #x0000ff00
                #x00ff0000
                #xff000000))
      ;; For other depths, just use 0 to tell SDL to use defaults.
      (list 0 0 0 0)))



(define (create-rgb-surface flags width height depth
                                rmask gmask bmask amask)
  (SDL_CreateRGBSurface flags width height depth
                        rmask gmask bmask amask))


(define (create-rgb-surface-from pixels width height depth pitch
                                     rmask gmask bmask amask)
  (SDL_CreateRGBSurfaceFrom pixels width height depth pitch
                            rmask gmask bmask amask))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; CONVERT SURFACE / PIXELS

(define (convert-surface surface format)
  (%autofree-struct!
   (convert-surface* surface format)
   free-surface!))


(define (convert-surface* surface format)
  (let ((surface (SDL_ConvertSurface surface format 0)))
    (if (and (surface? surface)
             (not (struct-null? surface)))
        surface
        #f)))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; LOAD / SAVE BMP

;;; Loads a BMP image file from the given file path (a string), and
;;; returns a new surface containing the image. The surface will
;;; automatically be freed by the garbage collector. Returns #f if the
;;; image could not be loaded (use get-error to find out why).
(define (load-bmp filepath)
  (let ((surface (load-bmp* filepath)))
    (when surface
      (set-finalizer! surface free-surface!))
    surface))

;;; Like load-bmp, except the surface will NOT automatically be
;;; freed by the garbage collector. You must manually free the surface
;;; (e.g. using free-surface!) when you are done with it.
(define (load-bmp* filepath)
  (let ((surface (SDL_LoadBMP filepath)))
    (if (and (surface? surface)
             (not (struct-null? surface)))
        surface
        #f)))


;;; Loads a BMP image file from the given sdl2:rwops, and returns a new
;;; surface containing the image. If close? is #t, rwops will be
;;; closed after reading. The surface will automatically be freed by
;;; the garbage collector. Returns #f if the image could not be loaded
;;; (use get-error to find out why).
(define (load-bmp-rw rwops #!optional close?)
  (let ((surface (load-bmp-rw* rwops close?)))
    (when surface
      (set-finalizer! surface free-surface!))
    surface))

;;; Like load-bmp-rw, except the surface will NOT automatically be
;;; freed by the garbage collector. You must manually free the surface
;;; (e.g. using free-surface!) when you are done with it.
(define (load-bmp-rw* rwops #!optional close?)
  (let ((surface (SDL_LoadBMP_RW rwops close?)))
    (if (and (surface? surface)
             (not (struct-null? surface)))
        surface
        #f)))


(define (save-bmp! surface filepath)
  (SDL_SaveBMP surface filepath))

(define (save-bmp-rw! surface rwops #!optional close?)
  (SDL_SaveBMP_RW surface rwops close?))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; LOCK / UNLOCK

(define (lock-surface! surface)
  (SDL_LockSurface surface))

(define (unlock-surface! surface)
  (SDL_UnlockSurface surface))

(define (must-lock? surface)
  (SDL_MUSTLOCK surface))

;;; Locks the surface (if needed), performs body, unlocks the surface
;;; (if needed), and returns value of the last body expression.
(define-syntax with-locked-surface
  (syntax-rules ()
    ((with-locked-surface surface body ...)
     (dynamic-wind
         (lambda ()
           (when (must-lock? surface)
             (lock-surface! surface)))
         (lambda ()
           body ...)
         (lambda ()
           (when (must-lock? surface)
             (unlock-surface! surface)))))))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; BLIT

(define (blit-surface! src src-rect dst dst-rect)
  (SDL_BlitSurface src src-rect dst dst-rect))

(define (blit-scaled! src src-rect dst dst-rect)
  (SDL_BlitScaled src src-rect dst dst-rect))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; FILL RECT(S)

;;; Fill one area of the surface with a color. rect can be an
;;; sdl2:rect, or #f to fill the whole surface. color can be an
;;; sdl2:color or an integer (e.g. a mapped color from map-rgba, or
;;; a palette index).
(define (fill-rect! surface rect color)
  (SDL_FillRect surface rect
                (%map-color-for-surface
                 color surface 'fill-rect)))


;;; Fill multiple areas of the surface with a color. rects must be a
;;; list of sdl2:rects. color can be an sdl2:color or an integer (e.g. a
;;; mapped color from map-rgba, or a palette index).
(define (fill-rects! surface rects color)
  (assert (every rect? rects))
  (with-temp-mem ((rect-array (%rect-list->array rects)))
    (SDL_FillRects surface
                   rect-array
                   (length rects)
                   (%map-color-for-surface
                    color surface 'fill-rects))))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; GET / SET PIXEL

(define (%assert-surface-bounds surface x y fn-name)
  (when (or (< x 0) (>= x (surface-w surface)))
    (error fn-name "x coordinate out of bounds" x))
  (when (or (< y 0) (>= y (surface-h surface)))
    (error fn-name "y coordinate out of bounds" y)))


;;; Set the pixel at the given x/y coordinates to the given sdl2:color
;;; or raw pixel value (like is returned by map-rgba). Throws an
;;; error if x or y is out of bounds for the surface size.
(define (surface-set! surface x y color)
  (%assert-surface-bounds surface x y 'surface-set!)
  (let ((pixel (%map-color-for-surface color surface 'surface-set!)))
    (with-locked-surface surface
      (%surface-set-pixel! surface x y pixel))))

;;; Returns a sdl2:color instance for the pixel at the given x/y
;;; coordinates in the surface. Throws an error if x or y is out of
;;; bounds for the surface size.
(define (surface-ref surface x y)
  (%assert-surface-bounds surface x y 'surface-ref)
  (receive (r g b a) (get-rgba
                      (surface-ref-raw surface x y)
                      (surface-format surface))
           (make-color r g b a)))

(set! (setter surface-ref)
      surface-set!)

;;; Returns a raw pixel value (like is returned by map-rgba) for
;;; the pixel at the given x/y coordinates in the surface. Throws an
;;; error if x or y is out of bounds for the surface size.
(define (surface-ref-raw surface x y)
  (%assert-surface-bounds surface x y 'surface-ref-raw)
  (with-locked-surface surface
    (%surface-get-pixel surface x y)))

(set! (setter surface-ref-raw)
      surface-set!)



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; SURFACE PROPERTIES

(define (surface-clip-rect-set! surface rect)
  (SDL_SetClipRect surface rect))

(define (surface-clip-rect surface)
  (let ((rect-out (alloc-rect)))
    (SDL_GetClipRect surface rect-out)
    rect-out))

(set! (setter surface-clip-rect)
      surface-clip-rect-set!)



;;; Set the surface's color key. color can be an sdl2:color, or an
;;; integer (e.g. a mapped color from map-rgba), or #f to disable
;;; the color key.
(define (surface-color-key-set! surface color)
  (if color
      (SDL_SetColorKey surface #t
                       (%map-color-for-surface
                        color surface 'surface-color-key-set!))
      (SDL_SetColorKey surface #f 0)))

;;; Returns the surface's color key as an sdl2:color, or #f if the
;;; surface has no color key, or a negative integer if an error
;;; occurred.
(define (surface-color-key surface)
  (with-temp-mem ((mapped-color-out (%allocate-Uint32)))
    (let ((response (SDL_GetColorKey surface mapped-color-out)))
      (cond ((not (negative? response))
             (%unmap-color-for-surface
              (pointer-u32-ref mapped-color-out)
              surface))
            ((= -1 response)
             #f)
            (else
             response)))))

(set! (setter surface-color-key)
      surface-color-key-set!)

;;; Returns the surface's color key as a non-negative integer (a
;;; mapped color), or #f if the surface has no color key, or a
;;; negative integer if an error occurred.
(define (surface-color-key-raw surface)
  (with-temp-mem ((mapped-color-out (%allocate-Uint32)))
    (let ((response (SDL_GetColorKey surface mapped-color-out)))
      (cond ((not (negative? response))
             (pointer-u32-ref mapped-color-out))
            ((= -1 response)
             #f)
            (else
             response)))))

(set! (setter surface-color-key-raw)
      surface-color-key-set!)

(define surface-colour-key-set!  surface-color-key-set!)
(define surface-colour-key       surface-color-key)
(define surface-colour-key-raw   surface-color-key-raw)



(define (surface-alpha-mod-set! surface alpha)
  (SDL_SetSurfaceAlphaMod surface alpha))

;;; Returns the surface's alpha mod as an integer in range [0, 255],
;;; or a negative integer if an error occurred.
(define (surface-alpha-mod surface)
  (with-temp-mem ((alpha-out (%allocate-Uint8)))
    (let ((response (SDL_GetSurfaceAlphaMod surface alpha-out)))
      (if (zero? response)
          (pointer-u8-ref alpha-out)
          response))))

(set! (setter surface-alpha-mod)
      surface-alpha-mod-set!)



(define surface-blend-mode-set!
  (let ((err (lambda (x)
               (error 'surface-blend-mode-set!
                      "invalid surface blend mode"
                      x))))
    (lambda (surface blend-mode)
      (SDL_SetSurfaceBlendMode
       surface
       (cond ((integer? blend-mode)
              blend-mode)
             (else
              (symbol->blend-mode blend-mode err)))))))

;;; Returns the surface's blend mode as a symbol (none, blend, add, or
;;; mod), or a negative integer if an error occurred.
(define (surface-blend-mode surface)
  (with-temp-mem ((mode-out (%allocate-Uint8)))
    (let ((response (SDL_GetSurfaceBlendMode surface mode-out)))
      (if (zero? response)
          (blend-mode->symbol (pointer-u8-ref mode-out))
          response))))

(set! (setter surface-blend-mode)
      surface-blend-mode-set!)



;;; Set the surface color mod. Accepts either an RGB list of 3
;;; integers (0-255), or an sdl2:color (alpha will be ignored).
(define (surface-color-mod-set! surface rgb-or-color)
  (assert (or (list? rgb-or-color) (color? rgb-or-color)))
  (if (list? rgb-or-color)
      (SDL_SetSurfaceColorMod surface
                              (list-ref rgb-or-color 0)
                              (list-ref rgb-or-color 1)
                              (list-ref rgb-or-color 2))
      (SDL_SetSurfaceColorMod surface
                              (color-r rgb-or-color)
                              (color-g rgb-or-color)
                              (color-b rgb-or-color))))

;;; Returns the surface's color mod as a list of 3 integers in the
;;; range [0, 255], or returns a negative integer if an error
;;; occurred.
(define (surface-color-mod surface)
  (with-temp-mem ((r-out (%allocate-Uint8))
                  (g-out (%allocate-Uint8))
                  (b-out (%allocate-Uint8)))
    (let ((response (SDL_GetSurfaceColorMod
                     surface r-out g-out b-out)))
      (if (zero? response)
          (values (pointer-u8-ref r-out)
                  (pointer-u8-ref g-out)
                  (pointer-u8-ref b-out))
          (values response (void) (void))))))

(set! (setter surface-color-mod)
      surface-color-mod-set!)

(define surface-colour-mod-set! surface-color-mod-set!)
(define surface-colour-mod      surface-color-mod)



(define (surface-palette-set! surface palette)
  (SDL_SetSurfacePalette surface palette))

(define (surface-palette surface)
  (pixel-format-palette (surface-format surface)))

(set! (setter surface-palette)
      surface-palette-set!)



(define (surface-rle-set! surface rle?)
  (SDL_SetSurfaceRLE surface rle?))
