;; usage : sbcl --load "sbcl-client" --eval "(main 0)"


(load "~/quicklisp/setup.lisp")

(quicklisp:quickload :cffi)

(cffi:define-foreign-library
    :libgoprog
    (:darwin     "/Users/tarvydas/projects/lisp-go/goprog.so")
					;(:linux      "goprog.so")
  (t (:default "goprog.so")))

(cffi:defcfun ("Hello" hello) :void)

;; (cffi:defcfun ("Log" my-log) :void
;;  (msg :string))

;; (cffi:defcfun ("GoStrlen" go-strlen) :int
;;  (msg :string))

;; (cffi:defcfun ("Count0" count-0) :int)

;; (cffi:defcfun ("Count01" count-01) :int)

;; (cffi:defcfun ("Count1" count-1) :int
;;  (str :string))

;; a go string is a C struct, "abc" ---> { "abc", 3 }

(cffi:defcfun ("Add" go-add) :int
  (a :int)
  (b :int))

(cffi:defcfun ("Cosine" go-cosine) :double
  (a :double))

(defun main (argv)
  (declare (ignore argv))
  (cffi:load-foreign-library :libgoprog)
  (format *standard-output* "~%(ignore Undefined alien warnings above)~%~%in lisp~%foreign-library-directories /~a/~%" cffi:*foreign-library-directories*)
  (hello)

  ;; lisp strings --> Go --> Lisp is still a problem
  
  ;(my-log "logged from lisp through GO")
  ;(format *standard-output* "length of string counted by Go /~a/~%" (go-strlen "abc"))
  ; (let ((msg (lisp-string-as-c-struct "abc")))
  ;  (format *standard-output* "length of lisp string counted by Go /~a/~%" (count-1 msg)))\

  (let* ((a 222)
	 (b 333)
	 (c (go-add a b)))
    (format *standard-output* "go-add (~a ~a) returns ~a~%" a b c))

  (let* ((f 0.1d0)
	 (c (go-cosine f)))
    (format *standard-output* "go-cosine (~a) returns ~a ~a~%" f (type-of c) c))

  (format *standard-output* "~%back to lisp"))


