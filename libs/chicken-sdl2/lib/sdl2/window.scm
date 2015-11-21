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


(export create-window!
        get-window-from-id
        destroy-window!

        update-window-surface!
        update-window-surface-rects!

        show-window!
        hide-window!
        maximize-window!
        minimize-window!
        raise-window!
        restore-window!

        window-bordered?       window-bordered-set!
        window-brightness      window-brightness-set!
        ;; TODO: window-data
        ;; TODO: window-data-set!
        window-display-index
        window-display-mode    window-display-mode-set!
        window-flags
        window-flags-raw
        window-fullscreen      window-fullscreen-set!
        ;; TODO: window-gamma-ramp
        ;; TODO: window-gamma-ramp-set!
        window-grab?           window-grab-set!
        window-icon-set!
        window-id
        window-maximum-size    window-maximum-size-set!
        window-minimum-size    window-minimum-size-set!
        window-pixel-format
        window-position        window-position-set!
        window-size            window-size-set!
        window-surface
        window-title           window-title-set!
        ;; TODO: window-wm-info
        )


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; CREATE / GET / DESTROY WINDOW

(define (%window-pos->int pos x-or-y)
  (case pos
    ((undefined) SDL_WINDOWPOS_UNDEFINED)
    ((centered)  SDL_WINDOWPOS_CENTERED)
    (else
     (if (integer? pos)
         pos
         (error 'create-window!
                (sprintf "invalid window ~A position" x-or-y)
                pos)))))

