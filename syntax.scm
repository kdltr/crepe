(define-syntax file-blob
  (ir-macro-transformer
   (lambda (form inject compare)
     (let ((filename (cadr form)))
       (with-input-from-file filename
         (lambda ()
           (string->blob (read-string))))))))

(define-syntax define-resources
  (ir-macro-transformer
   (lambda (form inject compare)
     `(begin ,@(map
                (lambda (res)
                  (let ((res (inject res)))
                    `(define ,(symbol-append res '-surface)
                       (load-img (file-blob ,(string-append "graph/" (symbol->string res) ".png"))))))
                (cdr form))))))

