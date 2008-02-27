(in-package :lotzo-apache)

;;allow acces to the specified website
;;through .htaccess live modifications
;;WARNING: the user running the bot must have write permissions
;;WARNING: to the .htaccess file
;;WARNING: this obviously doesn't work for hidden ip addresses
;;TODO: allow to associate a specific htaccess file to a specific channel
;;TODO: also add support for multiple websites
(defvar *htaccess-filename* "/data/www/lotzo/.htaccess")


;;the list of allowed ip addresses
(defvar *addresses* (make-hash-table :test 'equal))

(defun add-address (nick address)
  (setf (gethash nick *addresses*) address))

(defun remove-address (nick)
  (remhash nick *addresses*))


(defun output-htaccess ()
  (let ((htaccess-file (open *htaccess-filename* :direction :output )))
  (format htaccess-file "#Apache htaccess file generated automatically by ~A~%"
          *nick*)
  (format htaccess-file "Order Deny,Allow~%")
  (format htaccess-file "Deny from all~%")
  ;;Allow all local htaccess FIXME: this need to be user configurable
  (format htaccess-file "Allow from 192.168.0.0/255.255.255.0~%")
  (format htaccess-file "Allow from 192.168.1.0/255.255.255.0~%")
  (maphash (lambda (key val)
             (format htaccess-file "Allow from ~A~%" val))
           *addresses*)
  (finish-output htaccess-file)
  (close htaccess-file)))


;; Add joining users to allowed people
;;TODO: add all existing users when joining a channel
(defparser "JOIN"
  (let ((nick (subseq prefix 1 (position #\! prefix)))
        (addr (subseq prefix (+ 1 (position #\@ prefix)) (length prefix))))
    (add-address nick addr)
    (output-htaccess)))

;; Remove user from .htaccess file
(defparser "PART"
  (let ((nick (subseq prefix 1 (position #\! prefix)))
        (addr (subseq prefix (+ 1 (position #\@ prefix)) (length prefix))))
    (remove-address nick)
    (output-htaccess)))

;; Remove user from .htaccess file
(defparser "QUIT"
  (let ((nick (subseq prefix 1 (position #\! prefix)))
        (addr (subseq prefix (+ 1 (position #\@ prefix)) (length prefix))))
    (remove-address nick)
    (output-htaccess)))

;;Nick following procedure
(defparser "NICK"
  (let ((oldnick (subseq prefix 1 (position #\! prefix)))
        (newnick (string-left-trim ":" middle))
        (addr (subseq prefix (+ 1 (position #\@ prefix)) (length prefix))))
    (remove-address oldnick)
    (add-address newnick addr)
    (output-htaccess)))

