(module compile-midi 

   (define (calculate-deltas lst) 
     (map (lambda (a b) 
            (cons 
              (- (car b) (car a)) 
              (cdr b))) 
          (drop-right lst 1) (drop lst 1)))

   (define (collapse-to-deltas lst)
     (cons (car lst) (calculate-deltas lst)))

   (provide (all-defined-out))
)
