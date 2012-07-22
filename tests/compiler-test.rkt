#lang racket/base

(require rackunit
         "../compile-midi.rkt")

(check-equal? (process-event '(61 (note-off 1 36 64)) '(0 0 1 1 1 1 0 1 1 0 0 0 0 0 1 0 0 1 0 0 0 1 0 0 0 0 0 0)))
(check-equal? (process-event '(0 (note-on 1 36 97)) '(0 0 0 0 0 0 0 0 1 0 0 1 0 0 1 0 0 1 0 0 0 1 1 0 0 0 0 1)))

