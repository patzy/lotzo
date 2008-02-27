(defpackage :lotzo-announces
  (:use :cl :lotzo :lotzo-keywords
        :lotzo-commands))


(in-package :lotzo-announces)

(export '(*announce-join-msg*
           add-announce
           remove-announce))