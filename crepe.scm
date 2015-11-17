(use
  cairo-utils
  sdl2
  (prefix sdl2-image img:)
  )

(include "syntax")
(include "logic")

(define white '(1 1 1 1))
(define black '(0 0 0 1))
(define red '(1 0 0 1))
(define yellow '(1 1 0 1))
(define blue '(0 0 1 1))
(define violet '(1 0 1 1))

(define +width+ 1280)
(define +height+ 720)
(define +column-space+ (quotient +width+ +columns-number+))
(define +line-space+ (quotient +height+ +lines-number+))

(init!)
(assert (member 'png (img:init! '(png))))

(define crepe-down-surface (img:load "graph/down.png"))
(define crepe-up-surface (img:load "graph/up.png"))
(define crepe-left-surface (img:load "graph/left.png"))
(define crepe-right-surface (img:load "graph/right.png"))
(define crepe-stick-surface (img:load "graph/sticky-full.pngxb"))
(define background-surface (img:load "graph/background.png"))

(assert (and crepe-down-surface
             crepe-up-surface
             crepe-left-surface
             crepe-right-surface
             crepe-stick-surface
             background-surface))

(define win (create-window! "Crepes-party-hard-yolo-swag 2015"
                            'undefined 'undefined
                            +width+ +height+))

(define win-surface (window-surface win))

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
  (let ((w 120)
        (h 300))
   (filled-rectangle
    (+ (* player +column-space+) (/ w 2))
    (- (* (sub1 +lines-number+) +line-space+) (/ h 2))
    w h
    ;; +column-space+ +line-space+
    red)))

(define (get-crepe-surface crepe clock)
  (with-slots crepe crepe (column line state speed)
    (cond
     ((eq? state 'ascend) crepe-up-surface)
     ((eq? state 'stick) crepe-stick-surface)
     ((< (sin (/ clock speed)) -0.4) crepe-left-surface)
     ((and (> (sin (/ clock speed)) -0.4) (< (sin (/ clock speed)) 0.4)) crepe-down-surface)
     ((> (sin (/ clock speed)) 0.4) crepe-right-surface))))

(define ((draw-crepe clock) crepe)
  (with-slots crepe crepe (column line state speed)
    (let* ((color (case state ((descend) yellow) ((ascend) blue) ((stick) violet)))
	   (speed (case state ((ascend) +ascend-speed+) (else speed)))
	   (x (* (quotient +column-space+ 4) (sin (/ clock speed))))
	   (surface (get-crepe-surface crepe clock)))
      (blit-surface!
       surface
       #f
       win-surface
       (make-rect
        (round
         (+ (/ +column-space+ 2)
            (- (* column +column-space+) (/ (surface-w surface) 2))
            (if (eq? 'descend state)
                x
                0)))
        (round
         (+ (/ +line-space+ 2)
            (- (* line +line-space+) (/ (surface-h surface) 2))
            (crepe-tweening crepe clock))))))))

(define (crepe-tweening crepe clock)
  (with-slots crepe crepe (state line speed last-time)
    (let ((coef (case state ((ascend) -1) ((descend) +1) ((stick) 0))))
      (* coef
         (/ (- clock last-time)
            (if (eq? state 'descend) speed +ascend-speed+))
         +line-space+))))

(define (draw-game player lives score board clock)
  (blit-surface! background-surface #f win-surface #f)
  (draw-player player)
  (for-each (draw-crepe clock) board)
  ;; (draw-grid)
  (font-size 16)
  (font-color black)
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
             +initial-board+))

(define (main-loop player lives score board)
  (let* ((clock (get-ticks))
         (events (collect-events!))
         (direction (get-direction (find keydown-event? events)))
         (speed-interval (sub-speed-interval +initial-speed-interval+ score))
         (new-board (move-crepes clock player board speed-interval))
         (lives-lost (count crepe-outside-board? new-board))
         (score-increment (compute-score board new-board)))
    (draw-game player lives score board clock)
    (unless (handle-repl)
      (main-loop (move-player player direction)
                 (- lives lives-lost)
                 (+ score score-increment)
                 (revive-crepes new-board)))))

(define (handle-repl)
  (if (char-ready?)
   (let ((sexp (read)))
     (if (eof-object? sexp)
         #t
         (begin
           (write (eval sexp))
           (newline)
           #f)))
   #f))

(start-game)
