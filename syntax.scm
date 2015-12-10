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
                       (load-img (file-blob ,(string-append "assets/graphics/" (symbol->string res) ".png"))))))
                (cdr form))))))

(define-syntax define-sounds
  (ir-macro-transformer
   (lambda (form inject compare)
     `(begin ,@(map
                (lambda (snd)
                  (let ((snd (inject snd)))
                    `(define ,(symbol-append snd '-sound)
                       (load-snd (file-blob ,(string-append "assets/sounds/" (symbol->string snd) ".wav"))))))
                (cdr form))))))
