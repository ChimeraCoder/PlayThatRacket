#lang racket/base

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


(define C5 (raise-octave C))
(define C5♯ (raise-octave C♯))
(define C5# (raise-octave C#))

(define D5 (raise-octave D))
(define D5# (raise-octave D#))

(define E5 (raise-octave E))
(define F5♯ (raise-octave F♯))
(define F5# (raise-octave F#))
(define A5 (raise-octave A))

;;TODO there's a more mathematically sound way of doing this
(define (A? note)
  (ormap (lambda (x) (equal? (note-pitch note) (note-pitch x))) (list A A5)))

(define (B? note)
  (ormap (lambda (x) (equal? (note-pitch note) (note-pitch x))) (list B B5)))

(define (C? note)
  (ormap (lambda (x) (equal? (note-pitch note) (note-pitch x))) (list C C5)))

(define (D? note)
  (ormap (lambda (x) (equal? (note-pitch note) (note-pitch x))) (list D D5)))

(define (E? note)
  (ormap (lambda (x) (equal? (note-pitch note) (note-pitch x))) (list E E5)))

(define (F? note)
  (ormap (lambda (x) (equal? (note-pitch note) (note-pitch x))) (list F F5)))

(define (F#? note)
  (ormap (lambda (x) (equal? (note-pitch note) (note-pitch x))) (list F# F#5)))

(define (C#? note)
  (ormap (lambda (x) (equal? (note-pitch note) (note-pitch x))) (list C# C#5)))

(provide (all-defined-out))
