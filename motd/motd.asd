;;; -*- Mode: Lisp -*-

(defpackage :lotzo-system
  (:use :cl :asdf))
(in-package :lotzo-system)

(defsystem :lotzo-motd
  :name "Lotzo message of the day module"
  :author "Morgan Veyret <patzy@appart.kicks-ass.net>"
  :maintainer "Morgan Veyret <patzy@appart.kicks-ass.net>"
  :license "BSD"
  :version "git"
  :serial t
  :depends-on (lotzo)
  :components ((:file "package")
               (:file "motd")))