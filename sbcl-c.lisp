(load "~/quicklisp/setup.lisp")
(ql:quickload :cffi)

(cffi:defcfun "strlen" :int
  (n :string))

(defun main (argv)
  (declare (ignore argv))
  (strlen "123"))  ;; straight from cffi manual
