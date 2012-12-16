#lang typed/racket/base

(require "basic-ops-typed.rkt")


;Define each of the notes of the chromatic scale

(define C (note (round (inexact->exact 261.63)) 500))

(define C♯ (note (round (inexact->exact 277.18)) 500))
(define C# (note (round (inexact->exact 277.18)) 500))
(define D♭ (note (round (inexact->exact 277.18)) 500))
(define Db (note (round (inexact->exact 277.18)) 500))

(define D (note (round (inexact->exact 293.66)) 500))

(define D♯ (note (round (inexact->exact 311.13)) 500))
(define D# (note (round (inexact->exact 311.13)) 500))
(define E♭ (note (round (inexact->exact 311.13)) 500))
(define Eb (note (round (inexact->exact 311.13)) 500))

(define E (note (round (inexact->exact 329.63)) 500))

(define F (note (round (inexact->exact 349.23)) 500))

(define F♯ (note (round (inexact->exact 369.99)) 500))
(define F# (note (round (inexact->exact 369.99)) 500))
(define G♭ (note (round (inexact->exact 369.99)) 500))
(define Gb (note (round (inexact->exact 369.99)) 500))

(define G (note (round (inexact->exact 392.00)) 500))

(define G♯ (note (round (inexact->exact 415.30)) 500))
(define G# (note (round (inexact->exact 415.30)) 500))
(define A♭ (note (round (inexact->exact 415.30)) 500))
(define Ab (note (round (inexact->exact 415.30)) 500))


(define A (note 440 500))

(define A♯ (note (round (inexact->exact 466.16)) 500))
(define A# (note (round (inexact->exact 466.16)) 500))
(define B♭ (note (round (inexact->exact 466.16)) 500))
(define Bb (note (round (inexact->exact 466.16)) 500))

(define B (note (round (inexact->exact 493.88)) 500))

(define A5# (raise-octave A#))

(define B5 (raise-octave B))
(define C5 (raise-octave C))
(define C5♯ (raise-octave C♯))
(define C5# (raise-octave C#))

(define D5 (raise-octave D))
(define D5# (raise-octave D#))

(define E5 (raise-octave E))
(define F5 (raise-octave F))
(define F5♯ (raise-octave F♯))
(define F5# (raise-octave F#))
(define G5# (raise-octave G#))
(define A5 (raise-octave A))
(define G5 (raise-octave G))


(define: (same-pitch? (nt1 : note) (nt2 : note)) : Boolean
  (equal? (note-pitch nt1) (note-pitch nt2)))

;;TODO there's a more mathematically sound way of doing this
;(: A? (note -> Boolean))
(define: (A? (nt : note)) : Boolean
  (let: ([tmp : (Listof note) (list A A5)])
    (ormap (lambda: ([other : note]) (same-pitch? nt other)) tmp)))

(define: (B? (nt : note)) : Boolean
    (ormap (lambda: ([other : note]) (same-pitch? nt other)) (list B B5)))

(define: (C? (nt : note)) : Boolean
    (ormap (lambda: ([other : note]) (same-pitch? nt other)) (list C C5)))

(define: (D? (nt : note)) : Boolean
    (ormap (lambda: ([other : note]) (same-pitch? nt other)) (list D D5)))

(define: (E? (nt : note)) : Boolean
    (ormap (lambda: ([other : note]) (same-pitch? nt other)) (list E E5)))

(define: (F? (nt : note)) : Boolean
    (ormap (lambda: ([other : note]) (same-pitch? nt other)) (list F F5)))

(define: (G? (nt : note)) : Boolean
    (ormap (lambda: ([other : note]) (same-pitch? nt other)) (list G G5)))

(define: (F#? (nt : note)) : Boolean
    (ormap (lambda: ([other : note]) (same-pitch? nt other)) (list F# F5#)))

(define: (C#? (nt : note)) : Boolean
    (ormap (lambda: ([other : note]) (same-pitch? nt other)) (list C# C5#)))

(define: (G#? (nt : note)) : Boolean
    (ormap (lambda: ([other : note]) (same-pitch? nt other)) (list G# G5#)))


(provide (all-defined-out))
