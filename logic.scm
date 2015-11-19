;; crepe: list column-number, state
;; state: 'ascend time or 'descend speed time or 'stick
;; board: list of crepe
;; player: integer (number of the column)
;; lives: integer

(use srfi-1 defstruct)

(defstruct crepe column line state speed last-time)

(defstruct ascend-state time)
(defstruct descend-state speed time)
(defstruct stick-state unstick time)

(define +columns-number+ 5)
(define +lines-number+ 10)

(define +highest-point+ 88)
(define +lowest-point+ 720)

(define +initial-player-position+ 2)
(define +initial-lives+ 3)
(define +initial-score+ 0)
(define +initial-board+ (list (make-crepe column: 0 state: (make-stick-state #f))
                              (make-crepe column: 1 state: (make-stick-state #f))
                              (make-crepe column: 2 state: (make-stick-state #f))
                              (make-crepe column: 3 state: (make-stick-state #f))
                              (make-crepe column: 4 state: (make-stick-state #f))))

(define +ascend-speed+ 1000)
(define +maximum-stick-time+ 500)

(define +initial-max-speed+ 1700)
(define +initial-min-speed+ 2000)
(define +maximum-speed+ 300)

;; game logic

(define (move-player player direction)
  (let* ((increment (case direction ((left) -1) ((right) +1) ((stay) 0)))
         (np (+ player increment)))
    (if (or (< np 0) (>= np +columns-number+))
        player
        np)))

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

(define (outside-board? clock crepe)
  (let ((state (crepe-state crepe)))
    (and (descend-state? state)
         (>= clock
             (+ 500 (final-time state))))))

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
    (> 1 height 0.8)))

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
