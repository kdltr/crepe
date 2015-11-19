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


(export num-joysticks
        joystick-open!
        joystick-close!
        joystick-update!
        joystick-event-state  joystick-event-state-set!
        joystick-attached?

        joystick-num-axes
        joystick-num-balls
        joystick-num-buttons
        joystick-num-hats

        joystick-get-axis
        joystick-get-ball
        joystick-get-button
        joystick-get-hat
        joystick-get-hat-raw

        joystick-instance-id
        joystick-name
        joystick-name-for-index

        joystick-get-device-guid
        joystick-get-guid
        joystick-get-guid-from-string
        joystick-get-guid-string)



(define (num-joysticks)
  (SDL_NumJoysticks))

(define (joystick-open! device-index)
  (SDL_JoystickOpen device-index))

(define (joystick-close! joystick)
  (SDL_JoystickClose joystick))

(define (joystick-update!)
  (SDL_JoystickUpdate))


(define (joystick-event-state-set! state)
  (let ((result (SDL_JoystickEventState
                 (if state SDL_ENABLE SDL_IGNORE))))
    (if (< result 0)
        result
        (= result SDL_ENABLE))))

(define (joystick-event-state)
  (= SDL_ENABLE
     (SDL_JoystickEventState SDL_QUERY)))

(set! (setter joystick-event-state)
      joystick-event-state-set!)


(define (joystick-attached? joystick)
  (SDL_JoystickGetAttached joystick))


(define (joystick-num-axes joystick)
  (SDL_JoystickNumAxes joystick))

(define (joystick-num-balls joystick)
  (SDL_JoystickNumBalls joystick))

(define (joystick-num-buttons joystick)
  (SDL_JoystickNumButtons joystick))

(define (joystick-num-hats joystick)
  (SDL_JoystickNumHats joystick))


(define (joystick-get-axis joystick axis)
  (SDL_JoystickGetAxis joystick axis))

(define (joystick-get-ball joystick ball)
  (with-temp-mem ((dx-out (%allocate-int))
                  (dy-out (%allocate-int)))
    (let ((response (SDL_JoystickGetBall
                     joystick ball dx-out dy-out)))
      (if (zero? response)
          (values (pointer-s32-ref dx-out)
                  (pointer-s32-ref dy-out))
          (values #f #f)))))

(define (joystick-get-button joystick button)
  (SDL_JoystickGetButton joystick button))

(define (joystick-get-hat joystick hat)
  (joystick-hat-position->symbol
   (joystick-get-hat-raw joystick hat)))

(define (joystick-get-hat-raw joystick hat)
  (SDL_JoystickGetHat joystick hat))


(define (joystick-instance-id joystick)
  (SDL_JoystickInstanceID joystick))

(define (joystick-name joystick)
  (SDL_JoystickName joystick))

(define (joystick-name-for-index device-index)
  (SDL_JoystickNameForIndex device-index))


(define (joystick-get-device-guid device-index)
  (%autofree-struct!
   (SDL_JoystickGetDeviceGUID device-index)
   free-joystick-guid!))

(define (joystick-get-guid joystick)
  (%autofree-struct!
   (SDL_JoystickGetGUID joystick)
   free-joystick-guid!))

(define (joystick-get-guid-from-string guid-string)
  (%autofree-struct!
   (SDL_JoystickGetGUIDFromString guid-string)
   free-joystick-guid!))

(define (joystick-get-guid-string guid)
  (%joystick-get-guid-string guid))
