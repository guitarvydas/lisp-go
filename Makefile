GO 	= 	go

all: run 

%.so: %.go
	$(GO) build -o $*.so -buildmode=c-shared $*.go

c-client: c-client.c goprog.so
	gcc -o c-client c-client.c ./goprog.so

LISP=sbcl

run: c-client lisp-client.lisp
	./c-client
	@echo ""
	CL_SOURCE_REGISTRY=$(shell pwd) $(LISP) \
		--eval "(asdf:load-system :lisp-go)" --eval "(main nil)"

clean:
	rm goprog.so goprog.h c-client

