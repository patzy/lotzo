;;;;;;;;;;;;;;;;;;;;;;
;;Lotzo bot framework
;;;;;;;;;;;;;;;;;;;;;;

;;TODO: improve module system so we can load, unload and reload modules
;;TODO: maybe remove the package stuff for modules
;;TODO: change modules spec to allow init and shutdown of modules
;;TODO: at specific time
;;TODO: change the rc-file stuff
(in-package :lotzo)


(defvar *authenticated* 'nil)
(defvar *operator* 'nil)
(defvar *connected* 'nil)

(defvar *irc-socket* 'nil)


(defvar *rc-file* "~/.lotzorc")

(defvar *channels* '("#lotzo"))
(defvar *servers* '("eu.undernet.org"))
(defvar *port* 6667)
(defvar *nick* "Lotzo")

(defvar *channel-join-msg* "Hello")



;;Parsers ----------------------------------------------------------------------
;;Those are hooks run when a specific IRC command is received
;;You can have multiple hooks for one command
(defparameter *parsers* (make-hash-table :test 'equal))


(defun register-parser (parser command)
  (push  parser (gethash command *parsers*))
  (format t "Registering new parser for command ~A (total: ~A)~%"
          command (length (gethash command *parsers*))))

(defmacro defparser (command &body code)
  `(register-parser
    (lambda (prefix command middle trailing)
      ,@code)
    ,command))


;;default MODE parser
(defparser "MODE"
  (setq nick (subseq prefix 1 (position #\! prefix)))
  (if (and (string-equal (first trailing) "-o")
           (string-equal (second trailing) *nick*))
      (progn (setq *operator* 'nil)))
  (if (and (string-equal (first trailing) "+o")
           (string-equal (second trailing) *nick*))
      (progn (setq *operator* 't))))

(defparser "376"
  (if (not *authenticated*);authentication is required to go further
      (progn (setq *authenticated* 't)
             ;;join all channels
             (mapcar (lambda (channel)
                       (send (concatenate 'string "JOIN " channel) *irc-socket*)
                       (format t "Joining channel ~A~%" channel))
                     *channels*))))

(defparser "372"
  (format t "Parsing 372 command~%")
  (format t "MOTD: ~A~%" trailing))

;;FIXME: this is called every time somebody join
(defparser "JOIN"
  (when (and (member middle *channels* :test #'equal)
             (equal *nick* (subseq prefix 1 (position #\! prefix))))
    (format t "Joined ~A~%" middle)
    (say middle *channel-join-msg*)))

;;parse an irc string into its three
;;parts
(defun parse-irc (string)
  ;;prefix(optional) command middle trailing(optional)
  (let ((splited-msg (split-string *reply* #\Space)))
    (if (equal (char (first splited-msg) 0) #\:);try to find a prefix
        (setq prefix (first splited-msg)))
    (setq command (second splited-msg))         ;then the command
    (setq middle (third splited-msg))           ;then middle
    (setq trailing (cdddr splited-msg))         ;and the trailing part
    (setq nick (subseq prefix 1
                       (position #\! prefix)))  ;nick who send the message
    (format t "Prefix:~S~%" prefix)
    (format t "Command:~S~%" command)
    (format t "Middle:~S~%" middle)
    (format t "Trailing:~S~%" trailing)

    (format t "Calling registered parsers~%")

    ;;Call all registered parsers
    (if (gethash command *parsers*)
        (loop for p in (gethash command *parsers*)
              do (funcall p prefix command middle trailing))
      (format t "No parser defined for command:~S~%" command))))

(defun read-input (stream)
  (setq *reply* (receive stream)))
                                        ;(format t "Received:~S~%" *reply*))

(defun eval-input ()
  (setq splited-input (split-string *reply* #\Space))
  (cond ((string-equal (first splited-input) "NOTICE") ;;NOTICE
         (format t "~S~%" *reply*))

        ((string-equal (first splited-input) "PING") ;;PING?PONG!
         (format t "PING? PONG!~%")
         (send (concatenate 'string "PONG " (string (second splited-input))) *irc-socket*))


        ((string-equal (first splited-input) "ERROR") ;;ERROR
         (progn (format t "ERROR:~S~%" *reply*)
                (setf *connected* 'nil)
                (sleep 10)))

        (t (parse-irc *reply*))

        ))

(defun connect-to-server ()
  (loop for current-server in *servers*
        do (progn (format t "Trying server ~S:~S~%" current-server *port*)
                  (setf *irc-socket* (connect current-server *port*)))
        until (not (null *irc-socket*))
        finally (progn (setf *connected* 't)
                       (format t "Connected: ~A~%" *irc-socket*)))

  (unless *connected*
    (error "Server list exhausted"))
  ;;identify
  (format t "Registering on server~%")
  (send "USER Lotzo localhost localhost :Who am I?" *irc-socket*)
  (send (concatenate 'string "NICK " *nick*) *irc-socket*)
  (format t "Connected~%"))

(defun main-loop ()
  "Main program loop read and eval input from irc calling
   the appropriate registered parsers"
  (when *rc-file*
               (load *rc-file*))
  (loop while t
        do (progn (if *connected*
                      (progn (read-input *irc-socket*)
                             (eval-input))
    (connect-to-server)))))
