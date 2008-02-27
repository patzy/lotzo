;;Commands keyword definitions
(in-package :lotzo)

;;command prefix string
(defvar *command-prefix-character* "!")

;command keyword
;;all commands starts with "!"
(defkeyword
  ((if (> (length (car sentence)) 0)
       (equal (char (car sentence) 0) #\!)))
  ((setf (car sentence) (string-left-trim *command-prefix-character*
                                          (car sentence)))
   (when (gethash (car sentence) *commands*)
     (funcall (gethash (car sentence) *commands*) from where (cdr sentence)))))

;;bot commands
(defparameter *commands* (make-hash-table :test 'equal))


(defun register-command (command action)
  (setf (gethash command *commands*) action))

(defmacro defcommand (command-name (&key (min-level 0)
                                         (help-msg 'nil))
                                   &body action)
  `(progn ,(when (not (null help-msg))
             `(defhelpmsg ,command-name
                (say where ,help-msg)))
          (register-command
           ,command-name
           (lambda (from where command-args)
             (if (allowed-user from ,min-level)
                 (progn (format t "Running action ~A for user ~A~%"
                                ,command-name from)
                        (format t "Command arguments: ~A~%" command-args)
                        ,@action)
               (say from  "You're not allowed to do this !!!"))))))



