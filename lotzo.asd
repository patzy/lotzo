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
               (:file "keywords")
               (:file "commands-keyword")
               (:file "users")
               (:file "help")
               (:file "commands")
               (:module notes
                        :serial t
                        :components ((:file "package")
                                     (:file "notes")))
               (:module announces
                        :serial t
                        :components ((:file "package")
                                     (:file "announces")))
               (:module motd
                        :serial t
                        :components ((:file "package")
                                     (:file "motd")))
               (:module apache
                        :serial t
                        :components ((:file "package")
                                     (:file "htaccess")))
               (:module logging
                        :serial t
                        :components ((:file "package")
                                     (:file "log")))))
