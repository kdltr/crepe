(export SDL_CreateTexture
        SDL_CreateTextureFromSurface
        SDL_DestroyTexture)

(define-function-binding SDL_CreateTexture
  return: (SDL_Texture* texture)
  args: ((SDL_Renderer* renderer)
         (SDL_PixelFormatEnum fmt)
         (SDL_TextureAccess access)
         (int w)
         (int h)))

(define-function-binding SDL_CreateTextureFromSurface
  return: (SDL_Texture* texture)
  args: ((SDL_Renderer* renderer)
         (SDL_Surface* surface)))

(define-function-binding SDL_DestroyTexture
  args: ((SDL_Texture* texture)))

;; SDL_GetTextureAlphaMod

;; SDL_GetTextureBlendMode

;; SDL_GetTextureColorMod

;; SDL_LockTexture

;; SDL_QueryTexture

;; SDL_SetTextureAlphaMod

;; SDL_SetTextureBlendMode

;; SDL_SetTextureColorMod

;; SDL_UnlockTexture

;; SDL_UpdateTexture 

