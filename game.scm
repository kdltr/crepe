
(include "logic")

(define +column-space+ (quotient +width+ +columns-number+))
(define +line-space+ (quotient +height+ +lines-number+))


(define (draw-player player)
  (let ((w (surface-w character-surface))
        (h (surface-h character-surface)))
    (blit-surface! character-surface
                   #f
                   win-surface
                   (make-rect (* player +column-space+)
                              (- +height+ h)))))

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

(define char-width (quotient (surface-w font-surface) 10))

(define (draw-score score)
  (draw-score-text!)
  (let loop ((text (number->list score))
             (x (surface-w score-text-surface)))
    (unless (null? text)
      (blit-surface! font-surface
                     (make-rect (* (car text) char-width)
                                0
                                char-width
                                (surface-h font-surface))
                     win-surface
                     (make-rect x 5))
      (loop (cdr text) (+ x char-width)))))

(define (number->list n)
  (map (o (lambda (i) (- i (char->integer #\0))) char->integer)
       (string->list (number->string n))))

(define (draw-score-text!)
  (blit-surface!
   score-text-surface
   #f
   win-surface
   (make-rect 0 5)))

(define (draw-lives lives)
  (let ((orig-x (- +width+
                   (surface-w lives-text-surface)
                   (* +initial-lives+ (surface-w heart-surface))
                   5)))
    (blit-surface! lives-text-surface #f
                   win-surface (make-rect orig-x 5))
    (let loop ((n lives)
               (x (+ orig-x (surface-w lives-text-surface))))
      (unless (zero? n)
        (begin
          (blit-surface! heart-surface #f
                         win-surface (make-rect x 5))
          (loop (sub1 n) (+ x (surface-w heart-surface))))))))

(define (draw-game player lives score board clock)
  (blit-surface! background-surface #f win-surface #f)
  (draw-player player)
  (for-each (draw-crepe clock) board)
  (draw-score score)
  (draw-lives lives)
  (update-window-surface! win)
  )

(define (start-game)
  (main-loop +initial-player-position+
	     +initial-lives+
	     +initial-score+
	     +initial-board+))

(define (keydown-event? ev)
  (eq? (event-type ev) 'key-down))

(define (get-direction event)
  (if event
      (case (keyboard-event-scancode event)
        ((left) 'left)
        ((right) 'right)
        (else 'stay))
      'stay))

(define (main-loop player lives score board)
  (let* ((clock (get-ticks))
         (new-player (move-player player (get-direction (find keydown-event? (collect-events!)))))
         (new-board (map (compute-crepe clock new-player score (final-times board)) board))
         (score-increment (compute-score board new-board))
         (lives-lost (count (lambda (c) (outside-board? clock c)) new-board)))
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