(define (create-window! title x y w h #!optional (flags '()))
  (let ((window (SDL_CreateWindow
                 title
                 (%window-pos->int x "x") (%window-pos->int y "y")
                 w h
                 (pack-window-flags flags))))
    (if (and (window? window) (not (struct-null? window)))
        window
        (abort (sdl-failure "SDL_CreateWindow" #f)))))


(define (get-window-from-id id)
  (SDL_GetWindowFromID id))

(define (destroy-window! window)
  (SDL_DestroyWindow window))



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; UPDATE WINDOW SURFACE

(define (update-window-surface! window)
  (let ((ret-code (SDL_UpdateWindowSurface window)))
    (unless (zero? ret-code)
      (abort (sdl-failure "SDL_UpdateWindowSurface" ret-code)))))


(define (update-window-surface-rects! window rects)
  (assert (every rect? rects))
  (with-temp-mem ((rect-array (%rect-list->array rects)))
    (let ((ret-code (SDL_UpdateWindowSurfaceRects
                     window rect-array (length rects))))
      (unless (zero? ret-code)
        (free rect-array)
        (abort (sdl-failure "SDL_UpdateWindowSurfaceRects" ret-code))))))



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; WINDOW MANAGEMENT

(define (show-window! window)
  (SDL_ShowWindow window))

(define (hide-window! window)
  (SDL_HideWindow window))

(define (maximize-window! window)
  (SDL_MaximizeWindow window))

(define (minimize-window! window)
  (SDL_MinimizeWindow window))

(define (raise-window! window)
  (SDL_RaiseWindow window))

(define (restore-window! window)
  (SDL_RestoreWindow window))



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; WINDOW PROPERTIES


(define (window-bordered? window)
  (zero? (bitwise-and SDL_WINDOW_BORDERLESS
                      (window-flags-raw window))))

(define (window-bordered-set! window bordered?)
  (SDL_SetWindowBordered window bordered?))

(set! (setter window-bordered?) window-bordered-set!)


(define (window-brightness-set! window brightness)
  (let ((ret-code (SDL_SetWindowBrightness window brightness)))
    (unless (zero? ret-code)
      (abort (sdl-failure "SDL_SetWindowBrightness" ret-code)))))

(define (window-brightness window)
  (SDL_GetWindowBrightness window))

(set! (setter window-brightness)
      window-brightness-set!)


;; TODO: window-data
;; TODO: window-data-set!


(define (window-display-index window)
  (let ((index (SDL_GetWindowDisplayIndex window)))
    (if (negative? index)
        (abort (sdl-failure "SDL_GetWindowDisplayIndex" index))
        index)))


(: window-display-mode
   ((or (struct sdl2:window) pointer) -> (struct sdl2:display-mode)))
(define (window-display-mode window)
  (let ((display-mode (alloc-display-mode)))
    (let ((ret-code (SDL_GetWindowDisplayMode window display-mode)))
      (if (zero? ret-code)
          display-mode
          (abort (sdl-failure "SDL_GetWindowDisplayMode" ret-code))))))

(: window-display-mode-set!
   ((or (struct sdl2:window) pointer)
    (or (struct sdl2:display-mode) pointer)
    -> void))
(define (window-display-mode-set! window mode)
  (let ((ret-code (SDL_SetWindowDisplayMode window mode)))
    (unless (zero? ret-code)
      (abort (sdl-failure "SDL_SetWindowDisplayMode" ret-code)))))

(set! (setter window-display-mode)
      window-display-mode-set!)


(define (window-flags window)
  (unpack-window-flags
   (window-flags-raw window)
   #t))

(define (window-flags-raw window)
  (SDL_GetWindowFlags window))


(: window-fullscreen
   ((struct sdl2:window) -> (or symbol false)))
(define (window-fullscreen window)
  (let ((flags-mask (window-flags-raw window)))
    (cond
     ((= SDL_WINDOW_FULLSCREEN_DESKTOP
         (bitwise-and SDL_WINDOW_FULLSCREEN_DESKTOP flags-mask))
      'fullscreen-desktop)
     ((= SDL_WINDOW_FULLSCREEN
         (bitwise-and SDL_WINDOW_FULLSCREEN flags-mask))
      'fullscreen)
     (else
      #f))))

(: window-fullscreen-set!
   ((struct sdl2:window) (or symbol false fixnum) -> void))
(define (window-fullscreen-set! window mode)
  (let ((mode-int
         (if (integer? mode)
             mode
             (case mode
               ((fullscreen #t) SDL_WINDOW_FULLSCREEN)
               ((fullscreen-desktop) SDL_WINDOW_FULLSCREEN_DESKTOP)
               ((#f) 0)
               (else (error 'window-fullscreen-set!
                            "Invalid fullscreen mode" mode))))))
    (let ((ret-code (SDL_SetWindowFullscreen window mode-int)))
      (abort (sdl-failure "SDL_SetWindowFullscreen" ret-code)))))

(set! (setter window-fullscreen) window-fullscreen-set!)


;; TODO: window-gamma-ramp
;; TODO: window-gamma-ramp-set!


(define (window-grab-set! window grab?)
  (SDL_SetWindowGrab window grab?))

(define (window-grab? window)
  (SDL_GetWindowGrab window))

(set! (setter window-grab?)
      window-grab-set!)


(define (window-icon-set! window icon)
  (SDL_SetWindowIcon window icon))


(define (window-id window)
  (SDL_GetWindowID window))


(define (window-maximum-size-set! window size)
  (SDL_SetWindowMaximumSize window (car size) (cadr size)))

(define (window-maximum-size window)
  (with-temp-mem ((w-out (%allocate-int))
                  (h-out (%allocate-int)))
    (SDL_GetWindowMaximumSize window w-out h-out)
    (values (pointer-s32-ref w-out)
            (pointer-s32-ref h-out))))

(set! (setter window-maximum-size)
      window-maximum-size-set!)


(define (window-minimum-size-set! window size)
  (SDL_SetWindowMinimumSize window (car size) (cadr size)))

(define (window-minimum-size window)
  (with-temp-mem ((w-out (%allocate-int))
                  (h-out (%allocate-int)))
    (SDL_GetWindowMinimumSize window w-out h-out)
    (values (pointer-s32-ref w-out)
            (pointer-s32-ref h-out))))

(set! (setter window-minimum-size)
      window-minimum-size-set!)


(define (window-pixel-format window)
  (SDL_GetWindowPixelFormat window))


(define (window-position-set! window pos)
  (SDL_SetWindowPosition
   window
   (%window-pos->int (car pos) "x")
   (%window-pos->int (cadr pos) "y")))

(define (window-position window)
  (with-temp-mem ((x-out (%allocate-int))
                  (y-out (%allocate-int)))
    (SDL_GetWindowPosition window x-out y-out)
    (values (pointer-s32-ref x-out)
            (pointer-s32-ref y-out))))

(set! (setter window-position)
      window-position-set!)


(define (window-size-set! window size)
  (SDL_SetWindowSize window (car size) (cadr size)))

(define (window-size window)
  (with-temp-mem ((w-out (%allocate-int))
                  (h-out (%allocate-int)))
    (SDL_GetWindowSize window w-out h-out)
    (values (pointer-s32-ref w-out)
            (pointer-s32-ref h-out))))

(set! (setter window-size)
      window-size-set!)


(define (window-surface window)
  (let ((surface (SDL_GetWindowSurface window)))
    (if (and (surface? surface) (not (struct-null? surface)))
        surface
        (abort (sdl-failure "SDL_GetWindowSurface" #f)))))


(define (window-title-set! window title)
  (SDL_SetWindowTitle window title))

(define (window-title window)
  (SDL_GetWindowTitle window))

(set! (setter window-title)
      window-title-set!)


;; TODO: window-wm-info
