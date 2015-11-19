
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; MISC UTIL

(define (sort-symbols syms)
  (sort syms
        (lambda (a b)
          (string<? (symbol->string a)
                    (symbol->string b)))))



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; TEST INTEGER STRUCT FIELDS

(define-syntax test-integer-struct-fields
  (syntax-rules (make: freer: getter: setter: min: max:)
    ((test-integer-struct-fields
      make: make-expr
      freer: freer
      (field-name
       getter: getter
       setter: setter
       min: min-value
       max: max-value)
      ...)
     (begin
       (test-integer-struct-field
        field-name
        make: make-expr
        freer: freer
        getter: getter
        setter: setter
        min: min-value
        max: max-value)
       ...))))


(define-syntax test-integer-struct-field
  (syntax-rules (getter: setter: make: freer: min: max:)
    ((test-integer-struct-field
      field-name
      make: make-expr
      freer: freer
      getter: getter
      setter: setter
      min: min-value
      max: max-value)
     (test-group (sprintf "~A / ~A" 'getter 'setter)
       (let ((obj make-expr))
         (set! (getter obj) 42)
         (test "generalized set! changes value"
               42 (getter obj))

         (setter obj min-value)
         (test (sprintf "can be set to minimum value (~A)" min-value)
               min-value (getter obj))

         (setter obj max-value)
         (test (sprintf "can be set to maximum value (~A)" max-value)
               max-value (getter obj))

         (set! (getter obj) 42)

         (test-error "throws error when try to set too-small value"
                     (setter obj (- min-value 1)))
         (test "value unchanged after try to set too-small value"
               42 (getter obj))

         (test-error "throws error when try to set too-big value"
                     (setter obj (+ max-value 1)))
         (test "value unchanged after try to set too-big value"
               42 (getter obj))

         (test-error "throws error when try to set float"
                     (setter obj 1.5))
         (test "value unchanged after try to set float"
               42 (getter obj))
         (test-error "throws error when try to set non-number"
                     (setter obj "1"))
         (test "value unchanged after try to set non-nuber"
               42 (getter obj))

         (freer obj)
         (test-error "throws error when try to get value of freed struct"
                     (getter obj))
         (test-error "throws error when try to set value of freed struct"
                     (setter obj 0)))))))



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; TEST ENUM FIELD

(define-syntax test-enum-field
  (syntax-rules (make: getter: setter: valid1: valid2: invalid: raw:)
    ((test-enum-field
      make: make-expr
      getter: (getter
               getter-raw)
      setter: (setter
               setter-raw)
      valid1: (valid1
               valid1-raw)
      valid2: (valid2
               valid2-raw)
      invalid: (invalid
                invalid-raw))

     (test-group (sprintf "~A / ~A" 'getter 'setter)
       (let ((record make-expr))
         (setter-raw record valid1-raw)
         (test "Getter returns the expected symbol"
               valid1 (getter record))

         (setter record valid2)
         (test "Setting to a symbol sets the value as expected"
               valid2 (getter record))
         (test "Setting to a symbol sets the raw value as expected"
               valid2-raw (getter-raw record))

         (setter record valid1-raw)
         (test "Setting to an integer works"
               valid1 (getter record))

         (setter-raw record invalid-raw)
         (test "Returns integer if raw value is unrecognized"
               invalid-raw (getter record))

         (set! (getter record) valid2)
         (test "Generalized set! works"
               valid2-raw (getter-raw record))

         (test-error "Throws error when try set to unrecognized symbol"
                     (setter record invalid))
         (test-error "Throws error when try set to invalid type (boolean)"
                     (setter record #t))
         (test-error "Throws error when try set to invalid type (float)"
                     (setter record 1.23)))))))
