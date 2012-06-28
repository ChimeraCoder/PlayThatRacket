(module datatypes racket/base
 (define (music-cons pitch duration)
  ;;The first argument will be a function which evaluates to one of the following:
  ;;    1) A numeric (integral) value (in which case the units are Hz)
 ;;    2) Another music-cons
;;The second argument will be a function which evaluates to one of the following:
;;    1) A numeric (integral) value (in which case the units are milliseconds)
;;    2) Another music-cons
    ;;    3) Null (which is a special case of music-cons)
(if (not (andmap procedure? (list pitch duration)))
 (raise-user-error "music-cons called with at least one non-procedure argument")
 (quasiquote ((unquote pitch) (unquote duration)))))

(define (music-cons? val1)
 (andmap (list 
          (equal? (length val1) 2)  ;;Length of a cons must be 2
          (or (procedure? (car val1))
           (music-cons? (car val1)))))) ;;Each cell of a cons must be either a procedure or another music-cons

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
(provide (all-defined-out)))
