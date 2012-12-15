#lang racket

(require (planet clements/rsound))


    (define counter/sig
     (network ()
      [counter (+ 1 (prev counter 0))]))
 
;;Given a pitch (in Hz), a duration (in number frames), and volume (between 0 and 1), return an rsound s16vector that can be played with the #'play function
(define (create-sound pitch duration volume)
 (let ((sig1
        (network ()
         [a (sine-wave pitch)]
         [out (* volume a)])))

  (signal->rsound duration sig1)))


(play (create-sound 440 44100 .1))

;;If you don't sleep, the program will exit before it actually gets a chance to play
(sleep 200)

#|
    (define vibrato-tone
     (network ()
      [lfo (sine-wave 2)]
      [sin (sine-wave (+ 440 (* 1 lfo)))]
      [out (* 0.1 sin)]))

    (signal-play vibrato-tone)
    (sleep 5)

(stop)
;(play ding) 
|#

#|
This is the example given in the rsound documentation
http://planet.racket-lang.org/package-source/clements/rsound.plt/4/4/planet-docs/rsound/index.html#(part._.Frequency_.Response)
(define sig1
  (network ()
           [a (sine-wave 440)]
           [out (* 0.1 a)]))
(define r (signal->rsound 44100 sig1))

(play r)

(sleep 200)
|#

