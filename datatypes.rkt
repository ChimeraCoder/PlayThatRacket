(module datatypes typed/racket


  (struct: note ([pitch : Integer] [duration : Integer]))
  (define-type Note (Rec NT (U note (Pair NT NT))))
  
  (: raise-octave (note -> note))
  (define (raise-octave nt)
    (note (* 2 (note-pitch nt)) (note-duration nt)))

  ;;This function is superfluous, but it illustrates racket's type syntax
  (: raise-all-octave ((Listof note) -> (Listof note)))
  (define (raise-all-octave nt-lst)
    (map raise-octave nt-lst))

  ;;A phrase is a list of notes of arbitrary length
  (define-type Phrase (Listof note))

  (struct: time-signature ([beats    : Integer]  ;;How many beats per measure                            
                           [one-note : Integer])) ;;The note that represents a single beat

  (define *time-signature* (make-parameter (time-signature 4 4)))


  (struct: tempo ([milliseconds-per-beat : Integer]))
  
  (define (tempo-in-bpm beats-per-measure)
  ;;TODO
    '())
  
  (define (tempo-in-mspb milliseconds-per-beat)
  ;;TODO
    '())

  (define *tempo* (make-parameter (tempo-in-mspb 500)))

                                                                                    ;;A measure (a list of notes with a predefined length) can be defined using macros

  (: join-phrases (Phrase Phrase -> Phrase))
  (define (join-phrases phrase1 phrase2)
    (append phrase1 phrase2))

(provide (all-defined-out)))
