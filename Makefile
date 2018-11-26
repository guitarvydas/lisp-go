GOPROGS = goprog.so
C-FILES = c-client.c
C-EXECS = c-client

all : $(GOPROGS) $(C-EXECS)

%.so : %.go
	go build -o $*.so -buildmode=c-shared $*.go

c-client : $(C-FILES) $(GOPROGS)
	gcc -o c-client c-client.c ./goprog.so
