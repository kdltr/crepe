;;
;; chicken-sdl2-image: CHICKEN Scheme bindings to SDL_image 2
;;
;; Copyright © 2015  John Croisant.
;; All rights reserved.
;;
;; Redistribution and use in source and binary forms, with or without
;; modification, are permitted provided that the following conditions
;; are met:
;;
;; - Redistributions of source code must retain the above copyright
;;   notice, this list of conditions and the following disclaimer.
;;
;; - Redistributions in binary form must reproduce the above copyright
;;   notice, this list of conditions and the following disclaimer in
;;   the documentation and/or other materials provided with the
;;   distribution.
;;
;; THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
;; "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
;; LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
;; FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE
;; COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT,
;; INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
;; (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
;; SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
;; HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
;; STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
;; ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED
;; OF THE POSSIBILITY OF SUCH DAMAGE.


(module sdl2-image
  (init!
   quit!
   current-version
   compiled-version

   load
   load*
   load-rw
   load-rw*
   load-typed-rw
   load-typed-rw*
   ;; TODO: load-cur-rw
   ;; TODO: load-ico-rw
   ;; TODO: load-bmp-rw
   ;; TODO: load-pnm-rw
   ;; TODO: load-xpm-rw
   ;; TODO: load-xcf-rw
   ;; TODO: load-pcx-rw
   ;; TODO: load-gif-rw
   ;; TODO: load-jpg-rw
   ;; TODO: load-tif-rw
   ;; TODO: load-png-rw
   ;; TODO: load-tga-rw
   ;; TODO: load-lbm-rw
   ;; TODO: load-xv-rw
   ;; TODO: read-xpm-from-array

   ;; TODO: is-cur?
   ;; TODO: is-ico?
   ;; TODO: is-bmp?
   ;; TODO: is-pnm?
   ;; TODO: is-xpm?
   ;; TODO: is-xcf?
   ;; TODO: is-pcx?
   ;; TODO: is-gif?
   ;; TODO: is-jpg?
   ;; TODO: is-tif?
   ;; TODO: is-png?
   ;; TODO: is-lbm?
   ;; TODO: is-xv?
   )


  (import (except scheme
                  load)
          chicken foreign lolevel)

  (import (only sdl2-internals
                define-function-binding
                struct-null?
                %allocate-Uint8
                surface?
                unwrap-surface  wrap-surface
                unwrap-rwops    wrap-rwops)
          (only sdl2
                free-surface!))


  (foreign-declare "#include \"SDL_image.h\"")

  (define-foreign-type Uint8* (c-pointer unsigned-byte))

  (define-foreign-type SDL_Surface*
    (nonnull-c-pointer "SDL_Surface")
    unwrap-surface
    wrap-surface)

  (define-foreign-type SDL_RWops*
    (nonnull-c-pointer "SDL_RWops")
    unwrap-rwops
    wrap-rwops)


  ;; Copied from chicken-sdl2.
  (define-syntax with-temp-mem
    (syntax-rules ()
      ((with-temp-mem ((temp-var alloc-expr) ...)
         body ...)
       (let ((temp-var alloc-expr) ...)
         (receive result-values (begin body ...)
                  (free temp-var)
                  ...
                  (apply values result-values))))))


  ;;:;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  ;; INIT / QUIT

  (define IMG_INIT_JPG (foreign-value "IMG_INIT_JPG" int))
  (define IMG_INIT_PNG (foreign-value "IMG_INIT_PNG" int))
  (define IMG_INIT_TIF (foreign-value "IMG_INIT_TIF" int))

  (: %pack-init-flags ((list-of symbol) symbol -> fixnum))
  (define (%pack-init-flags syms fn-name)
    (apply bitwise-ior
      (map (lambda (sym)
             (case sym
               ((jpg) IMG_INIT_JPG)
               ((png) IMG_INIT_PNG)
               ((tif) IMG_INIT_TIF)
               (else (error fn-name "invalid init flag" sym))))
           syms)))

  (: %unpack-init-flags (fixnum -> (list-of symbol)))
  (define (%unpack-init-flags bitfield)
    (let ((results '()))
      (unless (zero? (bitwise-and bitfield IMG_INIT_TIF))
        (set! results (cons 'tif results)))
      (unless (zero? (bitwise-and bitfield IMG_INIT_PNG))
        (set! results (cons 'png results)))
      (unless (zero? (bitwise-and bitfield IMG_INIT_JPG))
        (set! results (cons 'jpg results)))
      results))


  (: init! ((list-of symbol) -> (list-of symbol)))
  (define (init! #!optional (flags '(jpg png tif)))
    (define-function-binding IMG_Init
      return: (int initted-loaders-bitfield)
      args: ((int flags)))
    (%unpack-init-flags
     (IMG_Init (%pack-init-flags flags 'init!))))


  (: quit! (-> void))
  (define (quit!)
    (define-function-binding IMG_Quit)
    (IMG_Quit))


  ;;:;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  ;; VERSION

  (: current-version (-> (list fixnum fixnum fixnum)))
  (define (current-version)
    (define foreign-getter
      (foreign-lambda*
       void ((Uint8* majorOut) (Uint8* minorOut) (Uint8* patchOut))
       "const SDL_version* v = IMG_Linked_Version();"
       "*majorOut = v->major;"
       "*minorOut = v->minor;"
       "*patchOut = v->patch;"))
    (with-temp-mem ((major-out (%allocate-Uint8))
                    (minor-out (%allocate-Uint8))
                    (patch-out (%allocate-Uint8)))
      (foreign-getter major-out minor-out patch-out)
      (list (pointer-u8-ref major-out)
            (pointer-u8-ref minor-out)
            (pointer-u8-ref patch-out))))


  (: compiled-version (-> (list fixnum fixnum fixnum)))
  (define (compiled-version)
    (define foreign-getter
      (foreign-lambda*
       void ((Uint8* majorOut) (Uint8* minorOut) (Uint8* patchOut))
       "SDL_version v;"
       "SDL_IMAGE_VERSION(&v);"
       "*majorOut = v.major;"
       "*minorOut = v.minor;"
       "*patchOut = v.patch;"))
    (with-temp-mem ((major-out (%allocate-Uint8))
                    (minor-out (%allocate-Uint8))
                    (patch-out (%allocate-Uint8)))
      (foreign-getter major-out minor-out patch-out)
      (list (pointer-u8-ref major-out)
            (pointer-u8-ref minor-out)
            (pointer-u8-ref patch-out))))



  ;;:;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  ;; LOADING

  (define-inline (%maybe-surface surf)
    (if (and (surface? surf) (not (struct-null? surf)))
        surf
        #f))

  (define-inline (%maybe-manage-surface surf)
    (if surf
        (set-finalizer! surf free-surface!)
        surf))



  (: load (string -> (or (struct sdl2:surface) false)))
  (define (load filepath)
    (%maybe-manage-surface (load* filepath)))


  (: load* (string -> (or (struct sdl2:surface) false)))
  (define (load* filepath)
    (define-function-binding IMG_Load
      return: (SDL_Surface* surf-or-null)
      args: (((const c-string) filepath)))
    (%maybe-surface (IMG_Load filepath)))



  (: load-rw
     ((struct sdl2:rwops) #!optional boolean
      -> (or (struct sdl2:surface) false)))
  (define (load-rw rwops #!optional close?)
    (%maybe-manage-surface (load-rw* rwops close?)))


  (: load-rw*
     ((struct sdl2:rwops) #!optional boolean
      -> (or (struct sdl2:surface) false)))
  (define (load-rw* rwops #!optional close?)
    (define-function-binding IMG_Load_RW
      return: (SDL_Surface* surf-or-null)
      args: ((SDL_RWops* src)
             (bool freesrc)))
    (%maybe-surface (IMG_Load_RW rwops close?)))



  (: load-typed-rw
     ((struct sdl2:rwops) boolean string
      -> (or (struct sdl2:surface) false)))
  (define (load-typed-rw rwops close? type)
    (%maybe-manage-surface
     (load-typed-rw* rwops close? type)))


  (: load-typed-rw*
     ((struct sdl2:rwops) boolean string
      -> (or (struct sdl2:surface) false)))
  (define (load-typed-rw* rwops close? type)
    (define-function-binding IMG_LoadTyped_RW
      return: (SDL_Surface* surf-or-null)
      args: ((SDL_RWops* src)
             (bool freesrc)
             (c-string type)))
    (%maybe-surface (IMG_LoadTyped_RW rwops close? type)))



  ;; TODO: load-cur-rw (IMG_LoadCUR_RW)

  ;; TODO: load-ico-rw (IMG_LoadICO_RW)

  ;; TODO: load-bmp-rw (IMG_LoadBMP_RW)

  ;; TODO: load-pnm-rw (IMG_LoadPNM_RW)

  ;; TODO: load-xpm-rw (IMG_LoadXPM_RW)

  ;; TODO: load-xcf-rw (IMG_LoadXCF_RW)

  ;; TODO: load-pcx-rw (IMG_LoadPCX_RW)

  ;; TODO: load-gif-rw (IMG_LoadGIF_RW)

  ;; TODO: load-jpg-rw (IMG_LoadJPG_RW)

  ;; TODO: load-tif-rw (IMG_LoadTIF_RW)

  ;; TODO: load-png-rw (IMG_LoadPNG_RW)

  ;; TODO: load-tga-rw (IMG_LoadTGA_RW)

  ;; TODO: load-lbm-rw (IMG_LoadLBM_RW)

  ;; TODO: load-xv-rw (IMG_LoadXV_RW)

  ;; TODO: read-xpm-from-array (IMG_ReadXPMFromArray)


  ;;:;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  ;; TYPE QUERIES

  ;; TODO: is-cur? (IMG_isCUR)

  ;; TODO: is-ico? (IMG_isICO)

  ;; TODO: is-bmp? (IMG_isBMP)

  ;; TODO: is-pnm? (IMG_isPNM)

  ;; TODO: is-xpm? (IMG_isXPM)

  ;; TODO: is-xcf? (IMG_isXCF)

  ;; TODO: is-pcx? (IMG_isPCX)

  ;; TODO: is-gif? (IMG_isGIF)

  ;; TODO: is-jpg? (IMG_isJPG)

  ;; TODO: is-tif? (IMG_isTIF)

  ;; TODO: is-png? (IMG_isPNG)

  ;; TODO: is-lbm? (IMG_isLBM)

  ;; TODO: is-xv? (IMG_isXV)


  ) ;; end module sdl2-image
