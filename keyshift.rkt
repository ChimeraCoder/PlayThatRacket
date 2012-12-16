(module keyshift typed/racket/no-check

   (require "datatypes.rkt")
   (require "basic-ops-untyped.rkt")
   (require "scale.rkt")

  (: transform-notes (Phrase -> (Phrase -> Phrase) -> Phrase))
  (define (transform-notes input func)
    ;;TODO replace with pattern-matchin
    (cond 
      [(note? input) (func input)]
      [(list? input) (map (lambda (in) (transform-notes in func)) input)]));(func input)

  ;:Change the pitch of a note but keep the duration
  (: change-pitch (note -> note -> note))
  (define (change-pitch nt target-note)
    (note (note-pitch target-note) (note-duration nt)))

  (: replace-A-with-D (Phrase -> Phrase))
  (define (replace-A-with-D nts)
   (transform-notes nts (lambda: ([nt : Phrase]) (if (A? nt)
                                      (note (note-pitch D) (note-duration nt))
                                      nt))))
  
  ;;Table is a list of pairs
  ;;Returns a single function
  (define (compose-functions-from-table table)
    (apply compose1 (map (lambda: ([pair : (Pairof (note -> Boolean) (note -> note))]) 
                            (lambda: ([nt : note])
                                   (if ((car pair) nt) ;;If the first function is true
                                     ((cadr pair) nt) ;;then apply the second fnction
                                     nt))) ;;otherwise return the note unchanged
                                     table)))

    (define (keyshift-A-to-B nts)
     (transform-notes nts (compose-functions-from-table 
                           (list 
                             (list A?  wholetone-up)
                             (list B?  wholetone-up)
                             (list C#? wholetone-up)
                             (list D?  wholetone-up)
                             (list E?  wholetone-up)
                             (list F#? wholetone-up)
                             (list G#? wholetone-up)))))

     (define (keyshift-A-to-D nts)
      (transform-notes nts (compose-functions-from-table 
                            (list 
                             (list A?  (compose1 wholetone-up wholetone-up semitone-up))
                             (list B?  (compose1 wholetone-up wholetone-up semitone-up))
                             (list C#? (compose1 wholetone-up wholetone-up semitone-up))
                             (list D?  (compose1 wholetone-up wholetone-up semitone-up))
                             (list E?  (compose1 wholetone-up wholetone-up semitone-up))
                             (list F#? (compose1 wholetone-up wholetone-up semitone-up))
                             (list G#? (compose1 wholetone-up wholetone-up semitone-up))))))



(provide (all-defined-out)))

