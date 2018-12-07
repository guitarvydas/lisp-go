Run make.

This will build and run the example, which will print "Hello from GO", then fail on NO-APPLICABLE-METHOD when trying to call the function my-log.

The first function, hello, simply calls a GO routine with no arguments.  The GO routine prints a message and returns.  This shows that GO is being successfully called.

The second function, my-log, tries to pass a string (a C struct {pointer-to-string,int-number-of-chars}) to GO, but fails on NO-APPLICABLE-METHOD.


---------

Using CFFI, do I need to specify translation methods when performing call-by-value to C?

I am assuming (possibly incorrectly?) that cffi:defcstruct will create the translations for a C struct for me, then pass that struct by value to a Go foreign routine.

Specifically, I am trying to call routines in Go from Lisp using a Lisp string.

A Go string is a C struct { pointer-to-string , integer-length-of-string }

Simple test code is in https://github.com/guitarvydas/lisp-go/blob/master/string-example/lisp-client.lisp.

(see function "my-log", run "make" which should build and run the example, causing a NO-APPLICABLE-METHOD-ERROR).


