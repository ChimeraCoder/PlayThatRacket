
(define (mapskip desired-function lst)
  (let* ((toggler (make-toggler true)))  ;; switcher is a function that switches to the identity fun
    (map (lambda (x) (apply-if (toggler) desired-function x)) lst)))
    


  (lambda (x start)
    (define skip-current start)

(define (make-toggler desired-function)
  (let ([apply? true])
    (lambda ()
      (let ((result (possibly-apply desired-function apply?)))
        (set! apply? (not apply?))
        result))))

(define (apply-if predicate desired-function x)
    (if predicate
      (desired-function x)
      x))


(define contrarian
  (let* ((response true))
     (lambda ()
       (set! response (not response))
       response)))

;;A toggler returns the opposite response each time you call it
(define (make-toggler starting-value)
  (lambda ()
    (set! starting-value (not starting-value))
    starting-value))



(define (foo entire-tree)
  (let* ((length-declr (length (cdr tree)))
         (stuff-for-header (make-header length-declr bar baz)))
     (print-result stuff-for-header (cdr tree))))








