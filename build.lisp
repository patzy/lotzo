(load "asdf.lisp")
(asdf:operate 'asdf:load-op :lotzo)

(defparameter *doc*
  "Lotzo is an IRC bot written entirely in Common LISP.")


(defun clean-all ()
  (mapcar #'delete-file (directory "*.fas"))
  (mapcar #'delete-file (directory "*.lib"))
  (delete-file "lotzo"))

(defun run ()
  (lotzo:start))

(defun make-lotzo ()
  (ext:saveinitmem "lotzo" :init-function (lambda ()
                                            (lotzo:start)
                                            (ext:quit))
                            :executable t
                            :keep-global-handlers t
                            :norc t
                            :documentation *doc*))


