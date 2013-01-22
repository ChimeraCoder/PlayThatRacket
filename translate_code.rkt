#lang typed/racket/no-check

(require "datatypes.rkt")
(require "scale.rkt")
(require "basic-ops-typed.rkt")

(define MAX_PITCH 1000)
(define MAX_DURATION 1000)

;A very basic example of one possible transformation function for arbitrary s-expressions
;ANY function with the same signature could be substituted in here; this one is a relatively boring one
;The function needs to take an arbitrary s expression and return a list of notes
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
    [(list-rest a b ...d) (cons (ensure-reasonable-length (ensure-middle-octave (note a b ))) (make-notes (cddr nums)))]
    [(list a) (ensure-reasonable-length (ensure-middle-octave (note a 5)))]
    [_ '()]))

(provide (all-defined-out))      
