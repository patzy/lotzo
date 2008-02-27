(in-package :lotzo-motd)

;;FIXME: do not load all motds in memory !!!

(defvar *motds* '())
(defvar *motd-file* "motds")

(setq *random-state* (make-random-state t))

(with-open-file (s *motd-file* :direction :input)
                (do ((l (read-line s) (read-line s nil 'eof)))
                    ((eq l 'eof) "Reached end of file.")
                    (push l *motds*)))


(defcommand "motd" (:help-msg "Print a random motd in the current channel")
  (say where (nth (random (length *motds*)) *motds*)))

(defcommand "topic"
  (:min-level 4
   :help-msg  "Change topic to a random motd (required the bot to be operator)")
  (topic where (nth (random (length *motds*)) *motds*)))

;help
(defhelpmsg "motd-module"
  (say where (format nil "===Help for motd==="))
  (say where (format nil "MOTD module allow to display random message from the motd file"))
  (say where (format nil "Two commands are available (starting with '!'):"))
  (say where (format nil "motd: display a motd in the current channel"))
  (say where (format nil "topic: set a motd as the topic of the current channel (require the bot to be op)"))
  (say where (format nil "====================")))



