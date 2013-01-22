#lang racket


(require "../basic-ops-typed.rkt")
(require "../scale.rkt")
(require "../keyshift.rkt")
(require "../rsound.rkt")


;;Here's how we would write the chromatic scale 
;;Define two chromatic scales (each note is played once for each of its 'aliases')
(define chromatic-scale-4th (list C C♯ C# D♭ Db D D♯ D# E♭ Eb E F F♯ F# G♭ Gb G G♯ G# A♭ Ab A A♯ A# B♭ Bb B))
;;Defining the scale in another octave is easy!
(define chromatic-scale-5th (raise-all-octave chromatic-scale-4th))


(play-notes chromatic-scale-4th)



(sleep 2000)
(provide (all-defined-out))
