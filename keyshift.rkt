(module keyshift typed/racket/no-check

   (require "datatypes.rkt")
   (require "scale.rkt")

  (define (transform-notes input func)
    ;;TODO replace with pattern-matchin
    (cond 
      [(note? input) (func input)]
      [(list? input) (map (lambda (in) (transform-notes in func)) input)]));(func input)

  ;:Change the pitch of a note but keep the duration
  (define (change-pitch nt target-note)
    (note (note-pitch target-note) (note-duration nt)))

  (define (replace-A-with-D nts)
   (transform-notes nts (lambda (nt) (if (A? nt)
                                      (note (note-pitch D) (note-duration nt))
                                      nt))))
  
  ;;Table is a list of pairs
  ;;Returns a single function
  (define (compose-functions-from-table table)
    (apply compose (map (lambda (pair) (lambda (nt)
                                   (if ((car pair) nt)
                                     (change-pitch nt (cadr pair))
                                     nt))) table)))

    (define (keyshift-A-to-B nts)
     (transform-notes nts (compose-functions-from-table 
                           (list 
                             (list A?  B)
                             (list B?  C#)
                             (list C#? D#)
                             (list D?  E)
                             (list E?  F5#)
                             (list F#? G5#)
                             (list G#? A5#)))))


(provide (all-defined-out)))

