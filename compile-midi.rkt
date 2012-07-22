(module compile-midi racket/base
   (require racket/list)
   (require racket/match)
   (require (planet clements/midi:1:0))

   (define (calculate-deltas lst) 
     (map (lambda (a b) 
            (cons 
              (- (car b) (car a)) 
              (cdr b))) 
          (drop-right lst 1) (drop lst 1)))

   (define (collapse-to-deltas lst)
     (cons (car lst) (calculate-deltas lst)))

   (define a (midi-file-parse "Drum_sample.mid"))
   (define data (collapse-to-deltas (car (cdaddr a))))
   (define cell (car data))
   (define metadata (caaddr a))

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

   (define (midi-meta-header)
     '(1 1 1 1 1 1 1 1))
   (define (midi-meta-event-to-byte event)
     (match event
            ['set-tempo '(0 1 0 1 0 0 0 1)]
            ['time-signature '(0 1 0 1 1 0 0 0)]
            ['end-of-track '(0 0 1 0 1 1 1 1)]
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
             (pad-binary (num-to-binary note) 8) 
             (pad-binary (num-to-binary velocity) 8)))


   (define (header-chunk) '(#x4d #x54 #x68 #x64 #x00 #x00 #x00 #x06))
   (define (track-chunk) '(#x4d #x54 #x72 #x68))

   (define (header-bytes format-type number-of-tracks time-division)
     (append (header-chunk)  
             (byte-list-to-int (pad-binary (list format-type) 4))
             (bit-list-to-int (pad-binary (num-to-binary number-of-tracks) 16))
             (bit-list-to-int (pad-binary (num-to-binary time-division) 16))))

   (define (track-bytes track-size)
     (append (track-chunk)
             (bit-list-to-int (pad-binary (num-to-binary track-size) 32))))

   (define (event-bytes event delta channel param1 param2)
     (append (delta-to-midi delta) (midi-event-to-nibble event)
             (pad-binary (num-to-binary param1) 8)
             (if (number? param2)
               (pad-binary (num-to-binary param2) 8)
               (pad-binary (num-to-binary 0) 8))))

   (define (process-event event-tree)
     (let ([delta (car event-tree)]
           [event (caadr event-tree)]
           [channel (cadadr event-tree)]
           [params (cddadr event-tree)])
     (event-bytes event delta channel (car params) (cadr params))))


   (define (process-time-signature time-list) 
     (append (midi-meta-header) (midi-meta-event-to-byte 'time-signature) 
             (pad-binary (num-to-binary (first time-list)) 8)
             (pad-binary (num-to-binary (second time-list)) 8)
             (pad-binary (num-to-binary (third time-list)) 8)
             (pad-binary (num-to-binary (fourth time-list)) 8)))

   (define (process-set-tempo tempo) 
     (append (midi-meta-header) (midi-meta-event-to-byte 'set-tempo)
             (pad-binary (num-to-binary tempo) 24)))

   (define (process-end-of-track)
     (append (midi-meta-header) (midi-meta-event-to-byte 'end-of-track)))

   (define (process-meta-event event-tree)
     (if (equal? (cadadr event-tree) 'end-of-track)
       (process-end-of-track)
       (let* ([delta (car event-tree)]
             [event-data (cadadr event-tree)]
             [event-param (cadr event-data)])
             (match (car event-data)
                    ['time-signature (process-time-signature event-param)]
                    ['set-tempo (process-set-tempo event-param)]))
                          ))

   ;;(define out (open-output-file "testing"))

  ;; (define (intermediate-to-bytes intermediate)
  ;;   (let ([rest (cdr intermediate)])
  ;;   (match (car intermediate)
  ;;          ['multi 

   (provide (all-defined-out))
)
