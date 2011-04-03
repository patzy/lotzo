;;; -*- Mode: Lisp -*-

(defpackage :lotzo-system
  (:use :cl :asdf))
(in-package :lotzo-system)

(defsystem :lotzo
  :name "Lotzo"
  :license "MIT"
  :version "git"
  :description "An IRC bot written in Common Lisp"
  :serial t
  :components ((:file "package")
               (:file "utils")
               (:file "net")
               (:file "irc")
               (:file "lotzo")
               (:file "keywords")
               ;; commands, help and user management
               (:file "commands-keyword")
               (:file "users")
               (:file "help")
               (:file "commands")))
