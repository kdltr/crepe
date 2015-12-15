;; crepe: list column-number, state
;; state: 'ascend time or 'descend speed time or 'stick
;; board: list of crepe
;; player: integer (number of the column)
;; lives: integer

(defstruct crepe column line state speed last-time)

(defstruct player pos direction body-time head-type head-time)

(defstruct ascend-state time)
(defstruct descend-state speed time)
(defstruct stick-state unstick time)

(define +columns-number+ 5)
(define +lines-number+ 10)

(define +highest-point+ 137)
(define +lowest-point+ 1080)

(define +initial-player+ (make-player pos: 2 direction: 'right body-time: -1000 head-type: 'focus head-time: -1000))
(define +initial-lives+ 3)
(define +initial-score+ 0)

(define (initial-state) (make-stick-state unstick: #f time: (+ (get-ticks) (random 3000))))
(define (initial-board) (list (make-crepe column: 0 state: (initial-state))
                              (make-crepe column: 1 state: (initial-state))
                              (make-crepe column: 2 state: (initial-state))
                              (make-crepe column: 3 state: (initial-state))
                              (make-crepe column: 4 state: (initial-state))))

(define +ascend-speed+ 400)

(define +initial-max-speed+ 1800)
(define +initial-min-speed+ 2000)
(define +maximum-speed+ 600)
(define +minimum-interval+ 500)

(define +score-increment+ 100)

;; game logic

(define (move-player player-pos direction)
  (let* ((increment (case direction ((left) -1) ((right) +1) ((stay) 0)))
         (np (+ player-pos increment)))
    (if (or (< np 0) (>= np +columns-number+))
        player-pos
        np)))

(define (compute-new-player p pos direction throw happy sad clock)
  (let* ((body-time (if throw clock (player-body-time p)))
         (head (or (and happy 'happy) (and sad 'sad) (player-head-type p)))
         (head-time (if (or happy sad) clock (player-head-time p)))
         (new-direction (if (eq? direction 'stay) (player-direction p) direction)))
    (make-player pos: pos
                 direction: new-direction
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
  (let* ((coef (quotient score 10))
         (min-speed (max +maximum-speed+ (- +initial-min-speed+ coef)))
         (max-speed (max +maximum-speed+ (- +initial-max-speed+ coef)))
         (min-date (apply min times))
         (speed (+ min-speed (random (- min-speed max-speed)))))
    (let loop ((speed speed)
               (rest times))
      (cond ((null? rest)
             speed)
            ((> (+ (car rest) +minimum-interval+) (+ clock speed) min-date)
             (loop (+ speed 100) times))
            (else
             (loop speed (cdr rest)))))))

(define (within-catch-range? clock state)
  (> 0.9 (height clock state) 0.65))

(define (launched-crepe? old new)
  (let ((old-state (crepe-state old))
        (new-state (crepe-state new)))
    (and (descend-state? old-state)
         (ascend-state? new-state))))

(define (almost-failed? clock old new)
  (and (launched-crepe? old new)
       (>= (height clock (crepe-state old)) 0.85)))

(define (became-sticky? old new)
  (and (ascend-state? (crepe-state old))
       (stick-state? (crepe-state new))))

(define (became-unsticky? old new)
  (let ((os (crepe-state old))
        (ns (crepe-state new)))
    (and (stick-state? os)
         (stick-state? ns)
         (not (stick-state-unstick os))
         (stick-state-unstick ns))))

(define (fell? old new)
  (and (descend-state? (crepe-state old))
       (stick-state? (crepe-state new))))

(define (should-fall? score state clock)
  (>= clock (stick-state-time state)))

(define (revive-crepes clock board)
  (map
   (lambda (c)
     (if (outside-board? clock c)
         (update-crepe c state: (make-stick-state unstick: #f time: clock))
         c))
   board))

(define (compute-score old-board new-board clock)
  (fold + 0 (map
             (lambda (oc nc)
               (* +score-increment+
                  (+ (if (launched-crepe? oc nc) 1 0)
                     (if (almost-failed? clock oc nc) 1 0))))
             old-board
             new-board)))
