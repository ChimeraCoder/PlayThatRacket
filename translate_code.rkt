#lang typed/racket/no-check

(require "datatypes.rkt")
(require "scale.rkt")

(define MAX_PITCH 1000)
(define MAX_DURATION 1000)

(define (translate tree)
  (cond
    [(list? tree) (match (length tree)
                    [0 60]
                    [1 (translate (car tree))]
                    [_ (flatten (list (map translate tree)))])]
    [(symbol? tree) (string-length (symbol->string tree))]
    [(string? tree) (string-length tree)]
    [(number? tree) tree]
    [else 50]))


(: make-notes ((Listof Number) -> (Listof note)))
(define (make-notes nums)
  (match nums
    [(list-rest a b ...d) (cons (note (min a MAX_PITCH) (min b MAX_DURATION)) (make-notes (cddr nums)))]
    [(list a) (note (min a MAX_PITCH) 5)]
    [_ '()]))
      
(provide (all-defined-out))      
