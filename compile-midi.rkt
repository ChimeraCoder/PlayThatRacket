(module compile-midi 

   (define (calculate-deltas lst) 
     (map (lambda (a b) 
            (cons 
              (- (car b) (car a)) 
              (cdr b))) 
          (drop-right lst 1) (drop lst 1)))

   (define (collapse-to-deltas lst)
     (cons (car lst) (calculate-deltas lst)))

   ;; returns the binary bits backwards
   (define (delta-to-binary n)
     (if (= n 0)
       0
        (if (>= n 1)
               (cons (if (even? n)
                       0
                       1)
               (delta-to-binary
                 (quotient n 2)))
               null)))

   (define (binary-to-midi-encoding b start)
     (let ([bit (if start 0 1)])
     (if (> (length b) 7)
       (append 
               (binary-to-midi-encoding (drop b 7) #f)
               (cons bit (reverse (take b 7)))
               )
       (cons bit (pad-binary (reverse b))))
     ))

   (define (delta-to-midi delta)
     (binary-to-midi-encoding (delta-to-binary delta) #t))

   (define (pad-binary binary)
     (if (< (length binary) 7)
       (pad-binary (cons 0 binary))
       binary)
     )

   (define (bit-list-to-chars bit-list)
     (if (null? bit-list)
       null
       (cons (foldl + 0 (map (lambda (a b) (* a b)) (take bit-list 4) '(8 4 2 1))) 
             (bit-list-to-chars (drop bit-list 4))))


   (define (header-chunk) '(0x4d 0x54 0x68 0x64 0x00 0x00 0x00 0x06))
   (define (track-chunk) '(0x4d 0x54 0x72 0x68))


   (provide (all-defined-out))
)
