#lang racket

(require "rsound.rkt")
(require "basic-ops-typed.rkt")
(require "scale.rkt")
(require "keyshift.rkt")

;;Musicians, like programmers, love abstraction!

;;The song "Twinkle Twinkle, Little Star" has a common structure,
;;and we might want to use that structure later to compose other songs too.
(define (mozart-form a b c)
  (list a rest b rest c rest c rest a rest b))

;;Define each of the three phrases in "Twinkle Twinkle, Little Star"
(define first-phrase (list A A E5 E5 F5♯ F5♯ E5))
(define second-phrase (list D5 D5 C5♯ C5♯ B B A))
(define third-phrase (list E5 E5 D5 D5 C5♯ C5♯ B))
(define rest (list silence)) ;;temporary hack

(define twinkle-twinkle-little-star (mozart-form first-phrase second-phrase third-phrase))

(play-notes (flatten twinkle-twinkle-little-star))
(sleep 2000)

(provide (all-defined-out))
