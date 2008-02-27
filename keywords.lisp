(in-package :lotzo)

;;All registered parsers
;;One parser is a condition/action pair
(defparameter *keywords* '())



(defun register-keyword (keyword action)
  (push (cons keyword action) *keywords*))

(defmacro defkeyword (keyword action)
  `(register-keyword
    (lambda (sentence from where)
      ,@keyword
      )
    (lambda (sentence from where)
      ,@action
      )))


;;Call all matching keyword hooks
(defparser "PRIVMSG"
  (let (( nick (subseq prefix 1 (position #\! prefix))))
    (setf (car trailing) (string-left-trim ":" (car trailing)))
    ;;call the keyword functions
    (mapcar (lambda (current-keyword);for each matching keyword
              (when (funcall (car current-keyword) trailing nick middle)
                (funcall (cdr current-keyword) trailing nick middle)))
            *keywords*)))


