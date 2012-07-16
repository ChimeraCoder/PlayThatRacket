(module datatypes-aux racket

    (require "datatypes.rkt")

    (define (flatten-phrase phrs)
      (flatten phrs))

    (define (append-phrase phrase1 phrase2)
      (append phrase1 phrase2))

    (define (map-phrase fn phrase)
       (map fn phrase))


    (define-syntax-rule (define/automap (name arg) bodies) 
       (define (name new-arg) 
         (define (old arg) bodies) 
           (if (list? new-arg) ;;if it is a list
             (map-phrase name new-arg)
             (old new-arg) 
             )))


    (define/automap (semitone-up-f nt)
      (note (round (inexact->exact (* (note-pitch nt) 1.05946))) (note-duration nt)))

    (provide (all-defined-out)))
