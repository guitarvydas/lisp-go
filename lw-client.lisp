(in-package :cl-user)

(cffi:defcfun ("Hello" hello) :void)

(defun lw-main ()
  (cffi:load-foreign-library :libgoprog)
  (format *standard-output* "in lisp~%foreign-library-directories /~a/~%" cffi:*foreign-library-directories*)
  ;; CFFI vs LW isn't working yet...
  (hello)
  "back in lisp")
