#lang typed/racket/no-check

(require (planet clements/rsound))
(require "datatypes.rkt")
(require "basic-ops-typed.rkt")
(require "scale.rkt")
(require "keyshift.rkt")

(require "translate_code.rkt")

(require compiler/decompile)
(require compiler/zo-parse)


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


(define (random-element lst)
  (list-ref lst (random (length lst))))

(define crazy-functions (list keyshift-A-to-D
                              keyshift-A-to-B
                              raise-all-octave))

(define (scramble phrase)
   ((random-element crazy-functions) phrase))

(define (crazy-mozart-form a b c)
  (map scramble (list (keyshift-A-to-D a) rest ((random-element crazy-functions) b) rest c rest c rest a rest b)))








(define chromatic-scale-4th (list C C♯ C# D♭ Db D D♯ D# E♭ Eb E F F♯ F# G♭ Gb G G♯ G# A♭ Ab A A♯ A# B♭ Bb B))

(define chromatic-scale-5th (raise-all-octave chromatic-scale-4th))

(define first-phrase (list A A E5 E5 F5♯ F5♯ E5))
(define second-phrase (list D5 D5 C5♯ C5♯ B B A))
(define third-phrase (list E5 E5 D5 D5 C5♯ C5♯ B))
(define rest (list (note 0 500))) ;;temporary hack

(define (mozart-form a b c)
  (list a rest b rest c rest c rest a rest b))


;(play-notes chromatic-scale-4th)
;(play-notes chromatic-scale-5th)
;(play-notes (flatten (list first-phrase rest second-phrase rest third-phrase rest third-phrase rest first-phrase rest second-phrase)))
;(play-notes (flatten (mozart-form first-phrase second-phrase third-phrase)))


;(play-notes (flatten (crazy-mozart-form first-phrase second-phrase third-phrase)))

(define (lengthen-note n factor)
  (note (note-pitch n) (* factor (note-duration n))))


(define fin (open-input-file "compiled/datatypes_rkt.zo" #:mode 'binary))

(define bytecode (zo-parse fin))

(define source (decompile bytecode))
(display (length (cadr source)))
(define song (flatten (make-notes (translate (take (cadr source) 20)))))
(display song)
(play-notes song)

;(play-notes (list (note 440 500) (note 540 500)))

;;If you don't sleep, the program will exit before it actually gets a chance to play
(sleep 2000)

(provide (all-defined-out))
