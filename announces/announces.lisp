(in-package :lotzo-announces)
;announce_management
(defvar *announces* '()
  "List of all annouces")

(defvar *announce-join-msg*
  "Here are the current announces. !help announces-module for more information."
  "This message is sent in private to users joining the channel")

(defun add-announce (msg)
  "Add an announce"
  (pushnew msg *announces*))

(defun remove-announce(number)
  "Remove announce number NUMBER"
  (let ((counter 0))
    (setf *announces*
          (mapcar (lambda (current-announce)
                    (incf counter)
                    (if (!= counter number)
                        current-announce
                      nil))
                  *announces*))))


(defun say-announces (to)
  "Tell announces to TO"
  (mapcar (lambda (elt)
            (say to elt))
          *announces*))

;;List announces to users who join the channel
(defparser "JOIN"
  (let ((nick (subseq prefix 1 (position #\! prefix)))
        (channel (string-left-trim ":" middle)))
    (say nick *announce-join-msg*)
    (say-announces nick)))



;;Module help message
(defhelpmsg "announces-module"
  (say where (format nil "===Help for annouces==="))
  (say where (format nil "!add_announce _announce_ => add an annouce"))
  (say where (format nil "!announces [pm] => list announces"))
  (say where (format nil "!del_announce _number_ => remove _number_ announce"))
  (say where (format nil "====================")))


;;commands
;announces
(defcommand "announces" (:help-msg "Print all current announces.")
  (if (and (= 2 (length command-args))
           (string-equal (first command-args) "pm"))
      (say-announces from)
    (say-announces where)))

;add_announce
(defcommand "add_announce" (:help-msg "Add an announce")
  (add-announce (format nil "~{ ~A~}" (cdr command-args)))
  (say where "Announce added"))

;del_announce
(defcommand "del_announce" (:help-msg "Delete announce number")
  (remove-announce (second sentence)))
