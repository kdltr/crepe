;; crepe: list column-number, line-numer, state, speed, last-time
;; state: 'ascend or 'descend or 'stick
;; board: list of crepe
;; player: integer (number of the column)
;; lives: integer

(use srfi-1 defstruct)

(defstruct crepe column line state speed last-time)

(define +columns-number+ 5)
(define +lines-number+ 10)
(define +initial-player-position+ 2)
(define +initial-lives+ 3)
(define +initial-score+ 0)
(define +initial-board+ (list (make-crepe column: 0 line: 0 state: 'stick speed: 1 last-time: 0)
                              (make-crepe column: 1 line: 0 state: 'stick speed: 1 last-time: 0)
                              (make-crepe column: 2 line: 0 state: 'stick speed: 1 last-time: 0)
                              (make-crepe column: 3 line: 0 state: 'stick speed: 1 last-time: 0)
                              (make-crepe column: 4 line: 0 state: 'stick speed: 1 last-time: 0)))
(define +ascend-speed+ 50)
(define +maximum-stick-time+ 1000)
(define +initial-speed-interval+ '(900 600))


;; game logic

(define (move-player player direction)
  (let* ((increment (case direction ((left) -1) ((right) +1) ((stay) 0)))
         (np (+ player increment)))
    (if (or (< np 0) (>= np +columns-number+))
        player
        np)))

(define (crepe-outside-board? crepe)
  (>= (crepe-line crepe) +lines-number+))

(define (dead? lives)
  (zero? lives))

(define (random-speed speed-interval)
  (+ (car speed-interval)
     (random (- (cadr speed-interval) (car speed-interval)))))

(define (should-fall? clock last-time)
  (let ((duration (- clock last-time)))
    (= (random +maximum-stick-time+) (sub1 +maximum-stick-time+))))

(define (revive-crepes board)
  (map
   (lambda (c)
     (if (crepe-outside-board? c)
         (update-crepe c
                       line: 0
                       state: 'stick)
         c))
   board))

(define (compute-score old-board new-board)
  (fold + 0 (map
             (lambda (oc nc)
               (let ((old-state (crepe-state oc))
                     (new-state (crepe-state nc)))
                 (if (and (eq? old-state 'descend)
                          (eq? new-state 'ascend))
                     (- 1000 (crepe-speed oc))
                     0)))
             old-board
             new-board)))

(define (move-crepes clock player board speed-interval)
  (map
   (lambda (c) (move-crepe clock player c speed-interval))
   board))

(define (move-crepe clock player crepe speed-interval)
  (with-slots crepe crepe (speed last-time state line column)
    (let* ((should-fall (should-fall? clock last-time))
           (next-state (compute-next-state state line column should-fall player))
           (next-line (case next-state
                        ((ascend) (sub1 line))
                        ((descend) (add1 line))
                        ((stick) line)))
           (next-speed (if (eq? state 'stick) (random-speed speed-interval) speed))
           (timeout (>= clock (+ last-time (if (eq? next-state 'ascend) +ascend-speed+ next-speed)))))
      (update-crepe crepe
                    speed: next-speed
                    line: (if (or timeout (and (eq? state 'stick) should-fall)) next-line line)
                    state: next-state ;; next-state
                    last-time: (if (or timeout (and (eq? state 'stick) should-fall)) clock last-time)))))

(define (compute-next-state state line column should-fall player)
  (cond ((and (eq? state 'stick) should-fall)
         'descend)
        ((and (not (eq? state 'stick)) (= line 0))
            'stick)
        ((and (= line (- +lines-number+ 2))
              (= player column))
         'ascend)
        (else state)))

(define (sub-speed-interval speed-interval score)
  (cons
   (if (> (car speed-interval) 300)
       (if (< (* 15 (quotient score 1500)) 600)
	   (- (car speed-interval) (* 15 (quotient score 1500))) 300) 300)
   (cons
    (if (> (cadr speed-interval) 100)
	(if (< (* 15 (quotient score 1500)) 500)
	    (- (cadr speed-interval) (* 15 (quotient score 1500))) 100) 100)
    '())))
