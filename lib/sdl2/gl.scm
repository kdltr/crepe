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


(export gl-create-context!
        gl-delete-context!
        gl-make-current!
        gl-get-current-window
        gl-get-current-context

        gl-attribute  gl-attribute-set!
        gl-reset-attributes! ;; SDL >= 2.0.2

        gl-get-drawable-size ;; SDL >= 2.0.1

        gl-swap-window!
        gl-swap-interval  gl-swap-interval-set!

        ;; TODO: gl-bind-texture
        ;; TODO: gl-unbind-texture

        gl-extension-supported?
        ;; TODO?: gl-get-proc-address
        ;; TODO?: gl-load-library
        ;; TODO?: gl-unload-library
        )


(: gl-create-context!
   ((or (struct sdl2:window) pointer) -> (struct sdl2:gl-context)))
(define (gl-create-context! window)
  (let ((context (SDL_GL_CreateContext window)))
    (if (and (gl-context? context) (not (struct-null? context)))
        context
        (abort (sdl-failure "SDL_GL_CreateContext" #f)))))


(: gl-delete-context!
   ((or (struct sdl2:gl-context) pointer) -> void))
(define (gl-delete-context! context)
  (SDL_GL_DeleteContext context))


(: gl-make-current!
   ((or (struct sdl2:window) pointer)
    (or (struct sdl2:gl-context) pointer)
    -> void))
(define (gl-make-current! window gl-context)
  (let ((ret-code (SDL_GL_MakeCurrent window gl-context)))
    (unless (zero? ret-code)
      (abort (sdl-failure "SDL_GL_MakeCurrent" ret-code)))))


(: gl-get-current-window
   (-> (struct sdl2:window)))
(define (gl-get-current-window)
  (let ((window (SDL_GL_GetCurrentWindow)))
    (if (and (window? window) (not (struct-null? window)))
        window
        (abort (sdl-failure "SDL_GL_GetCurrentWindow" #f)))))


(: gl-get-current-context
   (-> (struct sdl2:gl-context)))
(define (gl-get-current-context)
  (let ((context (SDL_GL_GetCurrentContext)))
    (if (and (gl-context? context) (not (struct-null? context)))
        context
        (abort (sdl-failure "SDL_GL_GetCurrentContext" #f)))))


(: %gl-attr->int
   ((or symbol fixnum) symbol -> fixnum))
(define (%gl-attr->int attr fn-name)
  (if (integer? attr)
      attr
      (symbol->gl-attr
       attr
       (lambda (x)
         (error fn-name "invalid GL attr symbol" x)))))


(: gl-attribute
   ((or symbol fixnum) -> (or fixnum symbol (list-of symbol))))
;;; Get the value of a GL attribute. Returns the value (usually an
;;; integer) on success, or #f if an error occurred.
;;;
;;; - If attr is 'context-flags, the return value will be a list of
;;;   symbols.
;;; - If attr is 'context-profile-mask, the return value will be a
;;;   symbol.
;;; - For other attributes, the return value will be an integer.
;;;
(define (gl-attribute attr)
  (let ((attr-int (%gl-attr->int attr 'gl-attribute)))
    (with-temp-mem ((value-out (%allocate-int)))
      (let ((ret-code (SDL_GL_GetAttribute attr-int value-out)))
        (if (zero? ret-code)
            (select attr-int
              ((SDL_GL_CONTEXT_FLAGS)
               (unpack-gl-context-flags
                (pointer-s32-ref value-out)))
              ((SDL_GL_CONTEXT_PROFILE_MASK)
               (gl-profile->symbol
                (pointer-s32-ref value-out)))
              (else
               (pointer-s32-ref value-out)))
            (begin
              (free value-out)
              (abort (sdl-failure "SDL_GL_GetAttribute" ret-code))))))))


(: gl-attribute-set!
   ((or symbol fixnum) (or fixnum symbol (list-of symbol)) -> void))
;;; Set the value of a GL attribute. Returns 0 on success, or -1 if an
;;; error occurred.
;;;
;;; - If attr is 'context-flags, the value must be a list of GL
;;;   context flag enum symbols, or an integer.
;;; - If attr is 'context-profile-mask, the value must be a GL profile
;;;   enum symbol, or an integer.
;;; - For other attributes, the value must be an integer.
;;;
(define (gl-attribute-set! attr value)
  (let* ((attr-int (%gl-attr->int attr 'gl-attribute-set!))
         (value-int (select attr-int
                      ((SDL_GL_CONTEXT_FLAGS)
                       (if (integer? value)
                           value
                           (pack-gl-context-flags value)))
                      ((SDL_GL_CONTEXT_PROFILE_MASK)
                       (if (integer? value)
                           value
                           (symbol->gl-profile value)))
                      (else
                       value)))
         (ret-code (SDL_GL_SetAttribute attr-int value-int)))
    (unless (zero? ret-code)
      (abort (sdl-failure "SDL_GL_SetAttribute" ret-code)))))

(set! (setter gl-attribute)
      gl-attribute-set!)


(: gl-reset-attributes!
   (->))
;;; Only available with SDL >= 2.0.2.
(define-versioned (2 0 2) (gl-reset-attributes!)
  (SDL_GL_ResetAttributes))


(: gl-get-drawable-size
   ((or (struct sdl2:window) pointer) -> fixnum fixnum))
;;; Only available with SDL >= 2.0.1.
(define-versioned (2 0 1) (gl-get-drawable-size window)
  (with-temp-mem ((w-out (%allocate-int))
                  (h-out (%allocate-int)))
    (SDL_GL_GetDrawableSize window w-out h-out)
    (values (pointer-u32-ref w-out)
            (pointer-u32-ref h-out))))


(: gl-swap-window!
   ((or (struct sdl2:window) pointer) -> void))
(define (gl-swap-window! window)
  (SDL_GL_SwapWindow window))


(: gl-swap-interval
   (-> fixnum))
(define (gl-swap-interval)
  (SDL_GL_GetSwapInterval))

(: gl-swap-interval-set!
   (fixnum -> void))
(define (gl-swap-interval-set! interval)
  (let ((ret-code (SDL_GL_SetSwapInterval interval)))
    (unless (zero? ret-code)
      (abort (sdl-failure "SDL_GL_SetSwapInterval" ret-code)))))

(set! (setter gl-swap-interval)
      gl-swap-interval-set!)


;; TODO: gl-bind-texture  (SDL_GL_BindTexture)
;; TODO: gl-unbind-texture  (SDL_GL_UnbindTexture)


(define (gl-extension-supported? name-string)
  (SDL_GL_ExtensionSupported name-string))

;; TODO?: gl-get-proc-address  (SDL_GL_GetProcAddress)
;; TODO?: gl-load-library  (SDL_GL_LoadLibrary)
;; TODO?: gl-unload-library  (SDL_GL_UnloadLibrary)
