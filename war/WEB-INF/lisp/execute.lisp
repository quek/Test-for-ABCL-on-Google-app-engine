(defpackage #:servlet
  (:use :cl)
  (:export #:execute))

(in-package #:servlet)

(require 'asdf)
(loop for i in (directory "WEB-INF/lisp-lib/*")
      if (extensions:file-directory-p i)
        do (pushnew i asdf:*central-registry* :test #'equal))

(pushnew (merge-pathnames "WEB-INF/lisp/")
         asdf:*central-registry* :test #'equal)


(asdf:oos 'asdf:load-op :cl-who)
(asdf:oos 'asdf:load-op :abcl-helper)

(j:jimport |java.lang.String|)
(j:jimport |javax.servlet.http.HttpServletRequest|)

(defvar *request*)
(defvar *response*)


;;(asdf:oos 'asdf:load-op :app)
;;(defun execute (*request* *response*)
;;  (let ((url (j:jcc *request* |getRequestURL| |toString|)))
;;    (format t "<pre>~a</pre>~%" url)))

(defun execute (*request* *response*)
  (asdf:oos 'asdf:load-op :app)
  (handler-case
      (progn
        (let ((url (j:jcc *request* |getRequestURL| |toString|)))
          (ppcre:register-groups-bind
           ((#'string-upcase package-name symbol-name))
           (".*/([^/]+)/([^?#/]+)" url)
           (let ((symbol (intern symbol-name package-name)))
             (funcall symbol)
             (force-output)))))
    (condition (x)
      (format t "Error ~a~%" x))))
