#lang racket

(provide slist->string)

(define (slist->string slst)
    (for/list ([i slst])
         (if (integer? i) (number->string i) i)))

;(define worker (thread (lambda ()
;   (let loop ()
;        (send dc draw-text (string-append "working..." (number->string test-int) "\n") 5 (* 11 test-int))
;        (set! test-int (+ 1 test-int))
;        (sleep 1)
;        (loop)))))
;(sleep 5)
;(kill-thread worker)