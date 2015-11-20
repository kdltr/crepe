(use
  srfi-1
  sdl2
  (prefix sdl2-image img:)
  defstruct
  matchable
)

(init!)
(assert (member 'png (img:init! '(png))))

(define (load-img blob)
  (let* ((evicted-blob (object-evict blob))
         (rw (rw-from-blob evicted-blob))
         (surface (img:load-rw rw #t)))
    (object-release evicted-blob)
    surface))

(define-syntax file-blob
  (ir-macro-transformer
   (lambda (form inject compare)
     (let ((filename (cadr form)))
       (with-input-from-file filename
         (lambda ()
           (string->blob (read-string))))))))

(define +width+ 1280)
(define +height+ 720)

(define red (make-color 255 0 0))

(define crepe-down-surface (assert (load-img (file-blob "graph/down.png"))))
(define crepe-up-surface (assert (load-img (file-blob "graph/up.png"))))
(define crepe-left-surface (assert (load-img (file-blob "graph/left.png"))))
(define crepe-right-surface (assert (load-img (file-blob "graph/right.png"))))
(define crepe-stick-surface (assert (load-img (file-blob "graph/sticky-full.png"))))
(define crepe-unstick-surface (assert (load-img (file-blob "graph/unstick.png"))))

(define background-surface (load-img (file-blob "graph/background.png")))
(define font-surface (load-img (file-blob "graph/font.png")))
(define score-text-surface (load-img (file-blob "graph/score-text.png")))
(define lives-text-surface (load-img (file-blob "graph/lives-text.png")))
(define heart-surface (load-img (file-blob "graph/coeur.png")))
(define character-surface (load-img (file-blob "graph/character.png")))

(include "crepe")
(include "menu")

(define win (create-window! "Crepes-party-hard-yolo-swag 2015"
                            'undefined 'undefined
                            +width+ +height+))

(define win-surface (window-surface win))

(define (collect-events!)
  (let ((event (poll-event!)))
    (if event
        (cons event (collect-events!))
        '())))
