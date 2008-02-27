(defpackage :lotzo-notes
  (:use :cl :lotzo :lotzo-keywords
        :lotzo-commands))


(in-package :lotzo-notes)

(export '(*messages-private-notification*
          add-message
          clear-messages))