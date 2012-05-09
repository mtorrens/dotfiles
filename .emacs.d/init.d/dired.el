
;; Use ls-lisp if we're on Darwin, since we don't have ls --dired there
(if (string-equal system-type "darwin")
    (progn
      (require 'ls-lisp)
      (setq ls-lisp-use-insert-directory-program nil)))


;; Make the dired list bearably terse most of the time
(eval-after-load 'dired '(progn
                           (require 'dired-details)
                           (setq dired-details-hidden-string "")
                           (dired-details-install)))
