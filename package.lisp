;;Lotzo package definition
(defpackage :lotzo
  (:use :cl))


(in-package :lotzo)

(export '(*lotzo-modules*
          *nick*
          load-rc-file
          suspend
          resume
          stop
          main-loop

          register-parser
          defparser

          defmodule
          use-module
          in-module

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

          prefix
          command
          middle
          trailing))