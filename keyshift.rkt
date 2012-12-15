(module keyshift typed/racket/no-check

   (require "datatypes.rkt")
   (require "scale.rkt")

  (define (transform-notes input func)
    ;;TODO replace with pattern-matchin
    (cond 
      [(note? input) (func input)]
      [(list? input) (map (lambda (in) (transform-notes in func)) input)]));(func input)

  ;;Funcs is a list of functions that will be composed in order
  (define (layer-transformations input funcs)
    (


  ;:Change the pitch of a note but keep the duration
  (define (change-pitch nt target-note)
    (note (note-pitch target-note) (note-duration nt)))

  (define (replace-A-with-D nts)
   (transform-notes nts (lambda (nt) (if (A? nt)
                                      (note (note-pitch D) (note-duration nt))
                                      nt))))



  (define (keyshift-C-to-D nts)
    (transform-notes nts (lambda (nt)

(provide (all-defined-out))

