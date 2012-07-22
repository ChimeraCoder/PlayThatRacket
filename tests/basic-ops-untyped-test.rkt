#lang racket

(require rackunit
         "../basic-ops-untyped.rkt")

(require (only-in "../supermap.rkt" map/skip))

(define A♭ (note 415 500))
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

(test-case "Trill should work on a single note"
  (define A♮-trilled (trill A♮))

  (map (lambda (nt) (check-equal? (note-duration nt) (note-duration A♮))) A♮-trilled)  
  (map/skip (lambda (nt) (check-equal? (note-pitch nt) (note-pitch (semitone-up A♮)))) A♮-trilled)  
  (map/skip (lambda (nt) (check-equal? (note-pitch nt) (note-pitch A♮))) A♮-trilled #f)  

  (check-equal? #t #t))

(test-case "Trill should work on a group of notes"
  (define A♮-trilled (trill A♮))
  (define A♭-trilled (trill A♭))
  (define pair-trilled (trill (list A♮ A♭)))
  (check-equal? (car pair-trilled) A♮-trilled)
  (check-equal? (cadr pair-trilled) A♭-trilled)
  (check-equal? (flatten pair-trilled) (flatten (list A♮-trilled A♭-trilled)))

  (check-equal? #t #t))



