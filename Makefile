EMACS ?= emacs
CASK ?= cask

all: test

test: clean
	${MAKE} integration
	${MAKE} compile
	${MAKE} integration
	${MAKE} clean

integration:
	${CASK} exec ecukes --no-win

compile:
	${CASK} exec ${EMACS} -Q -batch -f batch-byte-compile checkbox.el

clean:
	rm -f checkbox.elc

.PHONY:	all test integration
