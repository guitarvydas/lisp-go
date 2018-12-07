GOPROGS = goprog.so
C-FILES = c-client.c
C-EXECS = c-client

all : run $(GOPROGS) $(C-EXECS)

%.so : %.go
	go build -o $*.so -buildmode=c-shared $*.go

c-client : $(C-FILES) $(GOPROGS)
	gcc -o c-client c-client.c ./goprog.so

run : $(GOLIBS) $(C-EXECS)
	./c-client
	@echo ""
	sbcl  --eval "(asdf:load-system :lisp-go)" --eval "(main nil)"
