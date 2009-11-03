(in-package :app)

(eval-when (:compile-toplevel :load-toplevel :execute)
  (j:jimport |com.google.appengine.api.datastore.Entity|)
  (j:jimport |com.google.appengine.api.datastore.Key|)
  (j:jimport |com.google.appengine.api.datastore.KeyFactory|)
  (j:jimport |com.google.appengine.api.datastore.DatastoreService|)
  (j:jimport |com.google.appengine.api.datastore.DatastoreServiceFactory|))

(defun ds ()
  (let* ((service (|getDatastoreService| |DatastoreServiceFactory|))
         (entity (j:new |Entity| "Bano")))
    (|setProperty| entity "name" "kocho")
    (let ((key (|put| service entity)))
      (let ((found-entity (|get| service key)))
        (cl-who:with-html-output (*standard-output*)
          (:html (:body
                  (:pre (cl-who:esc (prin1-to-string service)))
                  (:pre (cl-who:esc (prin1-to-string key)))
                  (:pre (cl-who:esc (prin1-to-string  entity)))
                  (:pre (cl-who:esc (prin1-to-string  found-entity))))))))))


(defun bar ()
  (cl-who:with-html-output (*standard-output*)
    (:html
     (:head (:title "foo"))
     (:body (:h1 "ABCL on Google app engine♪")
            (:div "Common Lisp(ABCL)で Google app engine!")
            (:div (:a :href "foo" "foo へ"))))))
