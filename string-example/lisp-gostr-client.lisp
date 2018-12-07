;; usage : sbcl --eval "(asdf:load-system :lisp-client)" --eval "(main nil)"

(in-package :cl-user)

(cffi:define-foreign-library :golib
    (:darwin     "./golib.so")
  (t (:default "golib.so")))

(cffi:defcstruct (go-string :class ty-go-string)
    (str :string)
  (count :int))

(defmethod cffi:translate-into-foreign-memory (lisp-str (ty ty-go-string) foreign-pointer)
    (cffi:with-foreign-slots ( (str count) foreign-pointer (:struct go-string) )
      (setf str lisp-str
	    count (length lisp-str))))

(cffi:defcfun ("Hello" hello) 
    :void)

;; a go string is a C struct, "abc" ---> { "abc", 3 }

(cffi:defcfun ("Log" my-log) ;; uses pass-by-value of struct
    :void
  (str (:struct go-string)))

(defun main (argv)
  (declare (ignore argv))
  (let ((msg "Hello from Lisp"))
    (cffi:load-foreign-library :golib)
    (hello)          ;; shows that Go is successfully called
    (my-log msg))) ;; shows that string passed to Go by-value is not working

