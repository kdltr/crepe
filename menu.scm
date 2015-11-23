(define board-x (- (quotient +width+ 2) (quotient (sprite-w board-surface) 2)))
(define board-y (+ +highest-point+
                   (quotient (- +height+ +highest-point+) 2)
                   (- (quotient (sprite-h board-surface) 2))))

(define buttons-x (+ board-x
                     (- (quotient (sprite-w board-surface) 2)
                        (quotient (sprite-w button-off-surface) 2))))

(define play-button
  (make-rect buttons-x
             (+ board-y 50)
             (sprite-w button-on-surface)
             (sprite-h button-on-surface)))

(define quit-button
  (make-rect buttons-x
             (+ (sprite-h button-off-surface) (rect-y play-button) 50)
             (sprite-w button-on-surface)
             (sprite-h button-on-surface)))

(define (inside-rect? rect x y)
  (and (>= x (rect-x rect))
       (>= y (rect-y rect))
       (< x (+ (rect-x rect) (rect-w rect)))
       (< y (+ (rect-y rect) (rect-h rect)))))

(define (draw-menu-graphics)
  (show-sprite! background-surface 0 0)
  (show-sprite! board-surface board-x board-y)

  (show-sprite! button-off-surface (rect-x play-button) (rect-y play-button))
  (show-sprite! pins-surface
                (- (rect-x play-button) 10)
                (- (rect-y play-button) (quotient (sprite-h pins-surface) 2)))
  (show-sprite! play-text-surface
                (+ (rect-x play-button)
                   (- (quotient (sprite-w button-off-surface) 2)
                      (quotient (sprite-w play-text-surface) 2)))
                (+ (rect-y play-button)
                   (- (quotient (sprite-h button-off-surface) 2)
                      (quotient (sprite-h play-text-surface) 2))))

  (show-sprite! button-off-surface (rect-x quit-button) (rect-y quit-button))
  (show-sprite! pins-flipped-surface
                (- (rect-x quit-button) 10)
                (- (rect-y quit-button) (quotient (sprite-h pins-surface) 2)))
  (show-sprite! quit-text-surface
                (+ (rect-x quit-button)
                   (- (quotient (sprite-w button-off-surface) 2)
                      (quotient (sprite-w quit-text-surface) 2)))
                (+ (rect-y quit-button)
                   (- (quotient (sprite-h button-off-surface) 2)
                      (quotient (sprite-h quit-text-surface) 2)))))

(define (main-loop-menu)
  (draw-menu-graphics)
  (SDL_RenderPresent renderer)
  (let* ((event (find list? (collect-events!)))
         (type (and event (first event)))
         (x (and event (second event)))
         (y (and event (third event))))
    (when (eq? type 'button-down)
      (cond ((inside-rect? play-button x y)
             (start-game))
            ((inside-rect? quit-button x y)
             (exit 0)))))
  (main-loop-menu))
