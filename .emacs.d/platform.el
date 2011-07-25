;;
;; Platform utilities
;;

;; This is an Emacs 24 hack, this function is used in some older packages
(defun make-local-hook (arg) nil)



;; Check if system is Darwin/Mac OS X
(defun system-type-is-darwin ()
  (interactive)
  "Return true if system is darwin-based (Mac OS X)"
  (string-equal system-type "darwin"))

;; Check if system is GNU/Linux
(defun system-type-is-gnu ()
  (interactive)
  "Return true if system is GNU/Linux-based"
  (string-equal system-type "gnu/linux"))

;; Check if system is Windows
(defun system-type-is-windows ()
  (interactive)
  "Return true if system is Windows-based"
  (string-equal system-type "windows-nt"))



;; Add directory to the executable path
(defun add-dir-to-path (dir)
  (interactive)
  "Add a directory to both exec-path and the PATH environment variable"
  (push dir exec-path)
  (setenv "PATH" (concat (getenv "PATH") (concat ":" dir))))


;; Fix the Mac OS X key bindings
(if (system-type-is-darwin)
    (progn
      (setq ns-command-modifier 'control)
      (global-set-key [C-left] 'beginning-of-line)
      (global-set-key [C-right] 'end-of-line)))

;; Fix dired on OS X
(if (system-type-is-darwin)
    (setq dired-use-ls-dired nil))

