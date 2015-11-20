(define (draw-menu-graphics)
  (blit-surface! background-surface #f win-surface #f)
  (fill-rect! win-surface
	      (make-rect (- (/ +width+ 2) 115) (- (/ +height+ 2) 30) 230 60)
	      red)
  (fill-rect! win-surface
	      (make-rect (- (/ +width+ 2) 115) (- (/ +height+ 3) 30) 230 60)
	      red))

(define (main-loop-menu f)
  (draw-menu-graphics)
  (update-window-surface! win)
  (let* ((event (find mouse-button-event? (collect-events!)))
	(score
	 (cond
	  (event
	   (cond
	    ((and (> (mouse-button-event-x event) (- (/ +width+ 2) 115))
		  (< (mouse-button-event-x event) (+ (- (/ +width+ 2) 115) 230))
		  (> (mouse-button-event-y event) (- (/ +height+ 3) 30))
		  (< (mouse-button-event-y event) (+ (- (/ +height+ 3) 30) 60)))
	     (print (start-game)))
	    (else 0)))
	  (else 0))))
    score)
  (main-loop-menu f))
