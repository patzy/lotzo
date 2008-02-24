;;Modules system
;;This is a basic provide/require syste with
;;file autoload
(in-package :lotzo)

(defvar *modules* '())
(defvar *module-path* "modules/")

(defmacro defmodule (module-name &key
                                 (files '())
                                 (exports '())
                                 (depends-on '()))
  "Defines a new module."
  `(progn (defpackage ,module-name
            (:use :cl :lotzo ,@depends-on)
            (:export ,@exports))
          (in-package ,module-name)
          (defparameter *files* '())
          (setf *files* (list
                         ,@(mapcar
                            (lambda (current-file)
                              (concatenate 'string *lotzo-module-path*
                                           current-file))
                            files)))))

(defmacro in-module (module-name)
  "Set the current module."
  `(in-package ,module-name))

(defmacro use-module (module-name)
  `(progn (unless (member ,module-name *lotzo-modules*)
            (progn (format t "Loading module ~A~%" ,module-name)
                   (load (concatenate 'string *lotzo-module-path*
                                      (string-downcase (string ,module-name))
                                      ".mod"))
                   (dolist (f *files*)
                     (progn (format t "~@TLoading ~A~%" f)
                            (load f)))))
          (push ,module-name *lotzo-modules*)
          (use-package ,module-name)))

