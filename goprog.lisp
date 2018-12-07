(in-package :cl-user)

(cffi:define-foreign-library :libgoprog
  (:darwin     "./goprog.so")
  (:freebsd    "~/work/lisp-go/goprog.so")
					;(:linux      "goprog.so")
  (t (:default "goprog.so")))

