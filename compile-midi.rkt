(module compile-midi racket/base
   (require racket/list)
   (require racket/match)

   (define (calculate-deltas lst) 
     (map (lambda (a b) 
            (cons 
              (- (car b) (car a)) 
              (cdr b))) 
          (drop-right lst 1) (drop lst 1)))

   (define (collapse-to-deltas lst)
     (cons (car lst) (calculate-deltas lst)))

   ;; returns the binary bits backwards
   (define (num-to-binary-r n)
        (if (>= n 1)
               (cons (if (even? n)
                       0
                       1)
               (num-to-binary-r
                 (quotient n 2)))
               null))

   (define (num-to-binary-rev n)
     (if (= 0 n)
       '(0)
       (num-to-binary-r n)))

   (define (num-to-binary n)
     (reverse (num-to-binary-rev n)))

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
     (binary-to-midi-encoding (num-to-binary-rev delta) #t))

   (define (pad-binary binary n)
     (if (< (length binary) n)
       (pad-binary (cons 0 binary) n)
       binary)
     )

   (define (midi-event-to-nibble event)
     (match event
            ['note-off '(1 0 0 0)]
            ['note-on '(1 0 0 1)]
            ['aftertouch '(1 0 1 0)]
            ['control-change '(1 0 1 1)]
            ['program-change '(1 1 0 0)]
            ['channel-aftertouch '(1 1 0 1)]
            ['pitch-bend '(1 1 1 0)]
            ))

   (define (midi-meta-event-to-byte event)
     (match event
            ['set-tempo '(0 1 0 1 0 0 0 1)]
            ['time-signature '(0 1 0 1 1 0 0 0)]
            ))

   (define (bit-list-to-int bit-list)
     (if (null? bit-list)
       null
       (cons (foldl + 0 (map (lambda (a b) (* a b)) (take bit-list 8) '(128 64 32 16 8 4 2 1))) 
             (bit-list-to-int (drop bit-list 8)))))

   (define (byte-list-to-int byte-list)
     (if (null? byte-list)
       null
       (cons (foldl + 0 (map (lambda (a b) (* a b)) (take byte-list 2) '(16 1)))
             (byte-list-to-int (drop byte-list 2)))))

   (define (note-on channel note velocity)
     (append (midi-event-to-nibble 'note-on) 
             (pad-binary (num-to-binary channel) 4) 
             (pad-binary (num-to-binary note) 2) 
             (pad-binary (num-to-binary velocity) 2)))


   (define (header-chunk) '(#x4d #x54 #x68 #x64 #x00 #x00 #x00 #x06))
   (define (track-chunk) '(#x4d #x54 #x72 #x68))

   (define (header-bytes format-type number-of-tracks time-division)
     (append (header-chunk)  
             (byte-list-to-int (pad-binary (list format-type) 4))
             (bit-list-to-int (pad-binary (num-to-binary number-of-tracks) 16))
             (bit-list-to-int (pad-binary (num-to-binary time-division) 16))))

   ;;(define out (open-output-file "testing"))

  ;; (define (intermediate-to-bytes intermediate)
  ;;   (let ([rest (cdr intermediate)])
  ;;   (match (car intermediate)
  ;;          ['multi 

   (provide (all-defined-out))
)
