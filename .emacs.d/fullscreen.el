;;
;; The collected wisdom of the EmacsWiki Full Screen page.  Call
;; the best "real" full-screen toggle available.
;;

(if (system-type-is-darwin)
    (progn
      (require 'maxframe)
      (defvar cp-maxframe-p nil "Check if maxframe is on or off")))
(if (system-type-is-windows)
    (progn
      (require 'w32-fullscreen)
      (setq w32-fullscreen-toggletitle-cmd (concat user-emacs-directory "site-lisp/w32-fullscreen/w32toggletitle.py"))))

(defun cp-toggle-fullscreen ()
(interactive)
"Toggle true full-screen mode using the best method available"
(if (system-type-is-darwin)
    (if (fboundp 'ns-toggle-fullscreen)
	(ns-toggle-fullscreen)
      (progn
	(setq cp-maxframe-p (not cp-maxframe-p))
	(if cp-maxframe-p
	    (restore-frame)
	  (maximize-frame)))))
(if (system-type-is-windows)
    (w32-fullscreen))
(if (system-type-is-gnu)
    (shell-command "wmctrl -r :ACTIVE: -btoggle,fullscreen"))
)

