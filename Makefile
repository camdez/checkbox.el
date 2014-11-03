EMACS ?= emacs
CASK ?= cask

all: test

test: clean
	${MAKE} integration
	${MAKE} unit
	${MAKE} compile
	${MAKE} integration
	${MAKE} unit
	${MAKE} clean

integration:
	${CASK} exec ecukes --no-win

unit:
	${CASK} exec ert-runner

compile:
	${CASK} exec ${EMACS} -Q -batch -f batch-byte-compile checkbox.el

clean:
	rm -f checkbox.elc

.PHONY:	all test integration unit
