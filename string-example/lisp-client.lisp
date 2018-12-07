;; usage : sbcl --eval "(asdf:load-system :lisp-client)" --eval "(main nil)"

(in-package :cl-user)

(cffi:define-foreign-library :golib
    (:darwin     "./golib.so")
  (t (:default "golib.so")))

(defstruct ty-go-string
  (str


   to-foreign
(cffi:with-foreign-string 
(cffi:defcstruct (go-string :class ty-go-string)
  (str :string)
  (count :int))

(cffi:defcfun ("Hello" hello) 
    :void)

;; a go string is a C struct, "abc" ---> { "abc", 3 }

(cffi:defcfun ("Log" cheating-log) ;; uses pass-by-ref only
    :void
  (str :string)
  (count :int))

(cffi:defcfun ("Log" my-log) ;; uses pass-by-value of struct
    :void
  (str (:struct go-string)))

(defun main (argv)
  (declare (ignore argv))
  (let ((msg1 "Hello, cheating, from Lisp")
	(msg2 "Hello,         , from Lisp"))
    (let ((len1 (length msg1)))
      (cffi:load-foreign-library :golib)
      (hello)
      (cheating-log msg1 len1)
      (my-log msg2))))

