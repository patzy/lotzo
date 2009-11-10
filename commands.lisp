(in-package :lotzo)

(defcommand "level" (:help-msg "Print the user rights level")
  (if (gethash from *allowed-users*)
      (say where (format nil "~A: Your level is ~A" from (get-user-level from)))
    (say where "You're not registered")))

(defcommand  "eval" (:min-level 5
                     :help-msg  "Evaluate lisp code online")
  (format t "Code to eval: ~{ ~a~}~%" command-args)
  (let ((eval-result (ignore-errors
                       (handler-case
                        (eval (read-from-string
                               (format nil "~{~A ~}" command-args)))
                        (error (c)
                               c)))))
    (say where (format nil "~A" eval-result))))

(defcommand "quit" (:min-level 5
                    :help-msg  "Tell the bot to disconnect")
  (say where "Bye !")
  (stop))

(defcommand "suspend" (:min-level 5
                    :help-msg  "Suspend the main loop")
  (say where "Entering suspend mode...(be carefull about connection timeout !)")
  (suspend) )

(defcommand "loadrc" (:min-level 5
                    :help-msg  "Reload rc file")
  (say where "Reloading rc file...")
  (load-rc-file)
  (say where "rc file loaded"))

(defcommand "reload" (:min-level 5
                    :help-msg  "Reload all code")
  (say where "Reloading ...")
  (reload)
  (say where "reload done"))

(defcommand "update" (:min-level 5
                    :help-msg  "Update all code using git pull")
  (say where "Updating ...")
  (update)
  (say where "update done"))

(defcommand "status" (:help-msg  "Print the bot current status")
 (print-status where))

(defcommand "voice" (:min-level 4
                     :help-msg  "Ask the bot to give voice status")
  (if (= 0 (length command-args))
      (voice from where)
    (mapcar (lambda (current-user)
              (voice current-user where))
            command-args)))

(defcommand "devoice" (:min-level 4
                       :help-msg   "Tell the bot to remove voice status")
  (if (= 0 (length command-args))
      (devoice from where)
    (mapcar (lambda (current-user)
              (devoice current-user where))
            command-args)))

(defcommand "op" (:min-level 4
                  :help-msg   "Ask the bot to give operator status")
  (if (= 0 (length command-args))
      (op from where)
    (mapcar (lambda (current-user)
              (op current-user where))
            command-args)))

(defcommand "deop"(:min-level 4
                   :help-msg "Tell the bot to remove operator status")
  (if (= 0 (length command-args))
      (deop from where)
    (mapcar (lambda (current-user)
              (deop current-user where))
            command-args)))

(defcommand "kick" (:min-level 4
                    :help-msg "Tell the bot to kick the specified users")
  (if (= 0 (length command-args))
      (kick from where)
    (mapcar (lambda (current-user)
              (kick current-user where))
            command-args)))

(defcommand "join" (:min-level 5
                    :help-msg "Tell the bot to join the specified channels")
  (if (not (= 0 (length command-args)))
      (mapcar (lambda (current-chan)
                (join current-chan))
              command-args)
    (say from "You must provide one or more channels to join")))





