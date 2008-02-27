(defpackage :lotzo-notes
  (:use :cl :lotzo))


(in-package :lotzo-notes)

(export '(*messages-private-notification*
          add-message
          clear-messages))