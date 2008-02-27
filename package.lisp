;;Lotzo package definition
(defpackage :lotzo
  (:use :cl))


(in-package :lotzo)

(export '(*nick*
          load-rc-file
          suspend
          resume
          stop
          main-loop
          ;;parser management
          register-parser
          defparser
          ;;irc commands
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
          ;;utils
          split-string
          format-date-string
          ;;anaphoric macros
          prefix
          command
          middle
          trailing))