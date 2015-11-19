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


(export controller-axis-event?
        controller-axis-event-which
        controller-axis-event-which-set!
        controller-axis-event-axis
        controller-axis-event-axis-set!
        controller-axis-event-value
        controller-axis-event-value-set!)


(define-event-type "SDL_ControllerAxisEvent"
  types: (SDL_CONTROLLERAXISMOTION)
  pred:  controller-axis-event?
  print: ((which controller-axis-event-which)
          (axis controller-axis-event-axis)
          (value controller-axis-event-value))
  ("caxis.which"
   type:   SDL_JoystickID
   getter: controller-axis-event-which
   setter: controller-axis-event-which-set!
   guard:  noop-guard)
  ("caxis.axis"
   type:   Uint8
   getter: controller-axis-event-axis
   setter: controller-axis-event-axis-set!
   guard:  (Uint8-guard "sdl2:controller-axis-event field axis"))
  ("caxis.value"
   type:   Sint16
   getter: controller-axis-event-value
   setter: controller-axis-event-value-set!
   guard:  (Sint16-guard "sdl2:controller-axis-event field value")))
