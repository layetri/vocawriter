#lang racket

; This package allows for a melody to be pre-tuned and have default lyrics added, taking out the tedious work

; VSQX resolution: 480 cycles per beat
; input rests as midi note -1
; arguments: melody[midi-note, duration, syllable], tuning amount, voice color

(provide voca-tuner)

(define test-part '((60 480 "la") (62 480 "la") (64 480 "la") (60 480 "la") (57 480 "la") (60 480 "la") (55 720 "la") (-1 240)))
(define note-starts '(0 0 1 1 1 1 1 1 1 -1 -1 -1 -1 -1 -1 -1 -2 -2 -2 -2 -2 2 2 2 2 2 4 6 7 12 13))
(define note-ends '(0 0 0 0 0 1 -1 -1 -1 -2 -2 2 7 -18))
(define bpm 120)
(define newmel '())

(define (add-to-notes-list current step)
    (set! newmel
        (append newmel
            (list
                (list ; articulation note
                    (- (list-ref current 0) step)
                    (inexact->exact (/ (list-ref current 1) 4))
                    (list-ref current 2))
                (list ; actual note
                    (list-ref current 0)
                    (inexact->exact (* (list-ref current 1) 0.75))
                    "-")
            )
        )
    )
)

(define (voca-tuner melody [amount 5] [color 5])
   (begin
       (define notecount (length melody))
       (for/list ([i notecount])
         (begin
             ; shorthand for current note
             (define curnote (list-ref melody i))

             ; when note i is the first note
             (when (and (eq? i 0) (> (list-ref (list-ref melody i) 0) -1))
                 (begin
                     ; possible note steps for first note
                     (define notesteps '(-7 1 2 -2))
                     (define pickstep (list-ref notesteps (random (length notesteps))))

                     (add-to-notes-list curnote pickstep)
                 ))

             ; when note i isn't the first note
             (when (and (> i 0) (> (list-ref (list-ref melody i) 0) -1))
                 (begin
                     (define prevnote (list-ref melody (- i 1)))
                     (define notestep 0)

                     ; when the previous note was higher
                     (when (> (list-ref prevnote 0) (list-ref curnote 0))
                         (set! notestep -1))
                     ; when the previous note was lower
                     (when (< (list-ref prevnote 0) (list-ref curnote 0))
                         (set! notestep 1))

                     (add-to-notes-list curnote notestep)
                 )
             )

             ; when note i is a rest
             (when (eq? (list-ref (list-ref melody i) 0) -1) (set! newmel (append newmel (list (list-ref melody i)))))
         )
       )
       newmel
   )
)


; PVA
; 1. gets a list of notes with associated lyrics
; 2. for each note do this:
;   - find the previous note
;       - it goes up: add sub-articulation
;       - it goes down: add super-articulation
;       - it's first: add either sub or super articulation at random
;   - determine tuning resolution
;       - based on note length
;   - shorten the current note by the tuning resolution
;   - add the syllable to the articulation note
;   - if note is end of phrase (has pause of >= 4b)
;       - add end articulation (doit up, bend down, etc)
;   - if note length > 4b, add vibrato