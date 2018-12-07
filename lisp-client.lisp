;; usage : sbcl --load "sbcl-client" --eval "(main 0)"

(cffi:defcstruct go-string
  (str :string)
  (count :int))

(cffi:defcfun ("Hello" hello) :void)

(cffi:defcfun ("Log" my-log) :void
  (msg (:struct go-string)))

;; a go string is a C struct, "abc" ---> { "abc", 3 }

(cffi:defcfun ("Add" go-add) :int
  (a :int)
  (b :int))

(cffi:defcfun ("Cosine" go-cosine) :double
  (a :double))

(defun poke-str (lisp-str ty go-str-pointer)
  (cffi:with-foreign-slots ((str count) go-str-pointer ty)
	(setf str lisp-str
	      count (length lisp-str))
      go-str-pointer))

(defun create-go-string (lisp-str)
  "make a Go string from lisp-str, return cffi address of the Go string"
  (let ((go-str-pointer (cffi:foreign-alloc '(:struct go-string))))
    (poke-str lisp-str '(:struct go-string) go-str-pointer)))

(defun string-part (go-str)
  "return the Lisp string associated with the Go string"
  (let ((ty '(:struct go-string)))
    (cffi:foreign-slot-value go-str ty 'str)))

(defun count-part (go-str)
  "return the Lisp number associated with the length of the Go string"
  (let ((ty '(:struct go-string)))
    (cffi:foreign-slot-value go-str ty 'count)))  

(defun go-string-to-lisp (go-str)
  "lispify given Go string and return 2 values - the string and its count"
  (values
   (string-part go-str)
   (count-part go-str)))
  
(defun free-go-string (go-str)
  ;; kill the Go string
  (cffi:foreign-string-free (string-part go-str))
  (cffi:foreign-free go-str))

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

  (let ((gstr (create-go-string "abc from lisp")))
    (my-log gstr) ;; no trick
    #+nil(my-log (string-part gstr) (count-part gstr)) ;; trick (not lw)
    ;; need to deallocate!
    )
  
  (format *standard-output* "~%back to lisp~%"))

