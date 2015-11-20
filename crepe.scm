(use
  srfi-1
  sdl2
  lolevel
  sdl2-internals
  (prefix sdl2-image img:)
  defstruct
  matchable
  )

(include "logic")

(define red (make-color 255 0 0))

(define +width+ 1280)
(define +height+ 720)
(define +column-space+ (quotient +width+ +columns-number+))
(define +line-space+ (quotient +height+ +lines-number+))

(init!)
(assert (member 'png (img:init! '(png))))

(define win (create-window! "Crepes-party-hard-yolo-swag 2015"
                            'undefined 'undefined
                            +width+ +height+))

(define renderer (SDL_CreateRenderer win -1 0))

(define (load-img blob)
  (let* ((evicted-blob (object-evict blob))
         (rw (rw-from-blob evicted-blob))
         (surface (img:load-rw rw #t))
         (texture (SDL_CreateTextureFromSurface renderer surface)))
    (object-release evicted-blob)
    (assert )
    texture))

(define-syntax file-blob
  (ir-macro-transformer
   (lambda (form inject compare)
     (let ((filename (cadr form)))
       (with-input-from-file filename
         (lambda ()
           (string->blob (read-string))))))))

(define crepe-down-texture (assert (load-img (file-blob "graph/down.png"))))
(define crepe-up-texture (assert (load-img (file-blob "graph/up.png"))))
(define crepe-left-texture (assert (load-img (file-blob "graph/left.png"))))
(define crepe-right-texture (assert (load-img (file-blob "graph/right.png"))))
(define crepe-stick-texture (assert (load-img (file-blob "graph/sticky-full.png"))))
(define crepe-unstick-texture (assert (load-img (file-blob "graph/unstick.png"))))
(define background-texture (assert (load-img (file-blob "graph/background.png"))))

(define screen-blit!
  (let ((rect (make-rect))
        (srcrect (make-rect 0 0 1280 720)))
    (lambda (surface x y)
      (set! (rect-x rect) x)
      (set! (rect-y rect) y)
      (SDL_RenderCopy renderer surface srcrect rect))))

;(init-utils! win)

(define draw-player
  (let* ((w 120)
         (h 300)
         (rect (make-rect 0 0 w h)))
    (lambda (player)
      (set! (rect-x rect) (+ (* player +column-space+) (/ w 2)))
      (set! (rect-y rect) (- (* (sub1 +lines-number+) +line-space+) (/ h 2)))
      (SDL_SetRenderDrawColor renderer 255 0 0 255)
      (SDL_RenderFillRect renderer rect))))

(define (crepe-surface state wiggle)
  (match state
    (($ ascend-state)
     crepe-up-texture)
    (($ stick-state unstick)
     (if unstick crepe-unstick-texture crepe-stick-texture))
    (($ descend-state speed time)
     (cond
      ((< wiggle -0.4) crepe-left-texture)
      ((> 0.4 wiggle -0.4) crepe-down-texture)
      ((> wiggle 0.4) crepe-right-texture)))))

(define ((draw-crepe clock) crepe)
  (let* ((state (crepe-state crepe))
         (column (crepe-column crepe))
         (speed (match state (($ descend-state speed) speed) (else +ascend-speed+)))
         (wiggle (sin (/ clock (/ speed 9))))
         (surface (crepe-surface state wiggle)))
    (screen-blit!
     surface
     (round
      (+ (/ +column-space+ 2)
         (- (* column +column-space+) (/ 200 2))
         (if (descend-state? state) (* (quotient +column-space+ 4) wiggle) 0)))
     (round
      (crepe-y state clock)))))

(define (crepe-y state clock)
  (+ +highest-point+
     (* (height clock state)
        (- +lowest-point+ +highest-point+))))

(define (draw-game player lives score board clock)
  (screen-blit! background-texture 0 0)
  (draw-player player)
  (for-each (draw-crepe clock) board)
  ;; (font-size 16)
  ;; (font-color black)
  ;; (text (- +width+ 10) 20 (sprintf "Lives: ~A  Score: ~A" lives score) align: #:right)
  (SDL_RenderPresent renderer)
  ;(show!)
  )

(define get-direction!
  (let ((event (make-event)))
    (lambda ()
      (cond ((and (poll-event! event) (keydown-event? event))
             (case (keyboard-event-scancode event)
               ((left) (flush-events!) 'left)
               ((right) (flush-events!) 'right)
               (else (get-direction!))))
            (else 'stay)))))

(define (keydown-event? ev)
  (eq? (event-type ev) 'key-down))


(define (start-game)
  (main-loop +initial-player-position+
             +initial-lives+
             +initial-score+
             +initial-board+))

(define (main-loop player lives score board)
  (let* ((clock (get-ticks))
         (new-player (move-player player (get-direction!)))
         (new-board (map (compute-crepe clock new-player score (final-times board)) board))
         (score-increment (compute-score board new-board))
         (lives-lost (count (lambda (c) (outside-board? clock c)) new-board)))
    (draw-game player lives score board clock)
    (unless (dead? lives)
      (main-loop new-player
                 (- lives lives-lost)
                 (+ score score-increment)
                 (revive-crepes clock new-board)))))

(define ((compute-crepe clock player score times) crepe)
  (let ((state (crepe-state crepe)))
    (update-crepe
     crepe
     state: (cond
	     ((and (stick-state? state) (should-fall?))
              (update-stick-state state unstick: #t time: clock))
             ((and (stick-state? state) (stick-state-unstick state) (>= clock (+ (stick-state-time state) 1000)))
              (make-descend-state time: clock speed: (random-speed times clock score)))
             ((and (ascend-state? state) (>= clock (+ (ascend-state-time state) +ascend-speed+)))
              (make-stick-state))
             ((and (descend-state? state)
                   (= player (crepe-column crepe))
                   (within-catch-range? clock (descend-state-time state) (descend-state-speed state)))
              (make-ascend-state time: clock))
             (else
              state)))))

(start-game)
