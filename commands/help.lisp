;;help system

(in-package :lotzo-commands)

(defparameter *help-messages* (make-hash-table :test 'equal))

(defun register-help-message (help keyword)
  (setf (gethash keyword *help-messages*) help))

(defmacro defhelpmsg (keyword &body help)
  `(register-help-message
    (lambda (from where)
      ,@help
      )
    ,keyword))


;help command
(defcommand "help" (:min-level 0)
  (if (gethash (first command-args) *help-messages*)
      (funcall (gethash (first command-args) *help-messages*) from where)
    (progn (say where (format nil "To have help on a command or topic juste type !help topic/command."))
           (let ((topics '()))
             (maphash (lambda (key value)
                        (push key topics))
                      *help-messages*)
             (say where (format nil "Topics available: ~{~A~#[~:;, ~]~}" topics))))))



