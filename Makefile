
compile:
	raco make datatypes.rkt

clean:
	rm -rf "compiled/" "*.swp"

test:
	racket datatypes-test.rkt
