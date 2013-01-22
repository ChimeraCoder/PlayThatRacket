#lang typed/racket/no-check

(require "datatypes.rkt")
(require (planet clements/rsound))







(: note->sound (case -> (note -> rsound)
                        (note -> Number rsound)))

;;Given a pitch (in Hz), a duration (in number frames), and volume (between 0 and 1), return an rsound s16vector that can be played with the #'play function
(define (note->sound note [volume 0.3]) ;TODO parameterize volume
 (let* ((pitch (note-pitch note))
        (duration (ms->frames (note-duration note)))
        (sig1
         (network ()
          [a (sine-wave pitch)]
          [out (* volume a)])))

  (signal->rsound duration sig1)))


;;Convert a note directly into an rsound, without processing as a signal first
(define (note->tone note [volume 0.1])
  (make-tone (note-pitch note ) volume (ms->frames (note-duration note))))

;;TODO actually time this conversion to see what's correct
;:Right now, we're assuming 1 second is 44100 frames
(: ms->frames (Integer -> Integer))
(define (ms->frames milliseconds)
  (truncate (* milliseconds (/ 44100 1000))))

(: play-notes (Listof note -> ))
(define (play-notes notes)
  (play (rs-append* (map note->sound notes))))

(define (lengthen-note n factor)
  (note (note-pitch n) (* factor (note-duration n))))





(provide (all-defined-out))
