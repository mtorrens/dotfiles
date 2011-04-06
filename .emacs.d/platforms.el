;;
;; Code to detect various platforms running Emacs
;;

;; Check if system is Darwin/Mac OS X
(defun system-type-is-darwin ()
(interactive)
"Return true if system is darwin-based (Mac OS X)"
(string-equal system-type "darwin")
)

;; Check if system is GNU/Linux
(defun system-type-is-gnu ()
(interactive)
"Return true if system is GNU/Linux-based"
(string-equal system-type "gnu/linux")
)

;; Check if system is Win32
(defun system-type-is-windows ()
(interactive)
(string-equal system-type "windows-nt")
)
