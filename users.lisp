(in-package :lotzo)
;;user management
;;there are 5 user levels
;0=>user
;1=>none
;2=>none
;3=>trusted user
;4=>friend
;5=>super-user (admin)
(defstruct user
  (level 0)
  (auto-op? 'nil)
  (auto-voice? 'nil)
  (auto-kick? 'nil))

(defvar *allowed-users* (make-hash-table :test 'equal))

(defun add-user (username userlevel);options => auto-op auto-voice auto-kick
  (setf (gethash username *allowed-users*) (make-user))
  (setf (user-level (gethash username *allowed-users*)) userlevel))

(defun set-user-level (username userlevel)
  (setf (user-level (gethash username *allowed-users*)) userlevel))

(defun set-auto-op (username)
 (setf (user-auto-op? (gethash username *allowed-users*)) 't))

(defun unset-auto-op (username)
 (setf (user-auto-op? (gethash username *allowed-users*)) 'nil))

(defun set-auto-voice (username)
 (setf (user-auto-voice? (gethash username *allowed-users*)) 't))

(defun unset-auto-voice (username)
 (setf (user-auto-voice? (gethash username *allowed-users*)) 'nil))

(defun set-auto-kick (username)
 (setf (user-auto-kick? (gethash username *allowed-users*)) 't))

(defun unset-auto-kick (username)
 (setf (user-auto-kick? (gethash username *allowed-users*)) 'nil))

(defun change-allowed-user-nick (oldnick newnick )
  (if (gethash oldnick *allowed-users*)
      (let ((level (user-level (gethash oldnick *allowed-users*)))
            (auto-op (user-auto-op? (gethash oldnick *allowed-users*)))
            (auto-kick (user-auto-kick? (gethash oldnick *allowed-users*)))
            (auto-voice (user-auto-voice? (gethash oldnick *allowed-users*))))
        (remhash oldnick *allowed-users*)
        (add-user newnick level)
        (setf (user-auto-op? (gethash newnick *allowed-users*))
              auto-op)
        (setf (user-auto-kick? (gethash newnick *allowed-users*))
              auto-kick)
        (setf (user-auto-voice? (gethash newnick *allowed-users*))
              auto-voice))))

(defun known-user (username)
  (gethash username *allowed-users*))

(defun allowed-user (username minlevel)
  (if (gethash username *allowed-users*)
      (>= (user-level (gethash username *allowed-users*)) minlevel)
    'nil))

(defun get-user-level (username)
  (user-level (gethash username *allowed-users*)))

(defun get-user-auto-op (username)
  (user-auto-op? (gethash username *allowed-users*)))

(defun get-user-auto-kick (username)
  (user-auto-kick? (gethash username *allowed-users*)))

(defun get-user-auto-voice (username)
  (user-auto-voice? (gethash username *allowed-users*)))



;;On join we auto-op auto-voice known users
(defparser "JOIN"
  (let ((nick (subseq prefix 1 (position #\! prefix)))
        (channel (string-left-trim ":" middle)))
    (if (known-user nick)
        (cond ((get-user-auto-kick nick) (kick nick channel))
              ((get-user-auto-voice nick) (voice nick channel))
              ((get-user-auto-op nick) (op nick channel))))))



;;Nick following to track users even if they changes their names !!!
(defparser "NICK"
  (let ((old-nick (subseq prefix 1 (position #\! prefix)))
        (new-nick (string-left-trim ":" middle)))
    (if (known-user old-nick)
        (change-allowed-user-nick old-nick new-nick))))


