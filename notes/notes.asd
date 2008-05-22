;;; -*- Mode: Lisp -*-

(defpackage :lotzo-system
  (:use :cl :asdf))
(in-package :lotzo-system)

(defsystem :lotzo-notes
  :name "Lotzo notes module"
  :author "Morgan Veyret <patzy@appart.kicks-ass.net>"
  :maintainer "Morgan Veyret <patzy@appart.kicks-ass.net>"
  :license "BSD"
  :version "git"
  :description "An additionnal module enabling a notes system"
  :serial t
  :depends-on (lotzo)
  :components ((:file "package")
               (:file "notes")))