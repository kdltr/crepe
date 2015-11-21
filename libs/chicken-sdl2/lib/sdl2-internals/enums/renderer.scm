;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; RENDERER FLAGS

(export renderer-flags->symbol
        symbol->renderer-flags)

(define-enum-mappings
  type: SDL_RendererFlags
  value->symbol: renderer-flags->symbol
  symbol->value: symbol->renderer-flags

  ((SDL_RENDERER_SOFTWARE         software)
   (SDL_RENDERER_ACCELERATED      accelerated)
   (SDL_RENDERER_PRESENTVSYNC     present-vsync)
   (SDL_RENDERER_TARGETTEXTURE    target-texture)))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; RENDERER FLIP

(export renderer-flip->symbol
        symbol->renderer-flip)

(define-enum-mappings
  type: SDL_RendererFlip
  value->symbol: renderer-flip->symbol
  symbol->value: symbol->renderer-flip

  ((SDL_FLIP_NONE         none)
   (SDL_FLIP_HORIZONTAL   horizontal)
   (SDL_FLIP_VERTICAL     vertical)))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; TEXTURE ACCESS

(export texture-access->symbol
        symbol->texture-access)

(define-enum-mappings
  type: SDL_TextureAccess
  value->symbol: texture-access->symbol
  symbol->value: symbol->texture-access

  ((SDL_TEXTUREACCESS_STATIC       static)
   (SDL_TEXTUREACCESS_STREAMING    streaming)
   (SDL_TEXTUREACCESS_TARGET       target)))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; TEXTURE MODULATE

(export texture-modulate->symbol
        symbol->texture-modulate)

(define-enum-mappings
  type: SDL_TextureModulate
  value->symbol: texture-modulate->symbol
  symbol->value: symbol->texture-modulate

  ((SDL_TEXTUREMODULATE_NONE     none)
   (SDL_TEXTUREMODULATE_COLOR    color)
   (SDL_TEXTUREMODULATE_ALPHA    alpha)))
