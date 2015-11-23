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


(export SDL_NumJoysticks
        SDL_JoystickOpen
        SDL_JoystickClose
        SDL_JoystickUpdate
        SDL_JoystickEventState
        SDL_JoystickGetAttached

        SDL_JoystickNumAxes
        SDL_JoystickNumBalls
        SDL_JoystickNumButtons
        SDL_JoystickNumHats

        SDL_JoystickGetAxis
        SDL_JoystickGetBall
        SDL_JoystickGetButton
        SDL_JoystickGetHat

        SDL_JoystickInstanceID
        SDL_JoystickName
        SDL_JoystickNameForIndex

        SDL_JoystickGetDeviceGUID
        SDL_JoystickGetGUID
        SDL_JoystickGetGUIDFromString
        %joystick-get-guid-string)


(define-function-binding SDL_NumJoysticks
  return: (int num-joysticks))

(define-function-binding SDL_JoystickOpen
  return: (SDL_Joystick* joystick)
  args: ((int device-index)))

(define-function-binding SDL_JoystickClose
  args: ((SDL_Joystick* joystick)))

(define-function-binding SDL_JoystickUpdate)

(define-function-binding SDL_JoystickEventState
  return: (int current-or-new-state)
  args: ((int state)))

(define-function-binding SDL_JoystickGetAttached
  return: (bool attached?)
  args: ((SDL_Joystick* joystick)))


(define-function-binding SDL_JoystickNumAxes
  return: (int num-axes)
  args: ((SDL_Joystick* joystick)))

(define-function-binding SDL_JoystickNumBalls
  return: (int num-balls)
  args: ((SDL_Joystick* joystick)))

(define-function-binding SDL_JoystickNumButtons
  return: (int num-buttons)
  args: ((SDL_Joystick* joystick)))

(define-function-binding SDL_JoystickNumHats
  return: (int num-hats)
  args: ((SDL_Joystick* joystick)))


(define-function-binding SDL_JoystickGetAxis
  return: (Sint16 position)
  args: ((SDL_Joystick* joystick)
         (int axis)))

(define-function-binding SDL_JoystickGetBall
  return: (int zero-if-success)
  args: ((SDL_Joystick* joystick)
         (int ball)
         (int* dx)
         (int* dy)))

(define-function-binding SDL_JoystickGetButton
  return: (bool pressed?)
  args: ((SDL_Joystick* joystick)
         (int button)))

(define-function-binding SDL_JoystickGetHat
  return: (SDL_JoystickHatPosition position)
  args: ((SDL_Joystick* joystick)
         (int hat)))


(define-function-binding SDL_JoystickInstanceID
  return: (SDL_JoystickID id)
  args: ((SDL_Joystick* joystick)))

(define-function-binding SDL_JoystickName
  return: (c-string name)
  args: ((SDL_Joystick* joystick)))

(define-function-binding SDL_JoystickNameForIndex
  return: (c-string name)
  args: ((int device-index)))


;;; These GUID functions are tricky, because they return / take
;;; SDL_JoystickGUID structs by value, not pointers. CHICKEN FFI can't
;;; handle structs by value, so we must use clever hacks.

(define (SDL_JoystickGetDeviceGUID device-index)
  (define foreign-getter
    (foreign-lambda*
     void ((int device_index) (SDL_JoystickGUID* guid_out))
     "*guid_out = SDL_JoystickGetDeviceGUID(device_index);"))
  (let ((guid-out (%alloc-joystick-guid)))
    (foreign-getter device-index guid-out)
    guid-out))

(define (SDL_JoystickGetGUID joystick)
  (define foreign-getter
    (foreign-lambda*
     void ((SDL_Joystick* joy) (SDL_JoystickGUID* guid_out))
     "*guid_out = SDL_JoystickGetGUID(joy);"))
  (let ((guid-out (%alloc-joystick-guid)))
    (foreign-getter joystick guid-out)
    guid-out))

(define (SDL_JoystickGetGUIDFromString pch-guid)
  (define foreign-getter
    (foreign-lambda*
     void ((c-string pch_guid) (SDL_JoystickGUID* guid_out))
     "*guid_out = SDL_JoystickGetGUIDFromString(pch_guid);"))
  (let ((guid-out (%alloc-joystick-guid)))
    (foreign-getter pch-guid guid-out)
    guid-out))

(define %joystick-get-guid-string
  ;; When returning a string, CHICKEN copies the string into managed
  ;; memory, so returning a string directly from the stack is ok.
  ;; Allocating on the heap would cause a memory leak.
  (foreign-lambda*
   c-string ((SDL_JoystickGUID* guid))
   "char guidStr[33];
    SDL_JoystickGetGUIDString(*guid, guidStr, 33);
    C_return(guidStr);"))
