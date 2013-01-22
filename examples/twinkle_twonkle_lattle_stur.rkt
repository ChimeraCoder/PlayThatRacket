#lang racket

(require "../rsound.rkt")
(require "../basic-ops-typed.rkt")
(require "../scale.rkt")
(require "../keyshift.rkt")


;;A lot of modern and/or experimental music mixes both fixed components and components that are defined at 'performance-time' by the performer and/or audience.
;;No two performances are the same!

;;Let's define a partially random composition
;;It follows the same structure as 'Twinkle Twinkle, Little Star'
;;but has some twists that will only be defined at runtime.
(define (random-element lst)
  (list-ref lst (random (length lst))))

(define crazy-functions (list keyshift-A-to-D
                              keyshift-A-to-B
                              raise-all-octave))

(define (scramble phrase)
   ((random-element crazy-functions) phrase))

(define (crazy-mozart-form a b c)
  (map scramble (list (keyshift-A-to-D a) rest ((random-element crazy-functions) b) rest c rest c rest a rest b)))

;;Now, crazy-mozart-form _is itself a composition_ 

;;Define each of the three phrases in "Twinkle Twinkle, Little Star"
(define first-phrase (list A A E5 E5 F5♯ F5♯ E5))
(define second-phrase (list D5 D5 C5♯ C5♯ B B A))
(define third-phrase (list E5 E5 D5 D5 C5♯ C5♯ B))
(define rest (list silence)) ;;temporary hack


(play-notes (flatten (crazy-mozart-form first-phrase second-phrase third-phrase)))

(sleep 2000)

(provide (all-defined-out))
