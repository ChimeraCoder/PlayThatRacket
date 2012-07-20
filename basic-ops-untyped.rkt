(module basic-ops racket

    (require "basic-ops-typed.rkt")
    (require (only-in "datatypes-aux.rkt" define/automap))

    

    (define/automap (spatter nt)
      (let ((num-new-notes (/ (note-duration nt) 10)))
       (map (lambda (x) (note (note-pitch nt) (note-duration nt))) (stream->list (in-range num-new-notes)))))

      





 (provide (all-defined-out))

 (provide (all-from-out "basic-ops-typed.rkt")))



