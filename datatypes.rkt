#lang racket/base


(define (music-cons pitch duration)
  ;;The first argument will be a function which evaluates to one of the following:
  ;;    1) A numeric (integral) value (in which case the units are Hz)
  ;;    2) Another music-cons
  ;;The second argument will be a function which evaluates to one of the following:
  ;;    1) A numeric (integral) value (in which case the units are milliseconds)
  ;;    2) Another music-cons
  ;;    3) Null (which is a special case of music-cons)
  (quasiquote (unquote pitch) (unquote duration)))


(define (pitch-function pitch-number)
    ;;Theoretically, this is redundant and equivalent to duration-function, but it is a useful abstraction when starting out
    ;;pitch-number is assumed to be in Hz
    (if (number? pitch-number)
      (lambda (x) pitch-number)
      (raise-user-error "pitch called with non-numeric arg")))


(define (duration-function duration-number)
  (if (number? duration-number)
    (lambda (x) duration-number)
    (raise-user-error "duration called with non-numeric arg")))




