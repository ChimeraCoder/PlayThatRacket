#lang racket
    (define (flatten-phrase phrs)
      (flatten phrs))

    (define (append-phrase phrase1 phrase2)
      (append phrase1 phrase2))

    (define (map-phrase fn phrase)
       (map fn phrase))

    (provide (all-defined-out))
