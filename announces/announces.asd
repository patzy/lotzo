;;; -*- Mode: Lisp -*-

(defpackage :lotzo-system
  (:use :cl :asdf))
(in-package :lotzo-system)

(defsystem :lotzo-announces
  :name "Lotzo announces module"
  :author "Morgan Veyret <patzy@appart.kicks-ass.net>"
  :maintainer "Morgan Veyret <patzy@appart.kicks-ass.net>"
  :license "BSD"
  :version "git"
  :serial t
  :depends-on (lotzo)
  :components ((:file "package")
               (:file "announces")))