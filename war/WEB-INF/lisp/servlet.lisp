(in-package :gae)

(eval-when (:compile-toplevel :load-toplevel :execute)
  (loop for i in (directory "WEB-INF/lisp-lib/*")
        if (extensions:file-directory-p i)
          do (pushnew i asdf:*central-registry* :test #'equal))

  (asdf:oos 'asdf:load-op :cl-who)
  (asdf:oos 'asdf:load-op :abcl-helper)
  )

(eval-when (:compile-toplevel :load-toplevel :execute)
  (j:jimport |java.lang.String|)
  (j:jimport |java.lang.Throwable|)
  (j:jimport |java.io.PrintWriter|)
  (j:jimport |javax.servlet.http.HttpServletRequest|))

(defvar *request*)
(defvar *response*)

(defun run-servlet (*request* *response*)
  ;; for development
  (asdf:oos 'asdf:load-op :gae)
  (handler-case
      (progn
        (let ((url (j:jcc *request* |getRequestURL| |toString|)))
          (ppcre:register-groups-bind
           ((#'string-upcase package-name symbol-name))
           (".*/([^/]+)/([^?#/]+)" url)
           (let ((symbol (intern symbol-name package-name)))
             (funcall symbol)
             (force-output)))))
    (java::java-exception (x)
      (format t "Java Exception: ~a~%" x)
      (|printStackTrace| (java:java-exception-cause x)))
    (condition (x)
      (format t "Error: ~a~%" x))))
