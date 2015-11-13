(use-for-syntax matchable)

(define-syntax with-slots
  (ir-macro-transformer
   (lambda (form inject compare)
     (match form
       ((with-slots struct type (slots ...) body . rest)
        (let* ((bindings (map
                          (lambda (s)
                            (list s (list (symbol-append (inject type) '- (inject s)) struct)))
                          slots)))
          `(let ,bindings
             ,body
             ,@rest)))))))
