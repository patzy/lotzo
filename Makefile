LISP=/usr/bin/clisp -norc -on-error debug --quiet -i build.lisp -x 


all: lotzo

lotzo:
	$(LISP) "(make-lotzo)"

run:
	$(LISP) "(run)"

load:
	$(LISP)

clean:
	$(LISP) "(clean-all)"