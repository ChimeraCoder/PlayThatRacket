#lang racket

(require (planet clements/rsound))
    (require "datatypes.rkt")

    (define counter/sig
     (network ()
      [counter (+ 1 (prev counter 0))]))
 
;;Given a pitch (in Hz), a duration (in number frames), and volume (between 0 and 1), return an rsound s16vector that can be played with the #'play function
(define (create-sound note [volume 0.1]) ;TODO parameterize volume
 (let* ((pitch (note-pitch note))
        (duration (ms->frames (note-duration note)))
        (sig1
        (network ()
         [a (sine-wave pitch)]
         [out (* volume a)])))

  (signal->rsound duration sig1)))


;;TODO actually time this conversion to see what's correct
;:Right now, we're assuming 1 second is 44100 frames
(define (ms->frames milliseconds)
  (* milliseconds (/ 44100 1000)))

(define (note->signal note [volume 0.1])
 (let* ((pitch (note-pitch note))
       (duration (ms->frames (note-duration note)))
       (sig1
        (network ()
         [a (sine-wave pitch)]
         [out (* volume a)])))
  (signal->rsound duration sig1)))

;;Play A440 for 44100 frames at .1 of the maximum volume
;(play (rs-append* (list (create-sound 440 44100 )(create-sound 540 44100 .1))))
(play (rs-append* (list (create-sound (note 440 500)) (create-sound (note 540 500) .1))))

;;If you don't sleep, the program will exit before it actually gets a chance to play
(sleep 200)
