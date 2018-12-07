(defsystem lisp-gostr-client
  :depends-on (cffi
               cffi-libffi)
  :components ((:module source
                        :pathname "./"
                        :components ((:file "lisp-gostr-client")))))
