(define board-x (- (quotient +width+ 2) (quotient (sprite-w board-surface) 2)))
(define board-y (+ +highest-point+
                   (quotient (- +height+ +highest-point+) 2)
                   (- (quotient (sprite-h board-surface) 2))))

(define buttons-x (+ board-x
                     (- (quotient (sprite-w board-surface) 2)
                        (quotient (sprite-w button-off-surface) 2))))

(define play-button
  (make-rect buttons-x
             (+ board-y 125)
             (sprite-w button-on-surface)
             (sprite-h button-on-surface)))

(define quit-button
  (make-rect buttons-x
             (+ (sprite-h button-off-surface) (rect-y play-button) 85)
             (sprite-w button-on-surface)
             (sprite-h button-on-surface)))

(define (inside-rect? rect x y)
  (and (>= x (rect-x rect))
       (>= y (rect-y rect))
       (< x (+ (rect-x rect) (rect-w rect)))
       (< y (+ (rect-y rect) (rect-h rect)))))

(define (draw-button! x y rect text)
  (show-sprite! (if (inside-rect? rect x y) button-on-surface button-off-surface)
                (rect-x rect) (rect-y rect))
  (show-sprite! pins-surface
                (- (rect-x rect)
                   (- (quotient (sprite-w pins-surface) 2)
                      (quotient (sprite-w button-on-surface) 2)))
                (- (rect-y rect) (quotient (sprite-h pins-surface) 2)))
  (show-sprite! text
                (+ (rect-x rect)
                   (- (quotient (sprite-w button-on-surface) 2)
                      (quotient (sprite-w text) 2)))
                (+ (rect-y rect)
                   (- (quotient (sprite-h button-on-surface) 2)
                      (quotient (sprite-h text) 2)))))

(define (draw-menu-graphics x y)
  (show-sprite! background-surface 0 0)
  (show-sprite! board-surface board-x board-y)
  (draw-button! x y play-button play-text-surface)
  (draw-button! x y quit-button quit-text-surface)
  (show-sprite! button-credits-surface
                (+ board-x
                   (sprite-w board-surface)
                   (- (sprite-w button-credits-surface))
                   (- 47))
                (+ board-y
                   (sprite-h board-surface)
                   (- (sprite-h button-credits-surface))
                   (- 40)))
  (SDL_RenderPresent renderer))

(define (main-loop-menu x y)
  (draw-menu-graphics x y)
  (let* ((event (find list? (collect-events!)))
         (type (and event (first event)))
         (new-x (and event (second event)))
         (new-y (and event (third event))))
    (when (eq? type 'button-down)
      (cond ((inside-rect? play-button x y)
             (start-game))
            ((inside-rect? quit-button x y)
             (exit 0))))
    (if (eq? type 'motion) (main-loop-menu new-x new-y) (main-loop-menu x y))))
