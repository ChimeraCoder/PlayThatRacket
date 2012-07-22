#lang racket

(require rackunit
         "../basic-ops-untyped.rkt")

(define A♮ (note 440 500))
(define A♯ (note (round (inexact->exact 466.16)) 500)) 

(test-case "Spatter should work on a single note"
  (check-equal? (length (spatter A♮)) 50)
  (map (lambda (nt) (check-equal? (note-pitch nt) 440)) (spatter A♮))
  (check-equal? #t #t)) ;;Ending with a check-equal? statment prevents a bunch of voids from being returned

(test-case "Spatter should work on group of notes"
  (define A♮-spatter (spatter A♮))
  (define A♯-spatter (spatter A♮))
  (define pair-spattered (spatter (list A♮ A♯)))

  (check-equal? (length (flatten pair-spattered)) 100)
  (map (lambda (nt) (check-equal? (note-pitch nt) (note-pitch A♮))) (car pair-spattered))
  (map (lambda (nt) (check-equal? (note-pitch nt) (note-pitch A♯))) (cadr pair-spattered))
  (check-equal? #t #t))




