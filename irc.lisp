;; Defines some irc commands
(in-package :lotzo)

(defun quit-irc ()
  (send "QUIT" *irc-socket*))

(defun say (to msg)
  (send (concatenate 'string "PRIVMSG " to " :" msg) *irc-socket*))

(defun action (to msg)
  (send (concatenate 'string "PRIVMSG " to " :*" msg "*") *irc-socket*))

(defun kick (who channel)
  (when *operator*
      (send (concatenate 'string "KICK " channel " " who) *irc-socket*)))

(defun ban (who channel)
  (when *operator*
      (send (concatenate 'string "MODE " channel " +b " who) *irc-socket*)))

(defun deban (who channel)
  (when *operator*
      (send (concatenate 'string "MODE " channel " -b " who) *irc-socket*)))

(defun op (who channel)
  (when *operator*
      (send (concatenate 'string "MODE " channel " +o " who) *irc-socket*)))

(defun deop (who channel)
  (when *operator*
      (send (concatenate 'string "MODE " channel " -o " who) *irc-socket*)))

(defun voice (who channel)
  (when *operator*
      (send (concatenate 'string "MODE " channel " +v " who) *irc-socket*)))

(defun devoice (who channel)
  (when *operator*
      (send (concatenate 'string "MODE " channel " -v " who) *irc-socket*)))

(defun whois (who channel)
  (send (concatenate 'string "WHOIS " channel " " who) *irc-socket*))

(defun users (channel)
  (send (concatenate 'string "NAMES " channel) *irc-socket*))

(defun join (channel)
  (pushnew channel *channels*)
  (send (concatenate 'string "JOIN " channel) *irc-socket*))

(defun topic (channel text)
  (send (concatenate 'string "TOPIC " channel " :" text) *irc-socket*))

