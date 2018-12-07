;; usage : sbcl --load "sbcl-client" --eval "(main 0)"

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

(cffi:defcfun ("Hello" hello) :void)

(cffi:defcfun ("Log" my-log) ;; uses pass-by-value of struct
    :void
  (str (:struct go-string)))

;; a go string is a C struct, "abc" ---> { "abc", 3 }

(cffi:defcfun ("Add" go-add) :int
  (a :int)
  (b :int))

(cffi:defcfun ("Cosine" go-cosine) :double
  (a :double))

(defun main (argv)
  (declare (ignore argv))
  (cffi:load-foreign-library :libgoprog)
  (hello)

  ;; lisp strings --> Go --> Lisp is still a problem
  
  (let* ((a 222)
	 (b 333)
	 (c (go-add a b)))
    (format *standard-output* "go-add (~a ~a) returns ~a~%" a b c))

  (let* ((f 0.1d0)
	 (c (go-cosine f)))
    (format *standard-output* "go-cosine (~a) returns ~a ~a~%" f (type-of c) c))

  (let ((msg "abc from lisp"))
    (my-log msg)
    ;; need to deallocate?
    )
  
  (format *standard-output* "~%back to lisp~%"))


