(asdf:defsystem :gae
  :version "0.0.1"
  :serial t
  :components ((:file "packages")
               (:file "servlet")
               (:file "datastore")
               
               (:file "foo")
               (:file "bar")
               )
  :depends-on (abcl-helper cl-who cl-ppcre))
