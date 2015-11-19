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


(export map-rgb
        map-rgba
        get-rgb
        get-rgba)


(define (map-rgb pixel-format r g b)
  (SDL_MapRGB pixel-format r g b))

(define (map-rgba pixel-format r g b a)
  (SDL_MapRGBA pixel-format r g b a))


;;; Converts a raw pixel (an unsigned integer) into red, green, and
;;; blue values (0-255). Returns multiple values.
(define (get-rgb pixel pixel-format)
  (with-temp-mem ((r-out (%allocate-Uint8))
                  (g-out (%allocate-Uint8))
                  (b-out (%allocate-Uint8)))
    (SDL_GetRGB pixel pixel-format r-out g-out b-out)
    (values (pointer-u8-ref r-out)
            (pointer-u8-ref g-out)
            (pointer-u8-ref b-out))))

;;; Converts a raw pixel (an unsigned integer) into red, green, blue,
;;; and alpha values (0-255). Returns multiple values.
(define (get-rgba pixel pixel-format)
  (with-temp-mem ((r-out (%allocate-Uint8))
                  (g-out (%allocate-Uint8))
                  (b-out (%allocate-Uint8))
                  (a-out (%allocate-Uint8)))
    (SDL_GetRGBA pixel pixel-format r-out g-out b-out a-out)
    (values (pointer-u8-ref r-out)
            (pointer-u8-ref g-out)
            (pointer-u8-ref b-out)
            (pointer-u8-ref a-out))))
