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

(defun main (argv)
  (declare (ignore argv))
  (cffi:load-foreign-library :libgoprog)
  (format *standard-output* "in lisp~%foreign-library-directories /~a/~%" cffi:*foreign-library-directories*)
  ;(hello)
  (my-log "logged from lisp through GO")
  "back to lisp")

(main 0)

