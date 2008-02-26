;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;commands
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(in-package :lotzo-commands)

;user_level
(defcommand "level" ()
  "Print the user level"
  (if (gethash from *allowed-users*)
      (say where (format nil "~A: Your level is ~A" from (get-user-level from)))
    (say where "You're not registered")))


;eval_order
;;FIXME: this needs some teste and to be secured a bit more than with the
;;FIXME: user level
(defcommand  "eval" (:min-level 5
                     :help-msg  "Evaluate lisp code online")
  (say where
       (format nil "~S"
               (ignore-errors
                 (eval (read-from-string
                        (format nil "~{~A ~}" command-args)))))))

;; ;list modules
;; (defcommand  "modules"
;;   (:min-level 5
;;    :help-msg   "Print the list of loaded modules")
;;   (say where (format nil "Loaded modules: ~A~%" *lotzo-modules*)))

;; ;;load module
;; (defcommand  "load_module"
;;   (:min-level 5
;;    :help-msg "Tell the bot to load the specified module")
;;   (use-module (read-from-string (first command-args)))
;;   (say where (format nil "Loaded modules: ~A~%" *lotzo-modules*)))

;quit_order
(defcommand "quit" (:min-level 5
                    :help-msg  "Tell the bot to disconnect")
  (say where "Bye !"))

;suspend_order
(defcommand "suspend" (:min-level 5
                    :help-msg  "Suspend the main loop")
  (say where "Entering suspend mode...(be carefull about connection timeout !)")
  (suspend) )

;loadrc_order
(defcommand "loadrc" (:min-level 5
                    :help-msg  "Reload rc file")
  (say where "Reloading rc file...")
  (load-rc-file))

;status
(defcommand "status" (:help-msg  "Print the bot current status")
 (print-status where))

;voice
(defcommand "voice" (:min-level 4
                     :help-msg  "Ask the bot to give voice status")
  (if (= 0 (length command-args))
      (voice from where)
    (mapcar (lambda (current-user)
              (voice current-user where))
            command-args)))

;devoice
(defcommand "devoice" (:min-level 4
                       :help-msg   "Tell the bot to remove voice status")
  (if (= 0 (length command-args))
      (devoice from where)
    (mapcar (lambda (current-user)
              (devoice current-user where))
            command-args)))

;op
(defcommand "op" (:min-level 4
                  :help-msg   "Ask the bot to give operator status")
  (if (= 0 (length command-args))
      (op from where)
    (mapcar (lambda (current-user)
              (op current-user where))
            command-args)))


;deop
(defcommand "deop"(:min-level 4
                   :help-msg "Tell the bot to remove operator status")
  (if (= 0 (length command-args))
      (deop from where)
    (mapcar (lambda (current-user)
              (deop current-user where))
            command-args)))



;kick
(defcommand "kick" (:min-level 4
                    :help-msg "Tell the bot to kick the specified users")
  (if (= 0 (length command-args))
      (kick from where)
    (mapcar (lambda (current-user)
              (kick current-user where))
            command-args))) 


;join
(defcommand "join" (:min-level 5
                    :help-msg "Tell the bot to join the specified channels")
  (if (not (= 0 (length command-args)))
      (mapcar (lambda (current-chan)
                (join current-chan))
              command-args)
    (say from "You must provide one or more channels to join")))


;;Module help message
(defhelpmsg "commands-module"
  (say where (format nil "===Help for commands==="))
  (say where (format nil "The following commands may require a specific user level to be executed"))
  (say where (format nil "All commands begin with '!'"))
  (say where (format nil "Commands:"))
  (say where (format nil "level: show user level"))
  (say where (format nil "eval _lisp_: evaluate the LISP expression _lisp_"))
  (say where (format nil "quit: make the bot to disconnect"))
  (say where (format nil "status: show the bot current status"))
  (say where (format nil "op [nick]: set operator mode for the user or requested nick on the current channel"))
  (say where (format nil "deop [nick]: unset operator mode for the user or requested nick on the current channel"))
  (say where (format nil "voice [nick]: set voice mode for the user or requested nick on the current channel"))
  (say where (format nil "devoice [nick]: unset voice mode for the user or requested nick on the current channel"))
  (say where (format nil "kick [nick]: kick the user or requested nick on the current channel"))
  (say where (format nil "join _chan_: make the bot to join the specified channel _chan_"))
  (say where (format nil "=======================")))





