#lang racket/base

(require rackunit
         "datatypes.rkt")

;; TODO: Add assertions.
(check-exn
   exn:fail?
   (pitch-function (3 4)))
