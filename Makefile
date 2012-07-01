
compile:
	raco make datatypes.rkt

clean:
	rm -rf "compiled/" "*.swp"

test:
	racket tests/datatypes-test.rkt -I typed/racket
