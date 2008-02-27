(defpackage :lotzo-announces
  (:use :cl :lotzo))


(in-package :lotzo-announces)

(export '(*announce-join-msg*
           add-announce
           remove-announce))