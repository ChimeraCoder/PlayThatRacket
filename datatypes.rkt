(module datatypes typed/racket

  (require racket/stream)
 
  (struct: note ([pitch : Integer] [duration : Integer]) #:transparent)
  ;;(define-type Note (Rec NT (U note (Pair NT NT))))
  
  ;;A phrase is a list of notes of arbitrary length
  (define-type Phrase (Rec NT (U note (Listof NT))))


  (require/typed "datatypes-aux.rkt"
                [flatten-phrase (Phrase -> Phrase)]
                [append-phrase (Phrase Phrase -> Phrase)]
                [map-phrase ((Phrase -> Phrase) Phrase  -> Phrase)])



  (: raise-octave (note -> note))
  (define (raise-octave nt)
    (note (* 2 (note-pitch nt)) (note-duration nt)))

  ;;This function is superfluous, but it illustrates racket's type syntax
  (: raise-all-octave ((Listof note) -> (Listof note)))
  (define (raise-all-octave nt-lst)
    (map raise-octave nt-lst))


  (struct: time-signature ([beats    : Integer]  ;;How many beats per measure                            
                           [one-note : Integer])) ;;The note that represents a single beat

  (define *time-signature* (make-parameter (time-signature 4 4)))


  (struct: Tempo ([milliseconds-per-beat : Integer]))

  (: semitone-up (note -> note))
  (define (semitone-up nt)
    (note (round (inexact->exact (* (note-pitch nt) 1.05946))) (note-duration nt)))

  (: semitone-down (note -> note))
  (define (semitone-down nt)
    (note (round (inexact->exact (/ (note-pitch nt) 1.05946))) (note-duration nt)))
  
  (: tempo-in-bpm (Integer -> Tempo))
  (define (tempo-in-bpm beats-per-minute)
    (Tempo (round (inexact->exact (* (/ beats-per-minute 60) 1000)))))
  
  (: tempo-in-mspb (Integer -> Tempo))
  (define (tempo-in-mspb milliseconds-per-beat)
    (Tempo milliseconds-per-beat))

  (define *tempo* (make-parameter (tempo-in-mspb 500)))

#|
  ;TODO add optional parameter for defining the second note
  (define (trill nt)
    (if (not (list? nt))
      (let ((num-new-notes (/ (note-duration nt) 10))
            (other-pitch  (note-pitch (semitone-down nt))))
        (let* ((zipped-stream (stream-add-between (stream-of-original-notes) (Note other-pitch 10)))
               (notes-lst (stream-take num-new-notes zipped-stream))
               (remainder-note (Note (note-pitch nt) (remainder (note-duration nt) 10))))
           (append notes-lst '(remainder-note))))
      (map trill nt)))
 |#

;;A measure (a list of notes with a predefined length) can be defined using macros

  (: join-phrases (Phrase Phrase -> Phrase))
  (define (join-phrases phrase1 phrase2)
    (append-phrase phrase1 phrase2))


  (: semitone-down-f (Phrase -> Phrase))
  (define (semitone-down-f nt)
    (if (list? nt)
      (flatten-phrase (map-phrase semitone-down-f nt))
      (list (semitone-down nt))))
      ;;TODO figure out better way so every note isn't wrapped in a list
 
    
  (: semitone-up-f (Phrase -> Phrase))
  (define (semitone-up-f nt)
    (if (list? nt)
      (flatten-phrase (map-phrase semitone-up-f nt))
      (list (semitone-up nt))))
      ;;TODO figure out better way so every note isn't wrapped in a list


    (define-syntax-rule (define/automap (name arg) bodies) 
      (define (name new-arg)    
        (define (old arg) bodies) 
          (if (note? new-arg)  
            (old new-arg)
            (map old new-arg))))
;;
;;    (: mystery (Phrase -> Phrase))
;;    (define/automap (mystery x)
;;      (semitone-down x))


;;  ;(: automap (note -> note) -> (Phrase -> Phrase))
;;  (define-syntax (automap func)
;;    (: func (note -> note) -> (Phrase -> Phrase))
;;    (define (func nt)
;;      (if (list? nt)
;;        (flatten-phrase (map-phrase func nt))
;;        (list (func nt)))))
;;    


(provide (all-defined-out)))
