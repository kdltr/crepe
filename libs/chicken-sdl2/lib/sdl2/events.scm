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


(export event-state  event-state-set!

        flush-event!
        flush-events!
        has-event?
        has-events?
        quit-requested?

        peek-events
        get-events!

        poll-event!
        pump-events!
        push-event!
        wait-event!
        wait-event-timeout!

        register-events!

        ;; TODO: add-event-watch!
        ;; TODO: del-event-watch!
        ;; TODO: filter-events!
        ;; TODO: get-event-filter
        ;; TODO: set-event-filter!

        get-num-touch-devices
        get-num-touch-fingers
        get-touch-device
        get-touch-finger

        ;; TODO: record-gesture!
        ;; TODO: save-dollar-template!
        ;; TODO: save-all-dollar-templates!
        ;; TODO: load-dollar-templates
        )


(define (%event-type->int type #!optional fn-name)
  (cond
   ((integer? type)
    type)
   ((symbol? type)
    (symbol->event-type
     type
     (lambda (t)
       (error fn-name "unrecognized event type" t))))
   (else
    (error fn-name "unrecognized event type" type))))



(define (event-state-set! type state)
  (SDL_EventState
   (%event-type->int type 'event-state)
   (if state SDL_ENABLE SDL_DISABLE)))

(define (event-state type)
  (SDL_EventState
   (%event-type->int type 'event-state)
   SDL_QUERY))

(set! (setter event-state)
      event-state-set!)


(define (flush-event! type)
  (SDL_FlushEvent
   (%event-type->int type 'flush-event!)))

(define (flush-events! #!optional
                       (min-type 'first)
                       (max-type 'last))
  (SDL_FlushEvents
   (%event-type->int min-type 'flush-events!)
   (%event-type->int max-type 'flush-events!)))

(define (has-event? type)
  (SDL_HasEvent
   (%event-type->int type 'has-event?)))

(define (has-events? #!optional
                     (min-type 'first)
                     (max-type 'last))
  (SDL_HasEvents
   (%event-type->int min-type 'has-events?)
   (%event-type->int max-type 'has-events?)))

(define (quit-requested?)
  (SDL_QuitRequested))



;;; Supports the "peek" and "get" actions of SDL_PeepEvents. The "add"
;;; action is not supported because it would almost certainly be less
;;; efficient than calling SDL_PushEvent repeatedly.
(define (%peep-events num action min-type max-type fn-name)
  (with-temp-mem ((event-array (%allocate-event-array num)))
    (let ((num-peeped (SDL_PeepEvents
                       event-array num action
                       (%event-type->int min-type fn-name)
                       (%event-type->int max-type fn-name))))
      (%event-array->list event-array num-peeped))))

(define (peek-events num #!optional
                     (min-type 'first)
                     (max-type 'last))
  (%peep-events num SDL_PEEKEVENT
                min-type max-type
                'peek-events))

(define (get-events! num #!optional
                     (min-type 'first)
                     (max-type 'last))
  (%peep-events num SDL_GETEVENT
                min-type max-type
                'get-events!))



(define (poll-event! #!optional event-out)
  (let ((ev (or event-out (alloc-event))))
    (if (SDL_PollEvent ev)
        ev
        #f)))

(define (pump-events!)
  (SDL_PumpEvents))

(define (push-event! event)
  (SDL_PushEvent event))


;;; This does not actually use SDL_WaitEvent, because that function
;;; blocks all SRFI-18 threads. See issue #22.
(define (wait-event! #!optional event-out)
  (let loop ((ev (or event-out (alloc-event))))
    (if (SDL_PollEvent ev)
        ev
        (begin
          (thread-sleep! 0.01)
          (loop ev)))))

;;; NOTE: reverse argument order compared to SDL_WaitEventTimeout.
;;; This does not actually use SDL_WaitEventTimeout, because that
;;; function blocks all SRFI-18 threads. See issue #22.
(define (wait-event-timeout! timeout-ms #!optional event-out)
  (let loop ((ev (or event-out (alloc-event)))
             (timeout-ticks (+ (SDL_GetTicks) timeout-ms)))
    (if (SDL_PollEvent ev)
        ev
        (if (>= (SDL_GetTicks) timeout-ticks)
            #f
            (begin
              (thread-sleep! 0.01)
              (loop ev timeout-ticks))))))



(: register-events!
   ((list-of symbol) -> (list-of (pair symbol fixnum))))
(define (register-events! event-symbols)
  (define (check-event-symbol event-symbol)
    (unless (symbol? event-symbol)
      (error 'register-events!
             "Invalid event type symbol"
             event-symbol))
    (when (%event-type-exists? event-symbol)
      (error 'register-events!
             "Event type symbol already used"
             event-symbol)))

  (define (register-event! event-symbol event-number)
    (%add-event-type! event-symbol event-number)
    (cons event-symbol event-number))

  ;; Check events BEFORE registration, so the registered numbers are
  ;; not wasted if any of the event symbols are invalid.
  (for-each check-event-symbol event-symbols)

  (if (null? event-symbols)
      ;; Nothing to register
      '()
      (let* ((numevents (length event-symbols))
             (response (SDL_RegisterEvents numevents)))
        (if (= response %SDL_RegisterEvents-failure-value)
            (error 'register-events!
                   (sprintf "Not enough space available for ~A new types"
                            numevents)
                   event-symbols)
            (map register-event!
                 event-symbols
                 ;; A list of integers, length numevent, starting at
                 ;; response and counting up by 1.
                 (iota numevents response))))))



;; TODO: add-event-watch!
;; TODO: del-event-watch!
;; TODO: filter-events!
;; TODO: get-event-filter
;; TODO: set-event-filter!


(define (get-num-touch-devices)
  (SDL_GetNumTouchDevices))

(define (get-num-touch-fingers touch-id)
  (SDL_GetNumTouchFingers touch-id))

(define (get-touch-device device-id)
  (SDL_GetTouchDevice device-id))

(define (get-touch-finger touch-id index)
  (SDL_GetTouchFinger touch-id index))


;; TODO: record-gesture!
;; TODO: save-dollar-template!
;; TODO: save-all-dollar-templates!
;; TODO: load-dollar-templates
