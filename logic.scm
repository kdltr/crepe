;; crepes: list column-number, line-numer, last-time
;; board: list of 
;; player: integer (number of the column)
;; lives: integer

(use srfi-1)

(define +columns-number+ 5)
(define +lines-number+ 10)
(define +initial-player-position+ 2)
(define +initial-lives+ 3)
(define +initial-score+ 0)
(define +initial-board+ '())
(define +initial-speed+ 1000)

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
  (list (car crepe) (add1 (cadr crepe)) (caddr crepe)))

(define (descend-board board)
  (map descend-crepe board))

(define (crepe-last-line? crepe)
  (= (sub1 +lines-number+) (cadr crepe)))

(define (crepe-outside-board? crepe)
  (>= (cadr crepe) +lines-number+))

(define (dead? lives)
  (zero? lives))

(define (remove-fallen-crepes board)
  (filter (complement crepe-outside-board?) board))

(define (crepes-at-column column-number board)
  (filter
   (lambda (crepe)
     (= column-number (car crepe)))
   board))

(define (crepes-at-line line-number board)
  (filter
   (lambda (crepe)
     (= line-number (cadr crepe)))
   board))

(define (crepe-on-player? player board)
  (any crepe-last-line?
       (crepes-at-column player board)))

(define (crepes-beside-player player board)
  (remove
   (lambda (crepe)
     (= player (car crepe)))
   (crepes-at-line (sub1 +lines-number+) board)))

(define (remove-last-crepe-at column-number board)
  (remove
   (lambda (crepe)
     (and (= (car crepe) column-number)
          (= (cadr crepe) (sub1 +lines-number+))))
   board))

(define (random-crepe)
  (list
   (random +columns-number+)
   0
   (random 2874)))




(define test-column1
  '((0 1 38) (0 3 8943)))

(define test-column2
  '((2 6 83)))

(define test-column3
  '((3 5 823) (3 7 19) (3 8 38)))

(define test-board
  (append test-column1 '() test-column2 test-column3 '() '()))
