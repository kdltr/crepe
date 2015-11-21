(define play-button
  (make-rect (- (/ +width+ 2) 115) (- (/ +height+ 3) 30) 230 60))

(define quit-button
  (make-rect (- (/ +width+ 2) 115) (- (/ +height+ 2) 30) 230 60))

(define (inside-rect? rect x y)
  (and (>= x (rect-x rect))
       (>= y (rect-y rect))
       (< x (+ (rect-x rect) (rect-w rect)))
       (< y (+ (rect-y rect) (rect-h rect)))))

(define (draw-menu-graphics)
  (show-sprite! background-surface 0 0)
  (SDL_SetRenderDrawColor renderer 255 0 0 255)
  (SDL_RenderFillRect renderer play-button)
  (SDL_RenderFillRect renderer quit-button))

(define (main-loop-menu)
  (draw-menu-graphics)
  (SDL_RenderPresent renderer)
  (let* ((event (find mouse-button-event? (collect-events!)))
         (x (and event (mouse-button-event-x event)))
         (y (and event (mouse-button-event-y event))))
    (when event
      (cond ((inside-rect? play-button x y)
             (start-game))
            ((inside-rect? quit-button x y)
             (exit 0)))))
  (main-loop-menu))
