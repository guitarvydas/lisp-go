;; usage : sbcl --eval "(asdf:load-system :lisp-client)" --eval "(main nil)"

(in-package :cl-user)

(cffi:define-foreign-library :golib
    (:darwin     "./golib.so")
  (t (:default "golib.so")))

(cffi:defcstruct go-string
    (str :string)
  (count :int))

(cffi:defcfun ("Hello" hello) 
    :void)

;; a go string is a C struct, "abc" ---> { "abc", 3 }

(cffi:defcfun ("Log" my-log) ;; uses pass-by-value of struct
    :void
  (str (:struct go-string)))

(defun main (argv)
  (declare (ignore argv))
  (let ((msg "Hello, ........, from Lisp"))
    (cffi:load-foreign-library :golib)
    (hello)          ;; shows that Go is successfully called
    (my-log msg))) ;; shows that string passed to Go by-value is not working

