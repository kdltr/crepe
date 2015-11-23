(export renderer?
        wrap-renderer
        unwrap-renderer
        %renderer-pointer
        %renderer-pointer-set!)

(define-struct-record-type
  sdl2:renderer "SDL_Renderer"
  pred:    renderer?
  wrap:    wrap-renderer
  unwrap:  unwrap-renderer
  (pointer %renderer-pointer
           %renderer-pointer-set!))

(define-struct-record-printer sdl2:renderer
  %renderer-pointer
  show-address: #t)
