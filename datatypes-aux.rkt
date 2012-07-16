#lang racket
    (define (flatten-phrase phrs)
      (flatten phrs))

    (define (append-phrase phrase1 phrase2)
      (append phrase1 phrase2))

    (define (map-phrase fn phrase)
       (map fn phrase))


    (define-syntax-rule (define/automap (name arg) bodies) 
       (define (name new-arg) 
         (define (old arg) bodies) 
           (if (list? new-arg)  
             (map old new-arg) 
             (old new-arg))))


    (define/automap (mystery x)
      (+ x 1))

    (provide (all-defined-out))
