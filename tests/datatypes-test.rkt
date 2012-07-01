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
(check-equal? (join-phrases phrase1 phrase2) (append phrase1 phrase2) "join-phrase test failed")
