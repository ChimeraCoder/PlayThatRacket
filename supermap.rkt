(module supermap racket

 (define (map/skip desired-function lst (skip-first #t))
  (let* ((toggler (make-toggler skip-first)))  ;; switcher is a function that switches to the identity fun
   (map (lambda (x) (apply-if (toggler) desired-function x)) lst)))

 (define (apply-if predicate desired-function x)
  (if predicate
   (desired-function x)
   x))

 ;;A toggler returns the opposite response each time you call it
 (define (make-toggler starting-value)
  (lambda ()
   (set! starting-value (not starting-value))
   starting-value))
 
 (provide map/skip))




