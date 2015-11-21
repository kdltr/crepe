(export)

(define-struct-record-type
  sdl2:renderer-info "SDL_RendererInfo"
  pred:    renderer-info?
  wrap:    wrap-renderer-info
  unwrap:  unwrap-renderer-info
  (pointer %renderer-info-pointer
           %renderer-info-pointer-set!))

(define-struct-record-printer sdl2:renderer
  %renderer-info-pointer
  show-address: #t)
