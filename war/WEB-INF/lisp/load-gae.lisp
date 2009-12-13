(eval-when (:compile-toplevel :load-toplevel :execute)
  (require 'asdf)

  (pushnew (merge-pathnames "WEB-INF/lisp/")
           asdf:*central-registry* :test #'equal)

  ;;(asdf:oos 'asdf:load-op :gae)
  )
(load "WEB-INF/lisp/packages")
(load "WEB-INF/lisp/servlet")
(load "WEB-INF/lisp/datastore")
(load "WEB-INF/lisp/foo")
(load "WEB-INF/lisp/bar")
