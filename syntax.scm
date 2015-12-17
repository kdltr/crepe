(use-for-syntax posix)

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

(define-syntax define-sound
  (ir-macro-transformer
   (lambda (form inject compare)
     (let* ((sound-name (inject (cadr form)))
            (channel (or (and (pair? (cddr form)) (caddr form)) -1))
            (var-name (inject (symbol-append sound-name '-sound)))
            (files (glob (string-append "assets/sounds/" (symbol->string sound-name) "-*.ogg"))))
       `(define ,var-name
          (make-sound channel: ,channel
                      chunks: (vector
                               ,@(map
                                  (lambda (file) `(load-snd (file-blob ,file)))
                                  files))))))))
