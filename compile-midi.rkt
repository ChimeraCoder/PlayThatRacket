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
   (define (num-to-binary n)
     (if (= n 0)
       0
        (if (>= n 1)
               (cons (if (even? n)
                       0
                       1)
               (num-to-binary
                 (quotient n 2)))
               null)))

   (define (binary-to-midi-encoding b start)
     (let ([bit (if start 0 1)])
     (if (> (length b) 7)
       (append 
               (binary-to-midi-encoding (drop b 7) #f)
               (cons bit (reverse (take b 7)))
               )
       (cons bit (pad-binary (reverse b) 7)))
     ))

   (define (delta-to-midi delta)
     (binary-to-midi-encoding (num-to-binary delta) #t))

   (define (pad-binary binary n)
     (if (< (length binary) n)
       (pad-binary (cons 0 binary) n)
       binary)
     )

   (define (midi-event-to-nibble event)
     (match event
            ['note-off '(1 0 0 0)]
            ['note-on '(1 0 0 1)]
            ['key-after-touch '(1 0 1 0)]
            ['control-change '(1 0 1 1)]
            ['program-change '(1 1 0 0)]
            ['channel-after-touch '(1 1 0 1)]
            ['pitch-wheel-change '(1 1 1 0)]
            ))

   (define (midi-meta-event-to-byte event)
     (match event
            ['set-tempo '(0 1 0 1 0 0 0 1)]
            ['time-signature '(0 1 0 1 1 0 0 0)]
            ))

   (define (bit-list-to-chars bit-list)
     (if (null? bit-list)
       null
       (cons (foldl + 0 (map (lambda (a b) (* a b)) (take bit-list 4) '(8 4 2 1))) 
             (bit-list-to-chars (drop bit-list 4)))))

   (define (note-on channel note velocity)
     (append (midi-event-to-nibble 'note-on) 
             (pad-binary (num-to-binary channel) 4) 
             (pad-binary (num-to-binary note) 2) 
             (pad-binary (num-to-binary velocity) 2)))


   (define (header-chunk) '(0x4d 0x54 0x68 0x64 0x00 0x00 0x00 0x06))
   (define (track-chunk) '(0x4d 0x54 0x72 0x68))


   (provide (all-defined-out))
)
