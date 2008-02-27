(in-package :lotzo)

(defconstant +dow+ '(Monday Tuesday Wednesday Thursday Friday Saturday Sunday))

(defun format-date-string ()
  "Returns a string with current date."
  (multiple-value-bind (second minute hour date month year dow)
      (decode-universal-time (get-universal-time) )
    (format nil "~A ~A/~A/~A at ~A:~A:~A~%"
            (nth dow +dow+) date month year hour minute second)))
(defun split-string (string delim)
    (loop for i = 0 then (1+ j)
          as j = (position delim string :start i)
          when (not (= (length (subseq string i j)) 0));remove last elt
          collect (subseq string i j)
          while j))
