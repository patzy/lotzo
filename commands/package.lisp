(defpackage :lotzo-commands
  (:use :cl :lotzo :lotzo-keywords))


(in-package :lotzo-commands)


(export '(register-command
          defcommand
          command-args
          defhelpmsg
          register-help
          add-user
          set-auto-voice
          unset-auto-voice
          set-auto-op
          unset-auto-op
          set-auto-kick
          unset-auto-kick))


