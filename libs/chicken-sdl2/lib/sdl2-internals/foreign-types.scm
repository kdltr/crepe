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


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; GENERIC

(define-foreign-type int*    (c-pointer int))

(define-foreign-type Sint8   byte)
(define-foreign-type Sint16  short)
(define-foreign-type Sint32  integer32)
(define-foreign-type Sint64  integer64)

(define-foreign-type Sint8*  (c-pointer Sint8))
(define-foreign-type Sint16* (c-pointer Sint16))
(define-foreign-type Sint32* (c-pointer Sint32))
(define-foreign-type Sint64* (c-pointer Sint64))

(define-foreign-type Uint8   unsigned-byte)
(define-foreign-type Uint16  unsigned-short)
(define-foreign-type Uint32  unsigned-integer32)
(define-foreign-type Uint64  unsigned-integer64)

(define-foreign-type Uint8*  (c-pointer Uint8))
(define-foreign-type Uint16* (c-pointer Uint16))
(define-foreign-type Uint32* (c-pointer Uint32))
(define-foreign-type Uint64* (c-pointer Uint64))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; ENUMS

(define-foreign-type SDL_AudioDeviceID Uint32)
(define-foreign-type SDL_AudioFormat Uint16)
(define-foreign-type SDL_AudioFormatEnum int)
(define-foreign-type SDL_AudioStatus int)

(define-foreign-type SDL_BlendMode int)
(define-foreign-type SDL_EventType int)
(define-foreign-type SDL_FingerID Sint64)
(define-foreign-type SDL_GLattr int)
(define-foreign-type SDL_GLcontextFlag int)
(define-foreign-type SDL_GLprofile int)
(define-foreign-type SDL_GestureID Sint64)
(define-foreign-type SDL_JoystickHatPosition int)
(define-foreign-type SDL_JoystickID Sint32)
(define-foreign-type SDL_Keycode int)
(define-foreign-type SDL_Keymod int)
(define-foreign-type SDL_MouseButton int)
(define-foreign-type SDL_MouseButtonMask int)
(define-foreign-type SDL_RendererFlags Uint32)
(define-foreign-type SDL_RendererFlip Uint32)
(define-foreign-type SDL_RWopsWhenceEnum int)
(define-foreign-type SDL_Scancode int)
(define-foreign-type SDL_SystemCursor int)
(define-foreign-type SDL_TextureAccess int)
(define-foreign-type SDL_TextureModulate int)
(define-foreign-type SDL_TouchID Sint64)
(define-foreign-type SDL_WindowEventID int)
(define-foreign-type SDL_WindowFlags int)
(define-foreign-type SDL_eventaction int)

(define-foreign-type SDL_PixelFormatEnum Uint32)
(define-foreign-type SDL_PixelTypeEnum int)
(define-foreign-type SDL_BitmapOrderEnum int)
(define-foreign-type SDL_PackedOrderEnum int)
(define-foreign-type SDL_ArrayOrderEnum int)
(define-foreign-type SDL_PackedLayoutEnum int)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; STRUCTS


(define-foreign-type SDL_AudioCVT*
  (nonnull-c-pointer "SDL_AudioCVT")
  unwrap-audio-cvt
  wrap-audio-cvt)

(define-foreign-type SDL_AudioSpec*
  (nonnull-c-pointer "SDL_AudioSpec")
  unwrap-audio-spec
  wrap-audio-spec)

(define-foreign-type SDL_AudioCallback
  (function void (c-pointer Uint8* int)))

(define-foreign-type SDL_AudioFilter
  (function void (SDL_AudioCVT* SDL_AudioFormat)))


(define-foreign-type SDL_Color*
  (nonnull-c-pointer "SDL_Color")
  unwrap-color
  wrap-color)

(define-foreign-type SDL_Color*-or-null
  (c-pointer "SDL_Color")
  unwrap-color
  wrap-color)


(define-foreign-type SDL_Cursor*
  (nonnull-c-pointer "SDL_Cursor")
  unwrap-cursor
  wrap-cursor)

(define-foreign-type SDL_DisplayMode*
  (nonnull-c-pointer "SDL_DisplayMode")
  unwrap-display-mode
  wrap-display-mode)

(define-foreign-type SDL_Finger*
  (nonnull-c-pointer "SDL_Finger")
  unwrap-finger
  wrap-finger)


;;; NOTE: "SDL_GLContext" is a typedef alias of "void *" so properly
;;; this should be SDL_GLContext (no *), but I'm adding the * for
;;; semantic consistency. It is a pointer, after all.
(define-foreign-type SDL_GLContext*
  (c-pointer void)
  unwrap-gl-context
  wrap-gl-context)


(define-foreign-type SDL_Joystick*
  (nonnull-c-pointer "SDL_Joystick")
  unwrap-joystick
  wrap-joystick)

(define-foreign-type SDL_JoystickGUID*
  (nonnull-c-pointer "SDL_JoystickGUID")
  unwrap-joystick-guid
  wrap-joystick-guid)


(define-foreign-type SDL_Palette*
  (nonnull-c-pointer "SDL_Palette")
  unwrap-palette
  wrap-palette)

(define-foreign-type SDL_PixelFormat*
  (nonnull-c-pointer "SDL_PixelFormat")
  unwrap-pixel-format
  wrap-pixel-format)


(define-foreign-type SDL_Rect*
  (nonnull-c-pointer "SDL_Rect")
  unwrap-rect
  wrap-rect)

(define-foreign-type SDL_Rect*-or-null
  (c-pointer "SDL_Rect")
  unwrap-rect
  wrap-rect)

(define-foreign-type SDL_Renderer*
  (c-pointer "SDL_Renderer")
  unwrap-renderer
  wrap-renderer)

(define-foreign-type SDL_Point*
  (nonnull-c-pointer "SDL_Point")
  unwrap-point
  wrap-point)

(define-foreign-type SDL_Point*-or-null
  (c-pointer "SDL_Point")
  unwrap-point
  wrap-point)


(define-foreign-type SDL_RWops*
  (nonnull-c-pointer "SDL_RWops")
  unwrap-rwops
  wrap-rwops)


(define-foreign-type SDL_Surface*
  (nonnull-c-pointer "SDL_Surface")
  unwrap-surface
  wrap-surface)

(define-foreign-type SDL_Surface*-or-null
  (c-pointer "SDL_Surface")
  unwrap-surface
  wrap-surface)


(define-foreign-type SDL_Texture*
  (nonnull-c-pointer "SDL_Texture")
  unwrap-texture
  wrap-texture)


(define-foreign-type SDL_Window*
  (nonnull-c-pointer "SDL_Window")
  unwrap-window
  wrap-window)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; EVENTS

(define-foreign-type SDL_Event*
  (c-pointer "SDL_Event")
  unwrap-event
  wrap-event)

(define-foreign-type SDL_EventFilter
  (function int (c-pointer SDL_Event*)))

(define-foreign-type SDL_EventFilter*
  (c-pointer (function int (c-pointer SDL_Event*))))

(define-foreign-type SDL_Keysym*
  (nonnull-c-pointer "SDL_Keysym")
  unwrap-keysym
  wrap-keysym)
