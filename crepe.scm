(use
  cairo-utils
  sdl2
  )

(include "logic")

(define white '(1 1 1 1))
(define red '(1 0 0 1))
(define yellow '(1 1 0 1))

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

(define (draw-board board)
  (for-each draw-crepe board))

(define (draw-crepe crepe)
  (let ((column-number (car crepe))
        (line-number (cadr crepe)))
   (filled-rectangle
    (+ (/ +column-space+ 2)
       (- (* column-number +column-space+) 25))
    (+ (/ +line-space+ 2)
       (- (* line-number +line-space+) 25))
    50
    50
    yellow)))

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
  (main-loop (get-ticks)
             +initial-speed+
             +initial-player-position+
             +initial-lives+
             +initial-score+
             +initial-board+))

(define (main-loop last-drop speed player lives score board)
  (clear-screen)
  (draw-player player)
  (draw-board board)
  (draw-grid)
  (font-size 16)
  (text (- +width+ 10) 20 (sprintf "Speed: ~A  Lives: ~A  Score: ~A" speed lives score) align: #:right)
  (show!)
  (let* ((clock (get-ticks))
         (events (collect-events!))
         (direction (get-direction (find keydown-event? events)))
         (crepe-taken (crepe-on-player? player board))
         (new-score (if crepe-taken (+ score 100) score))
         (must-descend (>= (- clock last-drop) speed))
         (new-board
          (if must-descend
              (cons (random-crepe)
                    (descend-board (remove-last-crepe-at player board)))
              (remove-last-crepe-at player board)))
         (fallen-number (count crepe-outside-board? new-board)))
    (unless (dead? lives)
      (main-loop (if must-descend clock last-drop)
                 (if (and crepe-taken (zero? (modulo new-score 500)))
                     (* speed 0.90)
                     speed)
                 (move-player player direction)
                 (- lives fallen-number)
                 new-score
                 (remove-fallen-crepes new-board)))))

(start-game)
