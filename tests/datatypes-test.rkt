#lang racket/base

(require rackunit
         "../datatypes.rkt")

;; TODO: Add assertions.
;;(check-exn
;; exn:fail?
;; (lambda () (pitch-function '(4 3))
;;  "Calling pitch-function on non number raises user error."))
;;
;;

(define phrase1 (list (note 1 4) (note 2 4) (note 3 4)))
(define phrase2 (list (note 5 4) (note 6 4) (note 7 4)))
(check-equal? (join-phrases phrase1 phrase2) (append phrase1 phrase2) "Implicit join-phrase test failed")
(check-equal? (join-phrases phrase1 phrase2) (list (note 1 4) (note 2 4) (note 3 4)  (note 5 4) (note 6 4) (note 7 4))  "Explicit join-phrase test failed")


(define A (note 440 500))
(define A# (note (round (inexact->exact 466.16)) 500))
(define Ab (note (round (inexact->exact 415.486)) 500))


;;Check that semitone-{up,down} adjusts pitch to within 1Hz of the correct value
(check-= (note-pitch (semitone-up A)) (note-pitch A#) 1 "Semitone up check failed")
(check-= (note-pitch (semitone-down A)) (note-pitch Ab) 1 "Semitone down check failed")





