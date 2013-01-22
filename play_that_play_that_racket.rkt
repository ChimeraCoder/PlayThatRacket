#lang racket

(require "rsound.rkt")
(require "translate_code.rkt")

(require compiler/decompile)
(require compiler/zo-parse)


;;Obligatory: Every Lisp dialect needs to be able to compile itself
;;This Lisp dialect can also _decompile_ itself and play its own compiler as a song

;;Decompile a racket binary into s-expressions
(define fin (open-input-file "compiled/datatypes_rkt.zo" #:mode 'binary))
(define bytecode (zo-parse fin))
(define source (decompile bytecode))
;;Translate the source code into a song
(define compiler-as-song (flatten (make-notes (translate (take (cadr source) 20)))))

(play-notes compiler-as-song)

(sleep 2000)

(provide (all-defined-out))
