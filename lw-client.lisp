(ql:quickload :cffi)

(cffi:define-foreign-library
    :libgoprog
    (:darwin     "/Users/tarvydas/projects/lisp-go/goprog.so")
					;(:linux      "goprog.so")
  (t (:default "goprog.so")))

;(cffi:use-foreign-library :libgoprog)

(cffi:defcfun ("Hello" hello) :void)

(defun main ()
  (cffi:load-foreign-library :libgoprog)
  (format *standard-output* "in lisp~%foreign-library-directories /~a/~%" cffi:*foreign-library-directories*)
  ;; CFFI vs LW isn't working yet...
  (hello)
  "back in lisp")
