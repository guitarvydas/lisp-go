Run make.

This will build and run the example, which will print "Hello from GO", then fail on NO-APPLICABLE-METHOD when trying to call the function my-log.

The first function, hello, simply calls a GO routine with no arguments.  The GO routine prints a message and returns.  This shows that GO is being successfully called.

The second function, my-log, tries to pass a string (a C struct {pointer-to-string,int-number-of-chars}) to GO, but fails on NO-APPLICABLE-METHOD.
