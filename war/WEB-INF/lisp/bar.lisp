(in-package :app)

(defun bar ()
  (cl-who:with-html-output (*standard-output*)
    (:html
     (:head (:title "foo"))
     (:body (:h1 "ABCL on Google app engine♪")
            (:div "Common Lisp(ABCL)で Google app engine!")
            (:div (:a :href "foo" "foo へ"))))))
