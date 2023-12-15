#lang racket

; This is some DIY project. Read: This project isn't endorsed, sponsored, backed, developed or anything by Yamaha.
; Vocaloid is a trademark of Yamaha.
;
;
; Script: © 2019 LayetriP
;
; To be used by Mari-Hime for generating daily Vocaloid songs.

;(require "./VocaExport.rkt")

(provide vocaloid-export)
(provide vocaloid-singer)
(provide singer-list)

(define voca-vel 64)
(define voca-version '"4.0.0.3")
(define voca-singer '"MikuJP_ORIGINAL")
(define voca-title '"Cool_Miku_Project")
(define voca-bpm 120)

(define partLen 0)

(define test-part '((60 120 "la") (62 120 "la") (64 120 "la") (60 120 "la")))

(define singers (make-hash))
(hash-set! singers "MikuENG" '("BMLTD846MLYP2MEK" "English"))
(hash-set! singers "MikuJP_ORIGINAL" '("BCNFCY43LB2LZCD4" "Japanese"))

(define note-array "")

(define syl-lookup (make-hash))
(hash-set! syl-lookup "r" "4")
(hash-set! syl-lookup "l" "4")

;(take (rest (string-split syl "")) (string-length syl))

(define (syllable-conversion syl)
    (begin
        (define split-syl (take (rest (string-split syl "")) (string-length syl)))
        (define (internal lst)
            (if (empty? lst) '()
                (append (list (if (hash-has-key? syl-lookup (first lst)) (hash-ref syl-lookup (first lst)) (first lst)))
                        (internal (rest lst)))))
        (string-join (internal split-syl) " ")))



; for testing, should be loaded separately
(define (voca-out data path)
    (begin
        (define fileport (open-output-file (string->path path) #:exists 'replace))
        (displayln data fileport)
        (close-output-port fileport)))

; Sets the Vocaloid singer based on the given name
(define (vocaloid-singer name)
    (when (not (empty? (hash-ref singers name))) (set! voca-singer name))
)

(define (singer-list) singers)

; Helper function: calculates the absolute length of a note from a LilyPond note value
(define (calc-dur note)
    (note)
)

(define (inject-notes song-part)
    (begin

        (for/list ([i (length song-part)])
          (begin
              ;Note formatted as: (define note '(note-num len(ms) syllable))
              ;Note position is partLen before sum
              (define currentNote (list-ref song-part i))

              ;Splits the current note into three properties
              (define note-cc (list-ref currentNote 0))
              (define note-len (list-ref currentNote 1))
              (define note-syl (list-ref currentNote 2))
              (define note-phon (syllable-conversion note-syl))
              (define note-start partLen)

              ;Injects the note values into an XML template
              (define xml-block
                  (string-append
                      "<note> \n <t>"
                      ; <t> defines the note's start position in ms
                      (number->string note-start)
                      "</t> \n <dur>"
                      ; <dur> defines the note's duration in ms
                      (number->string note-len)
                      "</dur> \n <n>"
                      ; <n> defines the note's midi pitch cc
                      (number->string note-cc)
                      "</n> \n <v>"
                      ; <v> defines the note's velocity
                      (number->string 64)
                      "</v> \n <y>"
                      "<![CDATA[" note-syl "]]>"
                      "</y> \n <p>"
                      "<![CDATA[" note-phon "]]>"
                      "</p> \n <nStyle> \n"
                      "<v id=\"accent\">80</v>
                       <v id=\"bendDep\">0</v>
                       <v id=\"bendLen\">0</v>
                       <v id=\"decay\">70</v>
                       <v id=\"fallPort\">0</v>
                       <v id=\"opening\">127</v>
                       <v id=\"risePort\">0</v>
                       <v id=\"vibLen\">0</v>
                       <v id=\"vibType\">0</v> \n"
                      "</nStyle> \n </note>"
                  )
              )

              ;Appends the XML Note template to note-array
              (set! note-array (string-append note-array xml-block))

              (displayln note-len)
              (set! partLen (+ partLen note-len))
          )
      )
      note-array
    )
)

; parses input data into header text
(define (parse-header)
    (string-append "<?xml version=\"1.0\" encoding=\"UTF-8\" standalone=\"no\"?>
            <vsq4 xmlns=\"http://www.yamaha.co.jp/vocaloid/schema/vsq4/\" xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xsi:schemaLocation=\"http://www.yamaha.co.jp/vocaloid/schema/vsq4/ vsq4.xsd\">
            <vender><![CDATA[Yamaha corporation]]></vender>
            <version><![CDATA[3.0.0.11]]></version>
            <vVoiceTable>
                <vVoice>
                    <bs>0</bs>
                    <pc>7</pc>
                    <id><![CDATA[" (list-ref (hash-ref singers voca-singer) 0) "]]></id>
                    <name><![CDATA[]]></name>
                    <vPrm>
                        <bre>0</bre>
                        <bri>0</bri>
                        <cle>0</cle>
                        <gen>0</gen>
                        <ope>0</ope>
                    </vPrm>
                </vVoice>
            </vVoiceTable>"))

; parses input data into track text
(define (parse-track)
    (string-append "<vsTrack>
        <tNo>0</tNo>
        <name><![CDATA[VocaWriter_EXPORT]]></name>
        <comment><![CDATA[Exported by VocaWriter.]]></comment>
        <vsPart>
            <t>1920</t>
            <playTime>" (number->string partLen) "</playTime>
            <name><![CDATA[VocaWriter_PART]]></name>
            <comment><![CDATA[]]></comment>
            <sPlug>
                <id><![CDATA[ACA9C502-A04B-42b5-B2EB-5CEA36D16FCE]]></id>
                <name><![CDATA[VOCALOID2 Compatible Style]]></name>
                <version><![CDATA[3.0.0.1]]></version>
            </sPlug>
            <pStyle>
                <v id=\"accent\">50</v>
                <v id=\"bendDep\">8</v>
                <v id=\"bendLen\">0</v>
                <v id=\"decay\">50</v>
                <v id=\"fallPort\">0</v>
                <v id=\"opening\">127</v>
                <v id=\"risePort\">0</v>
            </pStyle>
            <singer>
                <t>0</t>
                <bs>0</bs>
                <pc>7</pc>
            </singer>
            <cc>
                <t>0</t>
                <v id=\"S\">1</v>
            </cc>"))

; consolidates all ingredients into one callable function
(define (voca->text notes)
    (begin
        (define noted (inject-notes notes))
        (string-append (parse-header) "\n" (file->string "/Users/layetri/Development/VocaWriter/files/vsqx-begin") "\n" (parse-track) "\n" noted "\n" (file->string "/Users/layetri/Development/VocaWriter/files/vsqx-end"))))

(vocaloid-singer "MikuENG")

(define (vocaloid-export notes path)
    (voca-out (voca->text notes) (string-append (path->string path) ".vsqx")))


; create a track
; create a part
; translate notes
; save .vsqx

