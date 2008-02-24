(load "package.lisp")

(defparameter *files* '("utils.lisp"
                        "net.lisp"
                        "irc.lisp"
                        "modules.lisp"
                        "lotzo.lisp"))

(defparameter *doc*
  "Lotzo is an IRC bot written entirely in Common LISP.")


(defun clean-all ()
  (mapcar #'delete-file (directory "*.fas"))
  (mapcar #'delete-file (directory "*.lib"))
  (delete-file "lotzo"))

(defun run ()
  (dolist (f *files*)
    (load (compile-file f)))
  (lotzo:main-loop))

(defun make-lotzo ()
  (dolist (f *files*)
    (load (compile-file f)))
  (ext:saveinitmem "lotzo" :init-function (lambda ()
                                             (lotzo:main-loop)
                                             (ext:quit))
                            :executable t
                            :keep-global-handlers t
                            :norc t
                            :documentation *doc*))


