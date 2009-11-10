;;;; Lotzo package definition
(defpackage :lotzo
  (:use :cl))


(in-package :lotzo)

(export '(*nick*
          load-rc-file
          reload
          suspend
          resume
          stop
          start
          ;; parser management
          register-parser
          defparser
          ;; irc commands
          quit-irc
          say
          action
          kick
          ban
          deban
          op
          deop
          voice
          devoice
          users
          join
          topic
          ;; utils
          split-string
          format-date-string
          ;; keywords system
          register-keyword
          register-action
          defkeyword
          defaction
          ;; for commands
          register-command
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
          unset-auto-kick
          ;; for anaphoric macros
          sentence
          from
          where
          prefix
          command
          middle
          trailing))