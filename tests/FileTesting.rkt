#lang racket

(require racket/gui)

(define line-to-write "a b c d e f g")

(define (*->string data)
    (begin
        (when (number? data) (number->string data))
        (when (list? data) (list->string data))
        (when (string? data) data)))

(define fileport (open-output-file (string->path "/Users/layetri/Development/VocaWriter/files/test-lst.txt") #:exists 'replace))
(print line-to-write fileport)
(close-output-port fileport)

(define frame (new frame% [label "vTune 0.1"] [width 600] [height 400] [x 550] [y 200]))
(send frame accept-drop-files ".mid")
(send frame on-drop-file (string->path "/Users/layetri/Development/VocaWriter/files"))


(define (handle-file) (displayln "file"))
(application-file-handler)


(send frame show #t)