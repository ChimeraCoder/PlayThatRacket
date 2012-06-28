#lang racket/base

(require rackunit
         "datatypes.rkt")

;; TODO: Add assertions.
(check-exn
   exn:fail?
   (pitch-function '(4 3))
   "Calling pitch-function on non number raises user error.")

(check-exn
   exn:fail?
   (duration-function '(4 3))
   "Calling duration-function on non number raises user error.")

