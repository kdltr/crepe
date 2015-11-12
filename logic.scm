;; crepes: list column-number, line-numer, state, speed, last-time
;; state: 'ascend or 'descend or 'stick
;; board: list of 
;; player: integer (number of the column)
;; lives: integer

(use srfi-1 defstruct)

(defstruct crepe column line state speed last-time)

(define +columns-number+ 5)
(define +lines-number+ 10)
(define +initial-player-position+ 2)
(define +initial-lives+ 3)
(define +initial-score+ 0)
(define +initial-board+ (list (make-crepe column: 0 line: 0 state: 'stick speed: 0 last-time: 0)
                              (make-crepe column: 1 line: 0 state: 'stick speed: 0 last-time: 0)
                              (make-crepe column: 2 line: 0 state: 'stick speed: 0 last-time: 0)
                              (make-crepe column: 3 line: 0 state: 'stick speed: 0 last-time: 0)
                              (make-crepe column: 4 line: 0 state: 'stick speed: 0 last-time: 0)))
(define +initial-speed+ 1000)
(define +ascend-speed+ 500)
(define +minimum-speed+ 900)
(define +maximum-speed+ 300)
(define +maximum-stick-time+ 1000)

;; Helpers

(define (remove-at index list)
  (cond
   ((null? list) '())
   ((zero? index) (cdr list))
   (else (cons (car list) (remove-at (sub1 index) (cdr list))))))


;; Game Logic

(define (move-player player direction)
  (let* ((increment (case direction ((left) -1) ((right) +1) ((stay) 0)))
         (np (+ player increment)))
    (if (or (< np 0) (>= np +columns-number+))
        player
        np)))

(define (descend-crepe crepe)
  (update-crepe crepe line: (add1 (crepe-line crepe))))

(define (descend-board board)
  (map descend-crepe board))

(define (crepe-last-line? crepe)
  (= (sub1 +lines-number+) (crepe-line crepe)))

(define (crepe-outside-board? crepe)
  (>= (crepe-line crepe) +lines-number+))

(define (dead? lives)
  (zero? lives))

(define (remove-fallen-crepes board)
  (filter (complement crepe-outside-board?) board))

(define (crepes-at-column column-number board)
  (filter
   (lambda (crepe)
     (= column-number (crepe-column crepe)))
   board))

(define (crepes-at-line line-number board)
  (filter
   (lambda (crepe)
     (= line-number (crepe-line crepe)))
   board))

(define (crepe-on-player? player board)
  (any crepe-last-line?
       (crepes-at-column player board)))

(define (crepes-beside-player player board)
  (remove
   (lambda (crepe)
     (= player (crepe-column crepe)))
   (crepes-at-line (sub1 +lines-number+) board)))

(define (remove-last-crepe-at column-number board)
  (remove
   (lambda (crepe)
     (and (= (crepe-column crepe) column-number)
          (= (crepe-line crepe) (sub1 +lines-number+))))
   board))

(define (random-crepe)
  (make-crepe
   column: (random +columns-number+)
   line: 0
   state: 'descend
   speed: 1000
   last-time: 0))

(define (random-speed)
  (+ +minimum-speed+
     (random (- +maximum-speed+ +minimum-speed+))))

(define (should-fall? clock last-time)
  (let ((duration (- clock last-time)))
    (= (random +maximum-stick-time+) (sub1 +maximum-stick-time+))))

(define (move-crepes clock player board)
  (map
   (lambda (c) (move-crepe clock player c))
   board))

(define (move-crepe clock player crepe)
  (let ((speed (crepe-speed crepe))
        (last-time (crepe-last-time crepe))
        (state (crepe-state crepe))
        (line (crepe-line crepe))
        (column (crepe-column crepe)))
    (let* ((should-fall (should-fall? clock last-time))
           (next-state (compute-next-state state line column should-fall player))
           (next-line (case next-state
                        ((ascend) (sub1 line))
                        ((descend) (add1 line))
                        ((stick) line)))
           (next-speed (if (eq? state 'stick) (random-speed) speed))
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

(define test-column1
  '((0 1 38) (0 3 8943)))

(define test-column2
  '((2 6 83)))

(define test-column3
  '((3 5 823) (3 7 19) (3 8 38)))

(define test-board
  (append test-column1 '() test-column2 test-column3 '() '()))
