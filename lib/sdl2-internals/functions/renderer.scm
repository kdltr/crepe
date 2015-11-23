(export SDL_CreateRenderer
        SDL_DestroyRenderer
        SDL_RenderClear
        SDL_RenderCopy
        SDL_RenderPresent
        SDL_SetRenderDrawColor
        SDL_RenderFillRect)

(define-function-binding SDL_CreateRenderer
  return: (SDL_Renderer* renderer)
  args: ((SDL_Window* window)
         (int index)
         (Uint32 flags)))

;; SDL_CreateSoftwareRenderer
;; SDL_CreateWindowAndRenderer

(define-function-binding SDL_DestroyRenderer
  args: ((SDL_Renderer* renderer)))

;; SDL_GetNumRenderDrivers
;; SDL_GetRenderDrawBlendMode
;; SDL_GetRenderDrawColor
;; SDL_GetRenderDriverInfo
;; SDL_GetRenderTarget
;; SDL_GetRenderer
;; SDL_GetRendererInfo
;; SDL_GetRendererOutputSize

(define-function-binding SDL_RenderClear
  return: (int error)
  args: ((SDL_Renderer* renderer)))

(define-function-binding SDL_RenderCopy
  return: (int error)
  args: ((SDL_Renderer* renderer)
         (SDL_Texture* texture)
         (SDL_Rect*-or-null srcrect)
         (SDL_Rect*-or-null dstrect)))

;; SDL_RenderCopyEx
;; SDL_RenderDrawLine
;; SDL_RenderDrawLines
;; SDL_RenderDrawPoint
;; SDL_RenderDrawPoints
;; SDL_RenderDrawRect
;; SDL_RenderDrawRects

(define-function-binding SDL_RenderFillRect
  return: (int error)
  args: ((SDL_Renderer* renderer)
         (SDL_Rect*-or-null rect)))

;; SDL_RenderFillRects
;; SDL_RenderGetClipRect
;; SDL_RenderGetLogicalSize
;; SDL_RenderGetScale
;; SDL_RenderGetViewport
;; SDL_RenderIsClipEnabled

(define-function-binding SDL_RenderPresent
  args: ((SDL_Renderer* renderer)))

;; SDL_RenderReadPixels
;; SDL_RenderSetClipRect
;; SDL_RenderSetLogicalSize
;; SDL_RenderSetScale
;; SDL_RenderSetViewport
;; SDL_RenderTargetSupported
;; SDL_SetRenderDrawBlendMode

(define-function-binding SDL_SetRenderDrawColor
  return: (int error)
  args: ((SDL_Renderer* renderer)
         (Uint8 r)
         (Uint8 g)
         (Uint8 b)
         (Uint8 a)))

;; SDL_SetRenderTarget
;; SDL_SetTextureAlphaMod
;; SDL_SetTextureBlendMode
;; SDL_SetTextureColorMod
;; SDL_UnlockTexture
;; SDL_UpdateTexture
;; SDL_UpdateYUVTexture

