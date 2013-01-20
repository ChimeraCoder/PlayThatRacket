(module basic-ops typed/racket

   (require "datatypes.rkt") 
   ;(require "datatypes-aux.rkt")

   (require/typed "datatypes-aux.rkt"
                [flatten-phrase (Phrase -> Phrase)]
                [append-phrase (Phrase Phrase -> Phrase)]
                [map-phrase ((Phrase -> Phrase) Phrase  -> Phrase)]
                [semitone-up-f (Phrase -> Phrase)])


  (: semitone-up (note -> note))
  (define (semitone-up nt)
    (note (round (inexact->exact (* (note-pitch nt) 1.05946))) (note-duration nt)))

  (: wholetone-up (note -> note))
  (define (wholetone-up nt)
    ((apply compose `(,semitone-up ,semitone-up)) nt)) ;(note (round (inexact->exact (* (note-pitch nt) 1.05946))) (note-duration nt)))

  (define foo (semitone-up-f (list (note 400 500) (note 300 500))))
 

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

  (: raise-octave (note -> note))
  (define (raise-octave nt)
    (note (* 2 (note-pitch nt)) (note-duration nt)))

  ;;This function is superfluous, but it illustrates racket's type syntax
  (: raise-all-octave ((Listof note) -> (Listof note)))
  (define (raise-all-octave nt-lst)
    (map raise-octave nt-lst))


  (: join-phrases (Phrase Phrase -> Phrase))
  (define (join-phrases phrase1 phrase2)
    (append-phrase phrase1 phrase2))


  (: semitone-down-f (Phrase -> Phrase))
  (define (semitone-down-f nt)
    (if (list? nt)
      (flatten-phrase (map-phrase semitone-down-f nt))
      (list (semitone-down nt))))
      ;;TODO figure out better way so every note isn't wrapped in a list


  (: testfoo (Phrase -> Phrase))
  (define (testfoo nt)
    (semitone-up-f nt))



  ;;TODO catch notes that are too high
  (: ensure-middle-octave (note -> note))
  (define (ensure-middle-octave nt)
    (if (< (note-pitch nt) 260)
      (note (* 10 (note-pitch nt)) (note-duration nt));(ensure-middle-octave (note (* 2 (note-pitch nt)) (note-duration nt)))
      nt))
    
  (: ensure-reasonable-length (note -> note))
  (define (ensure-reasonable-length nt)
    (if (< (note-duration nt) 500)
      (note (note-pitch nt) 50)
      nt))



 (provide (all-defined-out))
 (provide semitone-up-f)
 (provide (all-from-out "datatypes.rkt"))
 (provide (all-from-out "datatypes-aux.rkt")))
