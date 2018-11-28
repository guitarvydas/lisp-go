(defsystem lisp-go
  :depends-on (cffi
               cffi-libffi)
  :components ((:module lib
                        :pathname "."
                        :components ((:file "goprog")))
               (:module source
                        :pathname "./"
                        :depends-on (lib)
                        :components ((:file "sbcl-client")
                                     (:file "lw-client")))))

                                            

