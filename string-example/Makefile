GO 	= 	go

all: run 

%.so: %.go
	$(GO) build -o $*.so -buildmode=c-shared $*.go

c-client: c-client.c golib.so
	gcc -o c-client c-client.c ./golib.so

LISP=sbcl

run: c-client lisp-gostr-client.lisp
	./c-client
	@echo ""
	CL_SOURCE_REGISTRY=$(shell pwd) $(LISP) \
		--eval "(asdf:load-system :lisp-gostr-client)" --eval "(main nil)"

clean:
	rm golib.so golib.h c-client


