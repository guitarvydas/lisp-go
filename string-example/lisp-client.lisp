;; usage : sbcl --eval "(asdf:load-system :lisp-client)" --eval "(main nil)"

(in-package :cl-user)

(cffi:define-foreign-library :libgolib
    (:darwin     "/Users/tarvydas/projects/lisp-go/string-example/golib.so")
  (t (:default "golib.so")))

(cffi:defcstruct go-string
  (str :string)
  (count :int))

(cffi:defcfun ("Hello" hello) :void)

;; a go string is a C struct, "abc" ---> { "abc", 3 }

(defun main (argv)
  (declare (ignore argv))
  (cffi:load-foreign-library :libgolib)
  (hello))

