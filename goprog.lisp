(in-package :cl-user)

(cffi:define-foreign-library :libgoprog
  (:darwin     "/Users/tarvydas/projects/lisp-go/goprog.so")
  (:freebsd    "~/work/lisp-go/goprog.so")
					;(:linux      "goprog.so")
  (t (:default "goprog.so")))

