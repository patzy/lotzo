(in-package :lotzo-notes)
;message_management
(defvar *messages* (make-hash-table :test 'equal)
  "Stores all user messages")

(defstruct message
  "Stores message data"
  from
  msg
  date)

(defun add-message (to msg from)
  "Add a new message for TO"
  (pushnew (make-message :from from :msg msg
                         :date (format-date-string))
           (gethash to *messages*) :test 'equal))

(defun clear-messages (to)
  "Clear all messages of TO"
  (remhash to *messages*))

(defvar *messages-private-notification* nil
  "Do we notify users publicly?")

(defun notify-user (nick channel)
  (if *messages-private-notification*
      (say nick (format nil "~A you have ~d note(s) (!help notes pour plus d'infos)~%"
                        nick (length (gethash nick *messages*))))
    (say channel (format nil "~A you have ~d note(s) (!help notes pour plus d'infos)~%"
                         nick (length (gethash nick *messages*))))))

;;Notify a user on join
(defparser "JOIN"
  (let ((nick (subseq prefix 1 (position #\! prefix)))
        (channel (string-left-trim ":" middle)))
    (when (gethash nick *messages*)
      (notify-user nick channel))))

;Notify when a user gets back to the correct nick
(defparser "NICK"
  (let ((nick (subseq prefix 1 (position #\! prefix)))
        (channel (string-left-trim ":" middle)))
    (if (gethash nick *messages*)
        (notify-user nick channel))))

;Module help
(defhelpmsg "notes-module"
  (say where (format nil "===Help for notes==="))
  (say where (format nil "List all stored notes: ~A notes list " *nick*))
  (say where (format nil "Read your notes [private]: ~A my notes [pm]" *nick*))
  (say where (format nil "Clear your notes: ~A clear my notes" *nick*))
  (say where (format nil "Leave a note: ~A note for _nick_  _msg_" *nick*))
  (say where (format nil "====================")))

(defmacro contains (word)
  `(member ,word sentence :test #'equal))

;;FIXME: add command versions
;callbacks
(defkeyword
  ((and (contains *nick*)
        (contains "note")
        (contains "for")))
  ((let ((note-for (nth (+ (position "for" sentence :test 'string-equal) 1)
                       sentence)))
    (say where (concatenate 'string "Note added for " note-for))
    (add-message note-for
                 (format nil "~{~A ~}"
                         (cddr (member "for" sentence :test 'string-equal)))
                 from))))

(defkeyword
  ((and (contains *nick*)
        (contains "my")
        (contains "notes")
        (not (contains "clear"))))
  ((if (gethash from *messages*)
       (mapcar (lambda (msg)
                 (say (if (contains "pm") from where)
                      (format nil "~S=>~S~%"
                              (message-from msg)
                              (message-msg msg))))
               (gethash from *messages*))
     (say where (concatenate 'string "No message for you " from)))))

(defkeyword
  ((and (contains *nick*)
        (contains "my")
        (contains "notes")
        (contains "clear")))
  ((clear-messages from)
   (say where (concatenate 'string "You notes have been cleared " from))))

(defkeyword
  ((and (contains *nick*)
        (contains "list")
        (contains "notes")))
  ((maphash (lambda (key val)
              (say where (format nil "~S notes notes ~S~%" (length val) key)))
            *messages*)))
