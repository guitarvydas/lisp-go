(ql:quickload :cffi)

(cffi:defcstruct go-string
  (str :string)
  (count :int))

(defparameter *pstr* nil)

(defun tester ()
  "various tries / reminders about cffi api"
  (setf *pstr* (cffi:foreign-alloc '(:struct go-string)))
  (let* ((lisp-msg "abc")
         (msg (cffi:foreign-string-alloc lisp-msg)) ;; convert "abc" from lisp to foreign string, msg is a foreign-address
         (str-offset (cffi:foreign-slot-offset '(:struct go-string) 'str))
         (count-offset (cffi:foreign-slot-offset '(:struct go-string) 'count)))
    (format *standard-output* "go-string size is ~A str at +~a count at +~a~%"  ;; sanity check offsets, str should be at 0, count should be +ve
            (cffi:foreign-type-size '(:struct go-string))
            str-offset
            count-offset)
    (setf (cffi:foreign-slot-value *pstr* '(:struct go-string) 'str) msg)
    (setf (cffi:foreign-slot-value *pstr* '(:struct go-string) 'count) (length lisp-msg))
    (values
     (cffi:foreign-slot-value *pstr* '(:struct go-string) 'str) ;; return Lisp string in *pstr*->str
     (cffi:foreign-slot-value *pstr* '(:struct go-string) 'count)) ;; return Lisp number in *pstr*->count
    #+nil(cffi:foreign-string-free msg))  ;; string must be deallocated before freeing *pstr*
  #+nil(cffi:foreign-free *pstr*)) ;; deallocation of *pstr*

(defun test2 ()
  (setf *pstr* (cffi:foreign-alloc '(:struct go-string)))
  (let* ((lisp-msg "abc")
         (msg (cffi:foreign-string-alloc lisp-msg))) ;; convert "abc" from lisp to foreign string, msg is a foreign-address
    (setf (cffi:foreign-slot-value *pstr* '(:struct go-string) 'str) msg)
    (setf (cffi:foreign-slot-value *pstr* '(:struct go-string) 'count) (length lisp-msg))
    (values
     (cffi:foreign-slot-value *pstr* '(:struct go-string) 'str) ;; return Lisp string in *pstr*->str
     (cffi:foreign-slot-value *pstr* '(:struct go-string) 'count)) ;; return Lisp number in *pstr*->count
    #+nil(cffi:foreign-string-free msg))  ;; string must be deallocated before freeing *pstr*
  #+nil(cffi:foreign-free *pstr*)) ;; deallocation of *pstr*

(defun create-go-string (lisp-str)
  "make a Go string from lisp-str, return cffi address of the Go string"
  (let ((ty '(:struct go-string)))
    (let ((go-str (cffi:foreign-alloc ty)))
      (setf (cffi:foreign-slot-value go-str ty 'str) lisp-str
            (cffi:foreign-slot-value go-str ty 'count) (length lisp-str))
      go-str)))

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

(defun test3 ()
  (let ((go-str (create-go-string "abc")))
    (format *standard-output* "string /~s/ count /~s/~%" (string-part go-str) (count-part go-str))))

(defun main ()
  (test3))