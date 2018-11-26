(load "~/quicklisp/setup.lisp")

(quicklisp:quickload :cffi)

(cffi:define-foreign-library
    :libgoprog
    (:darwin     "/Users/tarvydas/projects/lisp-go/goprog.so")
					;(:linux      "goprog.so")
  (t (:default "goprog.so")))

(cffi:defcfun ("Hello" hello) :void)

(cffi:defcfun ("Log" my-log) :void
  (msg :string))

(cffi:defcfun ("GoStrlen" go-strlen) :int
  (msg :string))

(cffi:defcfun ("Count0" count-0) :int)

(defun main (argv)
  (declare (ignore argv))
  (cffi:load-foreign-library :libgoprog)
  (format *standard-output* "in lisp~%foreign-library-directories /~a/~%" cffi:*foreign-library-directories*)
  ;(hello)
  ;(my-log "logged from lisp through GO")
  ;(format *standard-output* "length of string counted by Go /~a/~%" (go-strlen "abc"))
  (format *standard-output* "length of constant string counted by Go /~a/~%" (count-0))
  "back to lisp")

(main 0)

