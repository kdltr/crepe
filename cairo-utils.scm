(module cairo-utils
    (*cairo-context*
     frequency
     solid-white
     solid-black
     font-color
     font-size
     current-background
     init-utils!
     text-width
     text
     clear-screen
     filled-rectangle
     draw-line
     show!
     for-events
     map-events)

  (import scheme chicken)

  (use sdl2
       cairo
       clojurian-syntax
       srfi-1
       srfi-4
       )
  
  (define *sdl-window* #f)
  (define *cairo-surface* #f)
  (define *cairo-context* #f)

  (define frequency (get-performance-frequency))
  (define solid-black (list 0 0 0 1))
  (define solid-white (list 1 1 1 1))

  
  (define *font-color* '(1 1 1 1))
  (define (font-color . c)
    (if (null? c)
        *font-color*
        (set! *font-color* (car c))))
  (define *font-size* 12)
  (define (font-size . s)
    (if (null? s)
        *font-size*
        (set! *font-size* (car s))))

  (define *current-background* '(0 0 0 1))
  (define (current-background . c)
    (if (null? c)
        *current-background*
        (set! *current-background* (car c))))

  (define *line-width* 2.0)
  (define (line-width . w)
    (if (null? w)
        *line-width*
        (set! *line-width* (car w))))

  (define-syntax set-color
    (syntax-rules ()
      ((_ color) (apply cairo-set-source-rgba `(,*cairo-context* ,@color)))))
  
  (define (sdl-colorspace->cairo bytes-per-pixel)
    (case (* 8 bytes-per-pixel)
      ((8) CAIRO_FORMAT_A8)
      ((24) CAIRO_FORMAT_RGB24)
      ((32) CAIRO_FORMAT_ARGB32)
      (else CAIRO_FORMAT_ARGB32)))

  (define (init-utils! window)
    (set! *sdl-window* window)
    (let-values (((width height) (window-size window))
                 ((window-surface) (window-surface window)))
      (set! *cairo-surface*
        (cairo-image-surface-create-for-data
         (surface-pixels-raw window-surface)
         (sdl-colorspace->cairo
          (pixel-format-bytes-per-pixel
           (surface-format window-surface)))
         width
         height
         (surface-pitch window-surface)))
      (set! *cairo-context* (cairo-create *cairo-surface*))))

  (define (text-width text)
    (let ((ex (make-cairo-text-extents-type)))
      (cairo-set-font-size *cairo-context* *font-size*)
      (cairo-text-extents *cairo-context* text ex)
      (values (cairo-text-extents-width ex)
              (cairo-text-extents-height ex))))

  (define (text x y text #!key (align #:left))
    (define (overall-height text)
      (let ((l (if (list? text) text (list text))))
        (fold (lambda (t s)
                (let-values (((w h) (text-width t)))
                  (+ s (* 1.5 h))))
              0
              l)))

    (define (draw-text x y text align)
      (let-values (((w h) (text-width text)))
        (let ((fx (case align
                    ((#:center) (- x (/ w 2)))
                    ((#:left) x)
                    ((#:right) (- x w))
                    (else x)))
              (fy y))
          (apply cairo-set-source-rgba (cons *cairo-context* *font-color*))
          (doto *cairo-context*
                (cairo-move-to fx fy)
                (cairo-set-font-size *font-size*)
                (cairo-show-text text))
          h)))
    (if (list? text)
        (for-each (let ((y (if (eq? align #:center)
                               (- y (/ (overall-height text) 4))
                               y)))
                    (lambda (t)
                      (set! y (+ y (* 1.5 (draw-text x y t align))))))
                  text)
        (draw-text x y text align)))

  (define (clear-screen #!optional (color *current-background*))
    (let-values (((width height) (window-size *sdl-window*)))
      (begin
        (apply cairo-set-source-rgba (cons *cairo-context* color))
        (doto *cairo-context*
              (cairo-rectangle 0 0 width height)
              (cairo-fill)
              (cairo-stroke)))))

  (define (filled-rectangle x1 y1 width height color)
    (set-color color)
    (doto *cairo-context*
          (cairo-new-path)
          (cairo-set-line-width *line-width*)
          (cairo-set-dash (make-f64vector 0) 0 0)
          (cairo-rectangle x1 y1 width height)
          (cairo-fill)
          (cairo-close-path)))

  (define (draw-line x1 y1 x2 y2
                     #!key
                     (width *line-width*)
                     (color solid-white)
                     (style #:solid))
    (doto *cairo-context*
          (cairo-set-line-width width)
          (cairo-new-path)
          (cairo-move-to x1 y1))
    (set-color color)
    (case style
      ((#:solid)
       (cairo-set-dash *cairo-context* (make-f64vector 0) 0 0))
      ((#:dashed)
       (cairo-set-dash *cairo-context* (make-f64vector 1 5) 1 0))
      (else (error "unknown line style " style)))
    (doto *cairo-context*
          (cairo-line-to x2 y2)
          (cairo-stroke)))

  (define (show!)
    (cairo-surface-flush *cairo-surface*)
    (update-window-surface! *sdl-window*))


  (define for-events
    (let ((ev (make-event)))
      (lambda (event-handler)
        (when (poll-event! ev)
          (event-handler ev)
          (for-events event-handler)))))

  (define map-events
    (let ((ev (make-event)))
      (lambda (proc)
        (if (poll-event! ev)
            (cons (proc ev) (map-events proc))
            '()))))

  )
