#lang racket

(require racket/gui)

(define game-canvas%
    (class canvas%
           (inherit get-width get-height refresh)

           ;; direction : one of #f, 'left, 'right, 'up, 'down
           (define direction #f)

           (define/override (on-char ke)
                            (case (send ke get-key-code)
                                [(left right up down)
                                 (set! direction (send ke get-key-code))
                                 (refresh)]
                                [else (void)]))

           (define/private (my-paint-callback self dc)
                           (let ([w (get-width)]
                                 [h (get-height)])
                               (when direction
                                   (let ([dir-text (format "going ~a" direction)])
                                       (let-values ([(tw th _ta _td)
                                                     (send dc get-text-extent dir-text)])
                                           (send dc draw-text
                                                 dir-text
                                                 (max 0 (/ (- w tw) 2))
                                                 (max 0 (/ (- h th) 2))))))))

           (super-new (paint-callback (lambda (c dc) (my-paint-callback c dc))))))

(define game-frame (new frame% (label "game") (width 600) (height 400)))
(define game-canvas (new game-canvas% (parent game-frame)))
(send game-frame show #t)