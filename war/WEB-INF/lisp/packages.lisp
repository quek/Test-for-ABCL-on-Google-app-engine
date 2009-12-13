(defpackage :gae
    (:use :cl)
  (:export #:run-servlet
           #:*request*
           #:*response*))


(defpackage :gae-user
    (:use :cl :gae))

