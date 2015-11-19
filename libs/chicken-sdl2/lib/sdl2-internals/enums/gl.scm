;;
;; chicken-sdl2: CHICKEN Scheme bindings to Simple DirectMedia Layer 2
;;
;; Copyright © 2013, 2015  John Croisant.
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


(export gl-attr->symbol
        symbol->gl-attr
        SDL_GL_FRAMEBUFFER_SRGB_CAPABLE ;; SDL >= 2.0.1

        gl-profile->symbol
        symbol->gl-profile

        gl-context-flag->symbol
        symbol->gl-context-flag
        pack-gl-context-flags
        unpack-gl-context-flags)



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; GL ATTR

(define-enum-mappings
  type: SDL_GLattr
  ;; Use hash tables so that more enums can be added depending on what
  ;; version of SDL is being used.
  value->symbol: (gl-attr->symbol
                  %gl-attr->symbol-table)
  symbol->value: (symbol->gl-attr
                  %symbol->gl-attr-table)
  ((SDL_GL_RED_SIZE                    red-size)
   (SDL_GL_GREEN_SIZE                  green-size)
   (SDL_GL_BLUE_SIZE                   blue-size)
   (SDL_GL_ALPHA_SIZE                  alpha-size)
   (SDL_GL_BUFFER_SIZE                 buffer-size)
   (SDL_GL_DOUBLEBUFFER                doublebuffer)
   (SDL_GL_DEPTH_SIZE                  depth-size)
   (SDL_GL_STENCIL_SIZE                stencil-size)
   (SDL_GL_ACCUM_RED_SIZE              accum-red-size)
   (SDL_GL_ACCUM_GREEN_SIZE            accum-green-size)
   (SDL_GL_ACCUM_BLUE_SIZE             accum-blue-size)
   (SDL_GL_ACCUM_ALPHA_SIZE            accum-alpha-size)
   (SDL_GL_STEREO                      stereo)
   (SDL_GL_MULTISAMPLEBUFFERS          multisamplebuffers)
   (SDL_GL_MULTISAMPLESAMPLES          multisamplesamples)
   (SDL_GL_ACCELERATED_VISUAL          accelerated-visual)
   ;; omitted: SDL_GL_RETAINED_BACKING (deprecated)
   (SDL_GL_CONTEXT_MAJOR_VERSION       context-major-version)
   (SDL_GL_CONTEXT_MINOR_VERSION       context-minor-version)
   ;; omitted: SDL_GL_CONTEXT_EGL (deprecated)
   (SDL_GL_CONTEXT_FLAGS               context-flags)
   (SDL_GL_CONTEXT_PROFILE_MASK        context-profile-mask)
   (SDL_GL_SHARE_WITH_CURRENT_CONTEXT  share-with-current-context)))


;;; Only available with SDL >= 2.0.1
(define SDL_GL_FRAMEBUFFER_SRGB_CAPABLE
  (foreign-value "
#if SDL_VERSION_ATLEAST( 2,0,1 )
  SDL_GL_FRAMEBUFFER_SRGB_CAPABLE
#else
  -1
#endif
" int))

(unless (negative? SDL_GL_FRAMEBUFFER_SRGB_CAPABLE)
  (hash-table-set! %gl-attr->symbol-table
                   SDL_GL_FRAMEBUFFER_SRGB_CAPABLE
                   'framebuffer-srgb-capable)
  (hash-table-set! %symbol->gl-attr-table
                   'framebuffer-srgb-capable
                   SDL_GL_FRAMEBUFFER_SRGB_CAPABLE))



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; GL PROFILE

(define-enum-mappings
  type: SDL_GLprofile
  value->symbol: gl-profile->symbol
  symbol->value: symbol->gl-profile

  ((SDL_GL_CONTEXT_PROFILE_CORE           core)
   (SDL_GL_CONTEXT_PROFILE_COMPATIBILITY  compatibility)
   (SDL_GL_CONTEXT_PROFILE_ES             es)))



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; GL CONTEXT FLAG

(define-enum-mappings
  type: SDL_GLcontextFlag
  value->symbol: gl-context-flag->symbol
  symbol->value: symbol->gl-context-flag

  ((SDL_GL_CONTEXT_DEBUG_FLAG               debug)
   (SDL_GL_CONTEXT_FORWARD_COMPATIBLE_FLAG  forward-compatible)
   (SDL_GL_CONTEXT_ROBUST_ACCESS_FLAG       robust-access)
   (SDL_GL_CONTEXT_RESET_ISOLATION_FLAG     reset-isolation)))

(define-enum-mask-packer pack-gl-context-flags
  symbol->gl-context-flag)

(define-enum-mask-unpacker unpack-gl-context-flags
  gl-context-flag->symbol
  (list SDL_GL_CONTEXT_DEBUG_FLAG
        SDL_GL_CONTEXT_FORWARD_COMPATIBLE_FLAG
        SDL_GL_CONTEXT_ROBUST_ACCESS_FLAG
        SDL_GL_CONTEXT_RESET_ISOLATION_FLAG))
