
(include "logic")

(define +column-space+ (quotient +width+ +columns-number+))
(define +line-space+ (quotient +height+ +lines-number+))


(define (draw-player player clock)
  (let* ((w (sprite-w body-low-surface))
         (h (sprite-h body-low-surface))
         (x (* (player-pos player) +column-space+))
         (y (- +height+ h))
         (body (if (<= clock (+ 250 (player-body-time player)))
                   body-high-surface
                   body-low-surface))
         (head (if (<= clock (+ 1000 (player-head-time player)))
                   (case (player-head-type player)
                     ((sad) head-sad-surface)
                     ((happy) head-happy-surface))
                   head-focus-surface)))
    (show-sprite! body x y)
    (show-sprite! head x y)))

(define (crepe-surface state wiggle)
  (match state
    (($ ascend-state)
     crepe-up-surface)
    (($ stick-state unstick)
     (if unstick crepe-unstick-surface crepe-stick-surface))
    (($ descend-state)
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
    (show-sprite!
     surface
     (round
      (+ (/ +column-space+ 2)
         (- (* column +column-space+) (/ (sprite-w surface) 2))
         (if (descend-state? state) (* (quotient +column-space+ 4) wiggle) 0)))
     (round
      (crepe-y state clock)))))

(define (crepe-y state clock)
  (+ +highest-point+
     (* (height clock state)
	(if (ascend-state? state) (- (- +lowest-point+ 300) +highest-point+) (- +lowest-point+ +highest-point+)))))

(define char-width (quotient (sprite-w font-surface) 10))

(define draw-score
  (let ((r1 (make-rect 0 0 char-width (sprite-h font-surface)))
        (r2 (make-rect 0 5 char-width (sprite-h font-surface))))
    (lambda (score)
      (draw-score-text!)
      (let loop ((text (number->list score))
                 (x (sprite-w score-text-surface)))
        (unless (null? text)
          (set! (rect-x r1) (* (car text) char-width))
          (set! (rect-x r2) x)
          (SDL_RenderCopy renderer
                          (sprite-texture font-surface)
                          r1
                          r2)
          (loop (cdr text) (+ x char-width)))))))

(define (number->list n)
  (map (o (lambda (i) (- i (char->integer #\0))) char->integer)
       (string->list (number->string n))))

(define (draw-score-text!)
  (show-sprite! score-text-surface 0 5))

(define (draw-lives lives)
  (let ((orig-x (- +width+
                   (sprite-w lives-text-surface)
                   (* +initial-lives+ (sprite-w heart-surface))
                   5)))
    (show-sprite! lives-text-surface orig-x 5)
    (let loop ((n lives)
               (x (+ orig-x (sprite-w lives-text-surface))))
      (unless (zero? n)
        (begin
          (show-sprite! heart-surface x 5)
          (loop (sub1 n) (+ x (sprite-w heart-surface))))))))

(define (draw-game player lives score board clock)
  (show-sprite! background-surface 0 0)
  (draw-player player clock)
  (for-each (draw-crepe clock) board)
  (draw-score score)
  (draw-lives lives)
  (SDL_RenderPresent renderer))

(define (start-game)
  (main-loop +initial-player+
	     +initial-lives+
	     +initial-score+
	     +initial-board+))

(define (keydown-event? ev)
  (eq? (event-type ev) 'key-down))

(define (get-direction scancode)
  (if scancode
      (case scancode
        ((left) 'left)
        ((right) 'right)
        (else 'stay))
      'stay))

(define (main-loop player lives score board)
  (let* ((clock (get-ticks))
         (new-player-pos (move-player (player-pos player) (get-direction (find symbol? (collect-events!)))))
         (new-board (map (compute-crepe clock new-player-pos score (final-times board)) board))
         (score-increment (compute-score board new-board))
         (lives-lost (count (lambda (c) (outside-board? clock c)) new-board))
         (new-player (compute-new-player player
                                         new-player-pos
                                         (> score-increment 0)
                                         (any (cut almost-failed? clock <> <>) board new-board)
                                         (any (cut outside-reach? clock <>) new-board)
                                         clock)))
    (draw-game player lives score board clock)
    (if (dead? lives)
	score
	(main-loop new-player
		   (- lives lives-lost)
		   (+ score score-increment)
		   (revive-crepes clock new-board)))))

(define ((compute-crepe clock player score times) crepe)
  (let ((state (crepe-state crepe)))
    (update-crepe
     crepe
     state: (cond
	     ((and (stick-state? state) (not (stick-state-unstick state)) (should-fall?))
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
