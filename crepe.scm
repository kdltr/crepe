(use
  srfi-1
  sdl2
  sdl2-internals
  (prefix sdl2-image img:)
  defstruct
  matchable
)

(define +width+ 1280)
(define +height+ 720)

(init!)
(assert (member 'png (img:init! '(png))))

(define win (create-window! "Crepes-party-hard-yolo-swag 2015"
                            'undefined 'undefined
                            +width+ +height+))

(define renderer
  (SDL_CreateRenderer win -1 6))

(define (collect-events!)
  (let ((event (poll-event!)))
    (if event
        (cons event (collect-events!))
        '())))

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

(define (show-sprite! sprite x y)
  (let ((rect (make-rect x y (sprite-w sprite) (sprite-h sprite))))
    (SDL_RenderCopy renderer
                    (sprite-texture sprite)
                    #f
                    rect)))

(define-syntax file-blob
  (ir-macro-transformer
   (lambda (form inject compare)
     (let ((filename (cadr form)))
       (with-input-from-file filename
         (lambda ()
           (string->blob (read-string))))))))

(define red (make-color 255 0 0))

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

(include "game")
(include "menu")

(main-loop-menu)
