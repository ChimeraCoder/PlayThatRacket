(module datatypes typed/racket

  ;(require racket/stream)
 
  (struct: note ([pitch : Integer] [duration : Integer]) #:transparent)
  ;;(define-type Note (Rec NT (U note (Pair NT NT))))
  
  ;;A phrase is a list of notes of arbitrary length
  (define-type Phrase (Rec NT (U note (Listof NT))))

  (define-type MysteryType (U Number (Listof Number)))

  (struct: time-signature ([beats    : Integer]  ;;How many beats per measure                            
                           [one-note : Integer])) ;;The note that represents a single beat

  (struct: Tempo ([milliseconds-per-beat : Integer]))

  (define *time-signature* (make-parameter (time-signature 4 4)))



(provide (all-defined-out)))
