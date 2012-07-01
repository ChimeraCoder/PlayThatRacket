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


  (struct: Tempo ([milliseconds-per-beat : Integer]))

  (define (semitone-up nt)
    (note (truncate (* (note-pitch nt) 1.05946)) (note-duration nt)))
  (define (semitone-down nt)
    (note (truncate (/ (note-pitch nt) 1.05946)) (note-duration nt)))
  
  (: tempo-in-bpm (Integer -> Tempo))
  (define (tempo-in-bpm beats-per-minute)
    (Tempo (truncate (* (/ beats-per-minute 60) 1000))))
  
  (: tempo-in-mspb (Integer -> Tempo))
  (define (tempo-in-mspb milliseconds-per-beat)
    (Tempo milliseconds-per-beat))

  (define *tempo* (make-parameter (tempo-in-mspb 500)))

                                                                                    ;;A measure (a list of notes with a predefined length) can be defined using macros

  (: join-phrases (Phrase Phrase -> Phrase))
  (define (join-phrases phrase1 phrase2)
    (append phrase1 phrase2))

(provide (all-defined-out)))
