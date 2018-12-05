(defsystem lisp-client
  :depends-on (cffi
               cffi-libffi)
  :components ((:module source
                        :pathname "./"
                        :components ((:file "lisp-client")))))
