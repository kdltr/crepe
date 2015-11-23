(include "libs/chicken-sdl2/sdl2-internals.scm")
(include "libs/chicken-sdl2/sdl2.scm")
(include "libs/chicken-sdl2-image/sdl2-image.scm")

(import
  srfi-1
  defstruct
  matchable
  sdl2-internals
  sdl2
  (prefix sdl2-image img:))

(define +width+ 1280)
(define +height+ 720)

(init!)
(assert (member 'png (img:init! '(png))))

(define win (create-window! "Crepes-party-hard-yolo-swag 2015"
                            'undefined 'undefined
                            +width+ +height+))

(define renderer
  (SDL_CreateRenderer win -1 6))

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
     (keyboard-event-scancode ev))
    ((mouse-button-down)
     (list (mouse-button-event-x ev)
           (mouse-button-event-y ev)))
    (else
     #f)))

(defstruct sprite w h texture)

(define (load-img blob)
  (let* ((evicted-blob (object-evict blob))
         (rw (rw-from-blob evicted-blob))
         (surface (img:load-rw rw #t))
         (texture (SDL_CreateTextureFromSurface renderer surface)))
    (object-release evicted-blob)
    (make-sprite w: (surface-w surface)
                 h: (surface-h surface)
                 texture: texture)))

(define show-sprite!
  (let ((rect (make-rect)))
    (lambda (sprite x y)
      (set! (rect-x rect) x)
      (set! (rect-y rect) y)
      (set! (rect-w rect) (sprite-w sprite))
      (set! (rect-h rect) (sprite-h sprite))
      (SDL_RenderCopy renderer
                      (sprite-texture sprite)
                      #f
                      rect))))

(define-syntax file-blob
  (ir-macro-transformer
   (lambda (form inject compare)
     (let ((filename (cadr form)))
       (with-input-from-file filename
         (lambda ()
           (string->blob (read-string))))))))

(define crepe-down-surface (load-img (file-blob "graph/down.png")))
(define crepe-up-surface (load-img (file-blob "graph/up.png")))
(define crepe-left-surface (load-img (file-blob "graph/left.png")))
(define crepe-right-surface (load-img (file-blob "graph/right.png")))
(define crepe-stick-surface (load-img (file-blob "graph/sticky-full.png")))
(define crepe-unstick-surface (load-img (file-blob "graph/unstick.png")))

(define background-surface (load-img (file-blob "graph/background.png")))
(define font-surface (load-img (file-blob "graph/font.png")))
(define score-text-surface (load-img (file-blob "graph/score-text.png")))
(define lives-text-surface (load-img (file-blob "graph/lives-text.png")))
(define heart-surface (load-img (file-blob "graph/coeur.png")))
(define character-surface (load-img (file-blob "graph/character.png")))

(define board-surface (load-img (file-blob "graph/board.png")))
(define pins-surface (load-img (file-blob "graph/pins.png")))
(define pins-flipped-surface (load-img (file-blob "graph/pins-flipped.png")))
(define button-on-surface (load-img (file-blob "graph/button-on.png")))
(define button-off-surface (load-img (file-blob "graph/button-off.png")))
(define play-text-surface (load-img (file-blob "graph/play-text.png")))
(define quit-text-surface (load-img (file-blob "graph/quit-text.png")))

(include "game")
(include "menu")

(main-loop-menu)
