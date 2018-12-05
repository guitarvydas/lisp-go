;; usage : sbcl --eval "(asdf:load-system :lisp-client)" --eval "(main nil)"

(in-package :cl-user)

(cffi:define-foreign-library :golib
    (:darwin     "/Users/tarvydas/projects/lisp-go/string-example/golib.so")
  (t (:default "golib.so")))

(cffi:defcstruct go-string
  (str :string)
  (count :int))

(cffi:defcfun ("Hello" hello) :void)

(cffi:defcfun ("Log" cheating-log) :void
  (str :string)
  (count :int))

(cffi:defcfun ("Log" my-log) :void
  (str (:struct go-string)))

;; a go string is a C struct, "abc" ---> { "abc", 3 }

(defun main (argv)
  (declare (ignore argv))
  (cffi:load-foreign-library :golib)
  (hello)
  (cheating-log "Hello, cheating, from Lisp" 26)
  (my-log "Hello from Lisp"))

