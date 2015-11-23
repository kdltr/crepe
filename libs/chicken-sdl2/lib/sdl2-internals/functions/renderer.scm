(export SDL_CreateRenderer
        SDL_DestroyRenderer
        SDL_GetRenderTarget
        SDL_RenderClear
        SDL_RenderCopy
        SDL_RenderCopyEx
        SDL_RenderFillRect
        SDL_RenderPresent
        SDL_RenderTargetSupported
        SDL_RenderSetLogicalSize
        SDL_SetRenderDrawColor
        SDL_SetRenderTarget)

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

(define-function-binding SDL_GetRenderTarget
  return: (SDL_Texture* texture)
  args: ((SDL_Renderer* renderer)))

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

(define-function-binding SDL_RenderCopyEx
  return: (int error)
  args: ((SDL_Renderer* renderer)
         (SDL_Texture* texture)
         (SDL_Rect*-or-null srcrect)
         (SDL_Rect*-or-null dstrect)
         (double angle)
         (SDL_Point*-or-null center)
         (SDL_RendererFlip flip)))

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

(define-function-binding SDL_RenderSetLogicalSize
  return: (int error)
  args: ((SDL_Renderer* renderer)
         (int w)
         (int h)))

;; SDL_RenderSetScale
;; SDL_RenderSetViewport

(define-function-binding SDL_RenderTargetSupported
  return: (bool target-supported)
  args: ((SDL_Renderer* renderer)))

;; SDL_SetRenderDrawBlendMode

(define-function-binding SDL_SetRenderDrawColor
  return: (int error)
  args: ((SDL_Renderer* renderer)
         (Uint8 r)
         (Uint8 g)
         (Uint8 b)
         (Uint8 a)))

(define-function-binding SDL_SetRenderTarget
  return: (int error)
  args: ((SDL_Renderer* renderer)
         (SDL_Texture*-or-null texture)))

;; SDL_SetTextureAlphaMod
;; SDL_SetTextureBlendMode
;; SDL_SetTextureColorMod
;; SDL_UnlockTexture
;; SDL_UpdateTexture
;; SDL_UpdateYUVTexture

