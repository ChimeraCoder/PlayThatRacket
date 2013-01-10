#lang typed/racket/no-check

(require "datatypes.rkt")
(require "scale.rkt")
(require "basic-ops-typed.rkt")

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
    [(list-rest a b ...d) (cons (ensure-reasonable-length (ensure-middle-octave (note a b ))) (make-notes (cddr nums)))]
    [(list a) (ensure-reasonable-length (ensure-middle-octave (note a 5)))]
    [_ '()]))
      

#|
  ;;TODO fix this
  (: ensure-middle-octave (note -> note))
  (define (ensure-middle-octave nt) 
    (if (< (note-pitch nt) 260)
      (note (* 2 (note-pitch nt)) (note-duration nt)))
      nt)
    
  (: ensure-reasonable-length (note -> note))
  (define (ensure-reasonable-length nt) 
    (if (< (note-duration nt) 500)
      (note (note-pitch nt) 500)
      nt))|#




(provide (all-defined-out))      
