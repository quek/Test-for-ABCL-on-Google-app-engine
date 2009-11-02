(in-package :app)

(defun foo ()
  (let ((foo (servlet::|getParameter| servlet::*request* "foo"))
        (bar (servlet::|getParameter| servlet::*request* "bar")))
    (cl-who:with-html-output (*standard-output*)
      (:html
       (:head (:title "foo"))
       (:body (:h1 "まみむめも♪")
              (:form :method :post :action "foo"
                     (:div "foo " (:input :type :text :name "foo"))
                     (:div "bar " (:input :type :text :name "bar"))
                     (:input :type :submit :value "クリック"))
              (when foo
                (cl-who:htm
                 (:div (cl-who:esc (format nil "foo => ~a" foo)))
                 (:div (cl-who:esc (format nil "bar => ~a" bar)))))
              (:div (:a :href "bar" "bar")))))))
