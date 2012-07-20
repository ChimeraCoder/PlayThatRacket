
compile:
	raco make datatypes.rkt

clean:
	rm -rf "compiled/" "*.swp"

test:
	racket tests/*-test.rkt -I typed/racket
