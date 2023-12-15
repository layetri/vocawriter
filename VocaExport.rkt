; Provides an exporter for VSQX files. It writes data parsed by the VocaWriter library from this same package. File path can be provided as an argument.

(provide voca-out)

; Writes out parsed data to specified file path
(define (voca-out data path)
    (begin
        (define fileport (open-output-file (string->path path)))
        (write fileport data)
        (close-output-port fileport)))