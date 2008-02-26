(defpackage :lotzo-keywords
  (:use :cl :lotzo))


(in-package :lotzo-keywords)

(export '(;;#:*keywords*
          ;;#:*actions*
          register-keyword
          register-action
          defkeyword
          defaction
          ;;anaphoric macros
          sentence
          from
          where))