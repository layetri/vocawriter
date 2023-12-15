#lang racket

(require csd/lilypond)
(require csd/music_transforms)
(require racket/gui)
(require racket/draw)
(require midi-readwrite)
(require "../VocaTuner.rkt")
(require "../MidiParser.rkt")
(require "../VocaWriter.rkt")
(require "../Helpers.rkt")

(define show-panel "tune")
(define file-mode "vsqx")
(define test% (class object% (init val) ))
(define input-txt "")
(define note-lst '())
(define tuned-lst '())
(define src "")

(define tuning-amount 5)
(define voice-color 5)

(define ch (make-channel))
(define frame (new frame% [label "vTune 0.1"] [width 600] [height 400] [x 550] [y 200]))

(define test-part '((60 480 "la") (62 480 "la") (64 480 "la") (60 480 "la") (57 480 "la") (60 480 "la") (55 720 "la") (-1 240)))

; Menu items
(define menu-bar (new menu-bar%
                      (parent frame)))
(define file-menu (new menu%
     (label "&File")
     (parent menu-bar)))
(define import-menu (new menu%
     (label "&Import")
     (parent file-menu)
     ))
(new menu-item%
     (label "&VSQx")
     (parent import-menu)
     (callback (lambda (click event) (set! file-mode "vsqx"))))
(new menu-item%
     (label "&UST")
     (parent import-menu)
     (callback (lambda (click event) (set! file-mode "ust"))))
(new menu-item%
     (label "&Save Preset")
     (parent file-menu)
     (callback (lambda (click event) (displayln test-part))))
(new menu-item%
     (label "&Load Preset...")
     (parent file-menu)
     (callback (lambda (click event) (displayln test-part))))
(new menu%
     (label "&Edit")
     (parent menu-bar))
(new menu%
     (label "&Help")
     (parent menu-bar))

; Main window layout
(define *row*
    (new horizontal-panel%
         [parent frame]
         [style '(border)]))
(define *left-column*
    (new horizontal-panel%
         [parent *row*]
         [style '(border)]))
(define *right-column*
    (new horizontal-panel%
         [parent *row*]
         [style '(border)]))
(define *steps-panel*
    (new vertical-panel%
         [parent *left-column*]
         [style '(border)]
         [alignment '(left top)]
         ))
(define *find-panel*
    (new vertical-panel%
         [parent *right-column*]
         [style (if (eq? show-panel "import") '(border) '(deleted))]
         [alignment '(right top)]
         ))
(define *tune-panel*
    (new vertical-panel%
         [parent *right-column*]
         [style (if (eq? show-panel "tune") '(border) '(deleted))]
         [alignment '(right top)]
         ))

(define edit-src
    (new text%))

(define edit-canv
    (new editor-canvas%
         [parent *steps-panel*]
         [editor edit-src]))

(define output-src
    (new text%))

(define output-canv
    (new editor-canvas%
         [parent frame]
         [editor output-src]))

; Define slider callbacks
(define (adjust-tuning-amount widget event)
     (begin
          (set! tuning-amount (send amount-sld get-value))
          (send edit-src insert (number->string tuning-amount))))

; Define sliders
(define amount-sld
     (new slider%
          [label "Tuning Amount"]
          [callback adjust-tuning-amount]
          [parent *tune-panel*]
          [min-value 0]
          [max-value 10]
          [init-value 5]))
(define color-sld
     (new slider%
          [label "Voice Color"]
          [parent *tune-panel*]
          [min-value 0]
          [max-value 10]
          [init-value 5]))

; Set the window to accept drag-n-drop files
(send frame accept-drop-files #t)

; tuner thing
(define (tune-part part)
     (for/list ([i (for/list ([i part]) (slist->string i))]) (string-join i " ")))

; converts a mixed list of lists to a string
(define (convert-part lst)
     (for/list ([i (for/list ([i lst]) (slist->string i))]) (string-join i " ")))

(define msg (new message% [parent frame] [label file-mode]))

; Imports a given midi file into variable "src"
(define (midi-import file)
     (begin
          (set! src (midi-convert (midi-file-parse file)))
          (import-handler src)))

; Converts string input to list
(define (input-handler str)
     (begin
          (define lst (string-split str))
          (displayln lst)
          (define (internal lst)
               (if (or (eq? (length lst) 0) (< (length lst) 2)) '()
                   (cons
                        (list
                             (string->number (first lst))
                             (string->number (second lst))
                             (third lst))
                        (internal (list-tail lst 3)))))
          (set! note-lst (internal lst)))
          (displayln note-lst))

; Tune callback handler
(define (tune-handler part)
     (begin
          (set! tuned-lst (voca-tuner part))
          (for ([i (tune-part tuned-lst)])
               (send output-src insert (string-append i "\n")))))

; handle import data
(define (import-handler part)
     (for ([i (convert-part part)])
          (send edit-src insert (string-append i "\n"))))

; Tune button
(new button%
     [parent frame]
     [label "Tune"]
     [callback
          (lambda (button event)
               (begin
                    (set! input-txt (send edit-src get-text 0 'eof))
                    (input-handler input-txt)
                    (tune-handler note-lst)
               ))
          ])

(new button%
     [parent frame]
     [label "Import .mid"]
     [callback
          (lambda (button event)
               (midi-import (get-file)))])

(new button%
     [parent frame]
     [label "Export VSQX!"]
     [callback
          (lambda (button event)
               (vocaloid-export tuned-lst (put-file)))])

; (new button%
;     [parent frame]
;     [label "Export"]
;     [callback
;          (lambda (button event)
;               (vocaloid-export note-lst))])

(send frame show #t)

;at click of button
; v- store input in var
; v- process with tune-part
; v- stream output to gui

