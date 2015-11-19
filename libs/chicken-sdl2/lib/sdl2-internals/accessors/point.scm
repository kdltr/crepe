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


(export point-x  point-x-set!
        point-y  point-y-set!
        make-point
        make-point*
        point-set!
        point->list
        point=?
        copy-point  copy-point*)


(define-struct-field-accessors
  SDL_Point*
  point?
  ("x"
   type:   Sint32
   getter: point-x
   setter: point-x-set!
   guard:  (Sint32-guard "sdl2:point field x"))
  ("y"
   type:   Sint32
   getter: point-y
   setter: point-y-set!
   guard:  (Sint32-guard "sdl2:point field y")))



(define (make-point #!optional (x 0) (y 0))
  (point-set! (alloc-point) x y))

(define (make-point* #!optional (x 0) (y 0))
  (point-set! (alloc-point*) x y))


(define (point-set! point #!optional x y)
  (when x (point-x-set! point x))
  (when y (point-y-set! point y))
  point)


(define (point->list point)
  (list (point-x point)
        (point-y point)))


(define (point=? point1 point2)
  (define foreign-equals
    (foreign-lambda*
     bool ((SDL_Point* p1) (SDL_Point* p2))
     "C_return(((p1->x == p2->x) && (p1->y == p2->y))
               ? 1 : 0);"))
  (foreign-equals point1 point2))


(define %copy-point!
  (foreign-lambda*
   void ((SDL_Point* src) (SDL_Point* dest))
   "*dest = *src;"))

(define (copy-point point)
  (let ((dest (alloc-point)))
    (%copy-point! point dest)
    dest))

(define (copy-point* point)
  (let ((dest (alloc-point*)))
    (%copy-point! point dest)
    dest))
