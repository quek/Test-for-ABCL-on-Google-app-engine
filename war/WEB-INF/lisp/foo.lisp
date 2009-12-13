(in-package :gae-user)

(defun foo ()
  (let ((foo (|getParameter| *request* "foo"))
        (bar (|getParameter| *request* "bar")))
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
