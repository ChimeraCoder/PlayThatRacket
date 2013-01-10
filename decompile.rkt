(require compiler/decompile)
(require compiler/zo-parse)


(define fin (open-input-file "compiled/datatypes_rkt.zo" #:mode 'binary))

(define bytecode (zo-parse fin))

(define source (decompile bytecode))

