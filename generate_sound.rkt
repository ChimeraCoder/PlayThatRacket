#lang typed/racket/no-check

(require "datatypes.rkt")
(require "basic-ops-typed.rkt")
(require "scale.rkt")
(require "keyshift.rkt")
(require "rsound.rkt")




;;Uncomment one of the following lines to play that particular composition
;;Currently, only one composition can be played at a time
;;TODO implement proper parallel playback

;(play-notes chromatic-scale-5th)
;(play-notes (flatten (list first-phrase rest second-phrase rest third-phrase rest third-phrase rest first-phrase rest second-phrase)))
;(play-notes (flatten (mozart-form first-phrase second-phrase third-phrase)))
;(play-notes (flatten (crazy-mozart-form first-phrase second-phrase third-phrase)))

;(play-notes compiler-as-song)




;;If you don't sleep, the program will exit before it actually gets a chance to play
;;TODO fix this to sleep for the appropriate amount of time automatically
(sleep 2000)

(provide (all-defined-out))
