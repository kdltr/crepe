(use
  srfi-1
  sdl2
  sdl2-internals
  (prefix sdl2-image img:)
  (prefix sdl2-mixer mix:)
  defstruct
  matchable)

(include "syntax")

(SDL_SetHint "SDL_RENDER_SCALE_QUALITY" "1")
(set-main-ready!)
(init!)
(mix:init!)
(mix:open-audio!)
(assert (member 'png (img:init! '(png))))

(define dm (make-display-mode))
(SDL_GetDesktopDisplayMode 0 dm)

(define +width+ 1920)
(define +height+ 1080)

(define win (create-window! "Crepes-party-hard-yolo-swag 2015"
                            'undefined 'undefined
                            (display-mode-w dm)
                            (* (quotient (display-mode-w dm) 16) 9)
                            '()))

(define renderer
  (SDL_CreateRenderer win -1 6))
(SDL_RenderSetLogicalSize renderer +width+ +height+)

(define collect-events!
  (let ((e (make-event)))
    (lambda ()
      (if (poll-event! e)
          (let ((o (interpret-event e)))
            (if o
                (cons o (collect-events!))
                (collect-events!)))
          '()))))

(define (interpret-event ev)
  (case (event-type ev)
    ((key-down)
     (and (zero? (keyboard-event-repeat ev))
          (keyboard-event-scancode ev)))
    ((mouse-button-down)
     (list 'button-down
           (mouse-button-event-x ev)
           (mouse-button-event-y ev)))
    ((mouse-motion)
     (list 'motion
           (mouse-motion-event-x ev)
           (mouse-motion-event-y ev)))
    (else
     #f)))

(defstruct sprite w h texture)
(defstruct sound channel chunks)

(define (load-img blob)
  (let* ((evicted-blob (object-evict blob))
         (rw (rw-from-blob evicted-blob))
         (surface (img:load-rw rw #t))
         (texture (SDL_CreateTextureFromSurface renderer surface)))
    (object-release evicted-blob)
    (make-sprite w: (surface-w surface)
                 h: (surface-h surface)
                 texture: texture)))

(define (load-snd blob)
  (let* ((evicted-blob (object-evict blob))
         (rw (rw-from-blob evicted-blob))
         (chunk (mix:load-wav-rw rw #t)))
    (object-release evicted-blob)
    chunk))

(define show-sprite!
  (let ((rect (make-rect)))
    (lambda (sprite x y #!key (flipped #f))
      (set! (rect-x rect) x)
      (set! (rect-y rect) y)
      (set! (rect-w rect) (sprite-w sprite))
      (set! (rect-h rect) (sprite-h sprite))
      (SDL_RenderCopyEx renderer
                        (sprite-texture sprite)
                        #f
                        rect
                        0
                        #f
                        (if flipped 1 0)))))

(define (fire-sound! sound)
  (let* ((chunks (sound-chunks sound))
         (len (vector-length chunks)))
   (mix:play-channel! (sound-channel sound)
                      (vector-ref chunks (random len))
                      0)))

(define-resources
 crepe-down crepe-up crepe-left crepe-right crepe-stick crepe-unstick

 background font score-text lives-text heart

 body-low body-high head-focus head-happy head-sad

 board pins button-on button-off play-text quit-text
 button-credits credits)

(define-sound hit)
(define-sound stick)
(define-sound fell)
(define-sound almost)

(include "game")
(include "menu")

(menu-main-loop 0 0 0)
