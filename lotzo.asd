;;; -*- Mode: Lisp -*-

(defpackage :lotzo-system
  (:use :cl :asdf))
(in-package :lotzo-system)

(defsystem :lotzo
  :name "Lotzo"
  :author "Morgan Veyret <patzy@appart.kicks-ass.net>"
  :maintainer "Morgan Veyret <patzy@appart.kicks-ass.net>"
  :license "BSD"
  :version "git"
  :description "An IRC bot written in Common Lisp"
  :serial t
  :components ((:file "package")
               (:file "utils")
               (:file "net")
               (:file "irc")
               (:file "lotzo")
               (:module keywords
                        :serial t
                        :components ((:file "package")
                                     (:file "keywords")))
               (:module commands
                        :serial t
                        :components ((:file "package")
                                     (:file "command-keyword")
                                     (:file "users")
                                     (:file "help")
                                     (:file "commands")))))
