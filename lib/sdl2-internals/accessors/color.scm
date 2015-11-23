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


(export color-r  color-r-set!
        color-g  color-g-set!
        color-b  color-b-set!
        color-a  color-a-set!
        make-color
        make-color*
        color-set!
        color->list
        color=?
        copy-color  copy-color*

        colour-r  colour-r-set!
        colour-g  colour-g-set!
        colour-b  colour-b-set!
        colour-a  colour-a-set!
        make-colour
        make-colour*
        colour-set!
        colour->list
        colour=?
        copy-colour  copy-colour*)


(define-struct-field-accessors
  SDL_Color*
  color?
  ("r"
   type:   Uint8
   getter: color-r
   setter: color-r-set!
   guard:  (Uint8-guard "sdl2:color field r"))
  ("g"
   type:   Uint8
   getter: color-g
   setter: color-g-set!
   guard:  (Uint8-guard "sdl2:color field g"))
  ("b"
   type:   Uint8
   getter: color-b
   setter: color-b-set!
   guard:  (Uint8-guard "sdl2:color field b"))
  ("a"
   type:   Uint8
   getter: color-a
   setter: color-a-set!
   guard:  (Uint8-guard "sdl2:color field a")))



(define (make-color #!optional (r 0) (g 0) (b 0) (a 255))
  (color-set! (alloc-color) r g b a))

(define (make-color* #!optional (r 0) (g 0) (b 0) (a 255))
  (color-set! (alloc-color*) r g b a))


(define (color-set! color #!optional r g b a)
  (when r (color-r-set! color r))
  (when g (color-g-set! color g))
  (when b (color-b-set! color b))
  (when a (color-a-set! color a))
  color)


(define (color->list color)
  (list (color-r color)
        (color-g color)
        (color-b color)
        (color-a color)))


(define (color=? color1 color2)
  (define foreign-equals
    (foreign-lambda*
     bool ((SDL_Color* c1) (SDL_Color* c2))
     "C_return(((c1->r == c2->r) && (c1->g == c2->g) &&
                (c1->b == c2->b) && (c1->a == c2->a))
               ? 1 : 0);"))
  (foreign-equals color1 color2))


(define %copy-color!
  (foreign-lambda*
   void ((SDL_Color* src) (SDL_Color* dest))
   "*dest = *src;"))

(define (copy-color color)
  (let ((dest (alloc-color)))
    (%copy-color! color dest)
    dest))

(define (copy-color* color)
  (let ((dest (alloc-color*)))
    (%copy-color! color dest)
    dest))



(define colour-r      color-r)
(define colour-g      color-g)
(define colour-b      color-b)
(define colour-a      color-a)
(define colour-r-set! color-r-set!)
(define colour-g-set! color-g-set!)
(define colour-b-set! color-b-set!)
(define colour-a-set! color-a-set!)

(define make-colour   make-color)
(define make-colour*  make-color*)
(define colour-set!   color-set!)
(define colour->list  color->list)
(define colour=?      color=?)
(define copy-colour   copy-color)
(define copy-colour*  copy-color*)
