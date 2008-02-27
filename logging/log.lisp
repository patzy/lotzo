(in-package :lotzo-logging)

(defvar *log-filename* "log.txt"
  "Output log filename")

(defvar *log-file* nil)


;;TODO: handle multiple channels logging


(defun log-begin ()
  (setf *log-file* (open *log-filename* :direction :output
                                        :if-does-not-exist :create
                                        :if-exists :append))
  (format t "Log stream: ~a~%" *log-file*)
  (format *log-file* (format nil "Started on ~a =============================~%"
                             (format-date-string)))
  (finish-output *log-file*))

(defun log-irc-message (sentence from where)
  (if (not (string= where *nick*))
      (format *log-file* "(~A) [~A] <~A> ~{~A~^ ~}~%"
              (format-date-string)
              where
              from
              sentence)
    (format *log-file* "(~A) PM <~A> ~{~A~^ ~}~%"
            (format-date-string)
            from
            sentence))
  (finish-output *log-file*))

(defun log-irc-join (from where)
  (format *log-file* "(~A) ~A joined ~A~%"
          (format-date-string)
          from where )
  (finish-output *log-file*))

(defun log-irc-part (from where)
  (format *log-file* "(~A) ~A left ~A~%"
          (format-date-string)
          from where)
  (finish-output *log-file*))

(defun log-irc-quit (from where)
  (format *log-file* "(~A) ~A quit IRC~%"
          (format-date-string)
          from where)
  (finish-output *log-file*))


;;Parsers-----------------------------------------------------

;;PRIVMSG parser
(defparser "PRIVMSG"
  (let ((nick (subseq prefix 1 (position #\! prefix))))
    (setf (car trailing) (string-left-trim ":" (car trailing)))
    ;;init logging if required
    (when (and (null *log-file*)
               (equal nick *nick*))
      (log-begin))
    ;;log the message
    (log-irc-message  trailing nick middle)))

;;JOIN parser
(defparser "JOIN"
  (let ((nick (subseq prefix 1 (position #\! prefix)))
        (channel (string-left-trim ":" middle)))
  ;;log the message
  (log-irc-join  nick channel)))

;;PART parser
(defparser "PART"
  (let ((nick (subseq prefix 1 (position #\! prefix)))
        (channel (string-left-trim ":" middle)))
    ;;log the message
    (log-irc-part  nick channel)))

;;QUIT parser
(defparser "QUIT"
  (let ((nick (subseq prefix 1 (position #\! prefix)))
        (channel (string-left-trim ":" middle)))
    ;;log the message
    (log-irc-quit  nick channel)))


;;help
(defhelpmsg "log-module"
  (say where (format nil "===Logging help==="))
  (say where (format nil "~A is actually logging to ~A" *nick* *log-filename*))
  (say where (format nil "=======================")))

