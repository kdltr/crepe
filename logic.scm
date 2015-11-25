;; crepe: list column-number, state
;; state: 'ascend time or 'descend speed time or 'stick
;; board: list of crepe
;; player: integer (number of the column)
;; lives: integer

(defstruct crepe column line state speed last-time)

(defstruct player pos body-time head-type head-time)

(defstruct ascend-state time)
(defstruct descend-state speed time)
(defstruct stick-state unstick time)

(define +columns-number+ 5)
(define +lines-number+ 10)

(define +highest-point+ 135)
(define +lowest-point+ 1080)

(define +initial-player+ (make-player pos: 2 body-time: -1000 head-type: 'focus head-time: -1000))
(define +initial-lives+ 3)
(define +initial-score+ 0)
(define +initial-board+ (list (make-crepe column: 0 state: (make-stick-state #f))
                              (make-crepe column: 1 state: (make-stick-state #f))
                              (make-crepe column: 2 state: (make-stick-state #f))
                              (make-crepe column: 3 state: (make-stick-state #f))
                              (make-crepe column: 4 state: (make-stick-state #f))))

(define +ascend-speed+ 400)
(define +maximum-stick-time+ 500)

(define +initial-max-speed+ 1700)
(define +initial-min-speed+ 2000)
(define +maximum-speed+ 300)

;; game logic

(define (move-player player-pos direction)
  (let* ((increment (case direction ((left) -1) ((right) +1) ((stay) 0)))
         (np (+ player-pos increment)))
    (if (or (< np 0) (>= np +columns-number+))
        player-pos
        np)))

(define (compute-new-player p pos throw happy sad clock)
  (let* ((body-time (if throw clock (player-body-time p)))
         (head (or (and happy 'happy) (and sad 'sad) (player-head-type p)))
         (head-time (if (or happy sad) clock (player-head-time p))))
    (make-player pos: pos
                 body-time: body-time
                 head-type: head
                 head-time: head-time)))

(define (height clock state)
  (match state
    (($ stick-state)
     0)
    (($ ascend-state time)
     (- 1 (/ (- clock time) +ascend-speed+)))
    (($ descend-state speed time)
     (/ (- clock time) speed))))

(define (final-time state)
  (if (descend-state? state)
      (+ (descend-state-time state)
         (descend-state-speed state))
      0))

(define (final-times board)
  (map (o final-time crepe-state) board))

(define (outside-reach? clock crepe)
  (let ((state (crepe-state crepe)))
    (and (descend-state? state)
         (>= clock
             (final-time state)))))

(define (outside-board? clock crepe)
  (outside-reach? (- clock 500) crepe))

(define (dead? lives)
  (zero? lives))

(define (random-speed times clock score)
  (let* ((coef (/ score 50))
         (min-speed (- +initial-min-speed+ coef))
         (max-speed (- +initial-max-speed+ coef))
         (speed (inexact->exact
                 (round (+ (max +maximum-speed+ min-speed)
                           (random (inexact->exact (round (- min-speed max-speed)))))))))
    (let loop ((speed speed)
               (time (+ clock speed))
               (times times))
      (if (null? times)
          speed
          (let* ((t1 (car times)))
            (if (> (+ t1 300) time (- t1 300))
                (loop (+ speed 300) (+ clock speed 300) (cdr times))
                (loop speed time (cdr times))))))))

(define (within-catch-range? clock time speed)
  (let ((height (/ (- clock time) speed)))
    (> 0.9 height 0.7)))

(define (almost-failed? clock old-crepe new-crepe)
  (let ((old-state (crepe-state old-crepe))
        (new-state (crepe-state new-crepe)))
    (and (descend-state? old-state)
         (ascend-state? new-state)
         (>= (height clock old-state) 0.85))))

(define (should-fall?)
  (= (random +maximum-stick-time+) (sub1 +maximum-stick-time+)))

(define (revive-crepes clock board)
  (map
   (lambda (c)
     (if (outside-board? clock c)
         (update-crepe c state: (make-stick-state #f))
         c))
   board))

(define (compute-score old-board new-board)
  (fold + 0 (map
             (lambda (oc nc)
               (let ((old-state (crepe-state oc))
                     (new-state (crepe-state nc)))
                 (if (and (descend-state? old-state)
                          (ascend-state? new-state))
                     (- 2500 (descend-state-speed old-state))
                     0)))
             old-board
             new-board)))
