(use
  cairo-utils
  matchable
  sdl2
  (prefix sdl2-image img:)
  )

(include "syntax")
(include "logic")

(define white '(1 1 1 1))
(define black '(0 0 0 1))
(define red '(1 0 0 1))
(define yellow '(1 1 0 1))
(define blue '(0 0 1 1))
(define violet '(1 0 1 1))

(define +width+ 1280)
(define +height+ 720)
(define +column-space+ (quotient +width+ +columns-number+))
(define +line-space+ (quotient +height+ +lines-number+))

(init!)
(assert (member 'png (img:init! '(png))))

(define crepe-down-surface (assert (img:load "graph/down.png")))
(define crepe-up-surface (assert (img:load "graph/up.png")))
(define crepe-left-surface (assert (img:load "graph/left.png")))
(define crepe-right-surface (assert (img:load "graph/right.png")))
(define crepe-stick-surface (assert (img:load "graph/sticky-full.png")))
(define crepe-unstick-surface (assert (img:load "graph/unstick.png")))
(define background-surface (assert (img:load "graph/background.png")))

(define win (create-window! "Crepes-party-hard-yolo-swag 2015"
                            'undefined 'undefined
                            +width+ +height+))

(define win-surface (window-surface win))

(init-utils! win)

(define (draw-player player)
  (let ((w 120)
        (h 300))
   (filled-rectangle
    (+ (* player +column-space+) (/ w 2))
    (- (* (sub1 +lines-number+) +line-space+) (/ h 2))
    w h
    red)))

(define (crepe-surface state wiggle)
  (match state
    (($ ascend-state)
     crepe-up-surface)
    (($ stick-state unstick)
     (if unstick crepe-unstick-surface crepe-stick-surface))
    (($ descend-state speed time)
     (cond
      ((< wiggle -0.4) crepe-left-surface)
      ((> 0.4 wiggle -0.4) crepe-down-surface)
      ((> wiggle 0.4) crepe-right-surface)))))

(define ((draw-crepe clock) crepe)
  (let* ((state (crepe-state crepe))
         (column (crepe-column crepe))
         (speed (match state (($ descend-state speed) speed) (else +ascend-speed+)))
         (wiggle (sin (/ clock (/ speed 9))))
         (surface (crepe-surface state wiggle)))
    (blit-surface!
     surface
     #f
     win-surface
     (make-rect
      (round
       (+ (/ +column-space+ 2)
          (- (* column +column-space+) (/ (surface-w surface) 2))
          (if (descend-state? state) (* (quotient +column-space+ 4) wiggle) 0)))
      (round
       (crepe-y state clock))))))

(define (crepe-y state clock)
  (+ +highest-point+
     (* (height clock state)
        (- +lowest-point+ +highest-point+))))

(define (draw-game player lives score board clock)
  (blit-surface! background-surface #f win-surface #f)
  (draw-player player)
  (for-each (draw-crepe clock) board)
  (font-size 16)
  (font-color black)
  (text (- +width+ 10) 20 (sprintf "Lives: ~A  Score: ~A" lives score) align: #:right)
  (show!))

(define (collect-events!)
  (let ((event (poll-event!)))
    (if event
        (cons event (collect-events!))
        '())))

(define (keydown-event? ev)
  (eq? (event-type ev) 'key-down))

(define (get-direction event)
  (if event
      (case (keyboard-event-scancode event)
        ((left) 'left)
        ((right) 'right)
        (else 'stay))
      'stay))

(define (start-game)
  (main-loop +initial-player-position+
             +initial-lives+
             +initial-score+
             +initial-board+))

(define (main-loop player lives score board)
  (let* ((clock (get-ticks))
         (new-player (move-player player (get-direction (find keydown-event? (collect-events!)))))
         (new-board (map (lambda (c) (compute-crepe clock new-player score c)) board))
         (score-increment (compute-score board new-board))
         (lives-lost (count (lambda (c) (outside-board? clock c)) new-board)))
    (draw-game player lives score board clock)
    (unless (dead? lives)
      (main-loop new-player
                 (- lives lives-lost)
                 (+ score score-increment)
                 (revive-crepes clock new-board)))))

(define (compute-crepe clock player score crepe)
  (let ((state (crepe-state crepe)))
    (update-crepe
     crepe
     state: (cond
	     ((and (stick-state? state) (should-fall?)) (update-stick-state state unstick: #t time: clock))
             ((and (stick-state? state) (stick-state-unstick state) (>= clock (+ (stick-state-time state) 1000)))
              (make-descend-state time: clock speed: (random-speed score)))
             ((and (ascend-state? state) (>= clock (+ (ascend-state-time state) +ascend-speed+)))
              (make-stick-state))
             ((and (descend-state? state)
                   (= player (crepe-column crepe))
                   (within-catch-range? clock (descend-state-time state) (descend-state-speed state)))
              (make-ascend-state time: clock))
             (else
              state)))))

;(start-game)
