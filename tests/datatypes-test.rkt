#lang racket/base

(require rackunit
         "../basic-ops.rkt")

;; TODO: Add assertions.
;;(check-exn
;; exn:fail?
;; (lambda () (pitch-function '(4 3))
;;  "Calling pitch-function on non number raises user error."))
;;
;;

(define phrase1 (list (note 100 400) (note 200 400) (note 300 400)))
(define phrase2 (list (note 500 400) (note 600 400) (note 700 400)))
(check-equal? (join-phrases phrase1 phrase2) (append phrase1 phrase2) "Implicit join-phrase test failed")
(check-equal? (join-phrases phrase1 phrase2) (list (note 100 400) (note 200 400) (note 300 400)  (note 500 400) (note 600 400) (note 700 400))  "Explicit join-phrase test failed")


(define A (note 440 500))
(define A# (note (round (inexact->exact 466.16)) 500))
(define Ab (note (round (inexact->exact 415.486)) 500))


;;Check that semitone-{up,down} adjusts pitch to within 1Hz of the correct value
(check-= (note-pitch (semitone-up A)) (note-pitch A#) 1 "Semitone up check failed")
(check-= (note-pitch (semitone-down A)) (note-pitch Ab) 1 "Semitone down check failed")


(define phrase1-semi-down-target (list (note 94 400) (note 189 400) (note 283 400)))
(define phrase2-semi-down-target  (list (note 472 400) (note 566 400) (note 661 400)))
(define nested-phrases (list phrase1 phrase2))

(define phrase1-semi-up-target (list (note 106 400) (note 212 400) (note 318 400)))

(check-equal? phrase1-semi-up-target (semitone-up-f phrase1))

(define semitone-up-f-target (list (list (note 106 400) (note 212 400) (note 318 400)) (list (note 530 400) (note 636 400) (note 742 400))))

(define semitone-down-f-target (list (note 94 400) (note 189 400) (note 283 400) (note 472 400) (note 566 400) (note 661 400)))

(check-equal? semitone-up-f-target (semitone-up-f (list phrase1 phrase2)))
(check-equal? semitone-down-f-target (semitone-down-f (list phrase1 phrase2)))





