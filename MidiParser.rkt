#lang racket

(require racket/struct)
(require midi-readwrite)

; Vocaloid: 480 cycles per beat
; Midi: 96 cycles per beat

(provide midi-convert)

(define len-count 0)

(define (midi-convert input)
    (begin
        (define converted (MIDIFile->notelist input))
        (for/list ([i converted])
                  (begin
                      (define extr (struct->list i))
                      (define temp-len (- (list-ref extr 1) len-count))
                      (set! len-count (+ len-count temp-len))
                      (list (list-ref extr 0) (* temp-len 5) "la")
                      ))))