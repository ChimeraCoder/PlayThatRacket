#lang typed/racket/no-check

(require "datatypes.rkt")
(require "basic-ops-typed.rkt")
(require "scale.rkt")
(require "keyshift.rkt")
(require "rsound.rkt")

(require "translate_code.rkt")

(require compiler/decompile)
(require compiler/zo-parse)

;;Here's how we would write the chromatic scale 
;;Define two chromatic scales (each note is played once for each of its 'aliases')
(define chromatic-scale-4th (list C C♯ C# D♭ Db D D♯ D# E♭ Eb E F F♯ F# G♭ Gb G G♯ G# A♭ Ab A A♯ A# B♭ Bb B))
;;Defining the scale in another octave is easy!
(define chromatic-scale-5th (raise-all-octave chromatic-scale-4th))


;;Musicians, like programmers, love abstraction!

;;The song "Twinkle Twinkle, Little Star" has a common structure,
;;and we might want to use that structure later to compose other songs too.
(define (mozart-form a b c)
  (list a rest b rest c rest c rest a rest b))

;;Define each of the three phrases in "Twinkle Twinkle, Little Star"
(define first-phrase (list A A E5 E5 F5♯ F5♯ E5))
(define second-phrase (list D5 D5 C5♯ C5♯ B B A))
(define third-phrase (list E5 E5 D5 D5 C5♯ C5♯ B))
(define rest (list (note 0 500))) ;;temporary hack

(define twinkle-twinkle-little-star (mozart-form first-phrase second-phrase third-phrase))



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


;;Obligatory: Every Lisp dialect needs to be able to compile itself
;;This Lisp dialect can also _decompile_ itself and play its own compiler as a song

;;Decompile a racket binary into s-expressions
(define fin (open-input-file "compiled/datatypes_rkt.zo" #:mode 'binary))
(define bytecode (zo-parse fin))
(define source (decompile bytecode))
;;Translate the source code into a song
(define compiler-as-song (flatten (make-notes (translate (take (cadr source) 20)))))


;;Uncomment one of the following lines to play that particular composition
;;Currently, only one composition can be played at a time
;;TODO implement proper parallel playback

(play-notes chromatic-scale-4th)
;(play-notes chromatic-scale-5th)
;(play-notes (flatten (list first-phrase rest second-phrase rest third-phrase rest third-phrase rest first-phrase rest second-phrase)))
;(play-notes (flatten (mozart-form first-phrase second-phrase third-phrase)))
;(play-notes (flatten (crazy-mozart-form first-phrase second-phrase third-phrase)))

;(play-notes compiler-as-song)




;;If you don't sleep, the program will exit before it actually gets a chance to play
;;TODO fix this to sleep for the appropriate amount of time automatically
(sleep 2000)

(provide (all-defined-out))
