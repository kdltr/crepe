(define board-x (- (quotient +width+ 2) (quotient (sprite-w board-surface) 2)))
(define board-y (+ +highest-point+
                   (quotient (- +height+ +highest-point+) 2)
                   (- (quotient (sprite-h board-surface) 2))))

(define buttons-x (+ board-x
                     (- (quotient (sprite-w board-surface) 2)
                        (quotient (sprite-w button-off-surface) 2))))

(define board
  (make-rect board-x board-y (sprite-w board-surface) (sprite-h board-surface)))

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

(define credits-button
  (make-rect (+ board-x
                (sprite-w board-surface)
                (- (sprite-w button-credits-surface))
                (- 47))
             (+ board-y
                (sprite-h board-surface)
                (- (sprite-h button-credits-surface))
                (- 40))
             (sprite-w button-credits-surface)
             (sprite-h button-credits-surface)))

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

(define (draw-menu-graphics! x y score)
  (show-sprite! background-surface 0 0)
  (show-sprite! board-surface board-x board-y)
  (draw-button! x y play-button play-text-surface)
  (draw-button! x y quit-button quit-text-surface)
  (show-sprite! button-credits-surface
                (rect-x credits-button)
                (rect-y credits-button))
  (draw-score! score)
  (SDL_RenderPresent renderer))

(define (menu-main-loop x y score)
  (draw-menu-graphics! x y score)
  (let* ((event (find list? (collect-events!)))
         (type (and event (first event)))
         (new-x (and event (second event)))
         (new-y (and event (third event)))
	 (new-score (and (eq? type 'button-down)
                         (inside-rect? play-button new-x new-y)
                         (start-game))))
    (when (eq? type 'button-down)
      (cond
       ((inside-rect? quit-button x y)
	(exit 0))
       ((inside-rect? credits-button x y)
	(credits-main-loop))))
    (if (eq? type 'motion)
        (menu-main-loop new-x new-y (or new-score score))
        (menu-main-loop x y (or new-score score)))))

(define (draw-credits!)
  (show-sprite! background-surface 0 0)
  (show-sprite! credits-surface board-x board-y)
  (SDL_RenderPresent renderer))

(define (credits-main-loop)
  (draw-credits!)
  (let* ((event (find list? (collect-events!)))
         (type (and event (first event)))
         (x (and event (second event)))
         (y (and event (third event))))
    (unless (and (eq? type 'button-down)
                 (inside-rect? board x y))
      (credits-main-loop))))
