(in-package :gae)

(eval-when (:compile-toplevel :load-toplevel :execute)
  (j:jimport |java.lang.String|)
  (j:jimport |java.lang.Throwable|)
  (j:jimport |java.io.PrintWriter|)
  (j:jimport |javax.servlet.http.HttpServletRequest|))

(defvar *request*)
(defvar *response*)

(defun run-servlet (*request* *response*)
  ;; for development
  ;; (asdf:oos 'asdf:load-op :gae)
  (handler-case
      (progn
        (let* ((url (j:jcc *request* |getRequestURL| |toString|))
               (symbol (compute-route url)))
          (funcall symbol)
          (force-output)))
    (java::java-exception (x)
      (format t "Java Exception: ~a~%" x)
      (|printStackTrace| (java:java-exception-cause x)))
    (condition (x)
      (format t "Error: ~a~%" x))))

(defun compute-route (url)
  (let* ((p1 (position #\/ url :from-end t))
         (p2 (position #\/ url :from-end t :end p1))
         (package (subseq url (1+ p2) p1))
         (symbol (subseq url (1+ p1))))
    (dolist (i '(#\? #\#))
      (let ((p (position i symbol)))
        (when p (setf symbol (subseq symbol 0 p)))))
    (intern (string-upcase symbol) (string-upcase package))))