GOPROGS = golib.so
C-FILES = c-client.c
C-EXECS = c-client

all : run $(GOLIBS) $(C-EXECS)

%.so : %.go
	go build -o $*.so -buildmode=c-shared $*.go

c-client : $(C-FILES) $(GOLIBS)
	gcc -o c-client c-client.c ./golib.so

run : $(GOLIBS) $(C-EXECS)
	./c-client
