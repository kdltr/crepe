(use
  cairo-utils
  sdl2
  )

(include "logic")

(define white '(1 1 1 1))
(define red '(1 0 0 1))
(define yellow '(1 1 0 1))
(define blue '(0 0 1 1))
(define violet '(1 0 1 1))

(define +width+ 1280)
(define +height+ 720)
(define +column-space+ (quotient +width+ +columns-number+))
(define +line-space+ (quotient +height+ +lines-number+))

(init!)

(define win (create-window! "Crepes-party-hard-yolo-swag 2015"
                            'undefined 'undefined
                            +width+ +height+))

(init-utils! win)

(define (draw-grid)
  (draw-lines)
  (draw-columns))

(define (draw-lines)
  (let loop ((y 0))
    (unless (>= y (* +lines-number+ +line-space+))
      (draw-line 0 y +width+ y color: white)
      (loop (+ y +line-space+)))))

(define (draw-columns)
  (let loop ((x 0))
    (unless (>= x (* +columns-number+ +column-space+))
      (draw-line x 0 x +height+ color: white)
      (loop (+ x +column-space+)))))

(define (draw-player player)
  (filled-rectangle
   (* player +column-space+)
   (* (sub1 +lines-number+) +line-space+)
   +column-space+
   +line-space+
   red))

(define ((draw-crepe clock) crepe)
  (let ((column-number (crepe-column crepe))
        (line-number (crepe-line crepe))
        (color (case (crepe-state crepe) ((descend) yellow) ((ascend) blue) ((stick) violet))))
    (filled-rectangle
     (+ (/ +column-space+ 2)
        (- (* column-number +column-space+) 25))
     (+ (/ +line-space+ 2)
        (- (* line-number +line-space+) 25)
        (crepe-tweening crepe clock))
     50
     50
     color)))

(define (crepe-tweening crepe clock)
  (let ((state (crepe-state crepe))
        (line (crepe-line crepe))
        (speed (crepe-speed crepe))
        (last-time (crepe-last-time crepe)))
    (let ((coef (case state ((ascend) -1) ((descend) +1) ((stick) 0))))
      (* coef
         (/ (- clock last-time)
            (if (eq? state 'descend) speed +ascend-speed+))
         +line-space+))))

(define (draw-game player lives score board clock)
  (clear-screen)
  (draw-player player)
  (for-each (draw-crepe clock) board)
  (draw-grid)
  (font-size 16)
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
             +initial-board+
             +initial-speed-interval+))

(define (main-loop player lives score board speed-interval)
  (let* ((clock (get-ticks))
         (events (collect-events!))
         (direction (get-direction (find keydown-event? events)))
         (new-board (move-crepes clock player board (sub-speed-interval speed-interval score)))
         (lives-lost (count crepe-outside-board? new-board))
         (score-increment (compute-score board new-board)))
    (draw-game player lives score board clock)
    (unless (dead? lives)
      (main-loop (move-player player direction)
                 (- lives lives-lost)
                 (+ score score-increment)
                 (revive-crepes new-board)
		 speed-interval))))

(start-game)

