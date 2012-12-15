#lang typed/racket/no-check

(require (planet clements/rsound))
(require "datatypes.rkt")
(require "basic-ops-typed.rkt")
(require "scale.rkt")

(: note->sound (case -> (note -> rsound)
                        (note -> Number rsound)))
;;Given a pitch (in Hz), a duration (in number frames), and volume (between 0 and 1), return an rsound s16vector that can be played with the #'play function
(define (note->sound note [volume 0.1]) ;TODO parameterize volume
 (let* ((pitch (note-pitch note))
        (duration (ms->frames (note-duration note)))
        (sig1
         (network ()
          [a (sine-wave pitch)]
          [out (* volume a)])))

  (signal->rsound duration sig1)))

;;TODO actually time this conversion to see what's correct
;:Right now, we're assuming 1 second is 44100 frames
(: ms->frames (Integer -> Integer))
(define (ms->frames milliseconds)
  (* milliseconds (/ 44100 1000)))

(: play-notes (Listof note -> ))
(define (play-notes notes)
  (play (rs-append* (map note->sound notes))))


;;Play A440 for 44100 frames at .1 of the maximum volume
;(play (rs-append* (list (note->sound 440 44100 )(note->sound 540 44100 .1))))
;(play (rs-append* (list (note->sound (note 440 500)) (note->sound (note 540 500) .1))))

(define chromatic-scale-4th (list C C♯ C# D♭ Db D D♯ D# E♭ Eb E F F♯ F# G♭ Gb G G♯ G# A♭ Ab A A♯ A# B♭ Bb B))

(define chromatic-scale-5th (raise-all-octave chromatic-scale-4th))




;(play-notes (list (note 440 500) (note 540 500)))

;;If you don't sleep, the program will exit before it actually gets a chance to play
(sleep 2000)

(provide (all-defined-out))
