;; Network code
;; XXX: only works with clisp
(in-package :lotzo)


(defun connect (server port)
  "Connect to the specified server and port."
  (handler-case (socket:socket-connect port server
                                       :element-type 'character :timeout 1)
                (error () 'nil)))


(defun disconnect (sock)
  "Close an existing connection."
  (close sock))

(defun send (command stream)
   "Send command to stream"
  (ext:write-char-sequence
   (concatenate  'string command (string #\Return) (string #\Newline)) 
   stream))

;;receive reply fro mstream
(defun receive (stream)
  "Receive a reply from stream"
  (read-line stream))
