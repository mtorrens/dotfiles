;;
;; Support for opening an "Untitled" buffer on starting Emacs, offering
;; to save this buffer if it's been modified, and closing that buffer
;; automatically when opening a file from the file manager.
;;

;; Open an "Untitled" buffer when we start up, killing scratch, but then
;; kill that buffer if we open something from the file manager (thanks to
;; mortenee on StackOverflow on this)
(defun new-untitled-buffer ()
  "Opens a new empty buffer"
  (interactive)
  (let ((buf (generate-new-buffer "Untitled")))
    (switch-to-buffer buf)
    (funcall (and default-major-mode))
    (unless (plist-member (symbol-plist 'buffer-offer-save) 'permanent-local)
      (put 'buffer-offer-save 'permanent-local t))
    (setq buffer-offer-save t)
    (add-hook 'kill-buffer-query-functions
	      'switch-to-new-buffer-kill-buffer-query-function
	      nil
	      t)))

;; Thanks to Kevin Rodgers on EmacsWiki for this hook function, which
;; works perfectly.
(defun switch-to-new-buffer-kill-buffer-query-function ()
  (when (and (buffer-modified-p)
	     (yes-or-no-p (format "Buffer %s is modified; save? "
				  (buffer-name))))
    (save-buffer))
  ;; don't abort kill-buffer:
  t)

(defun cpence-close-scratch ()
  (kill-buffer "*scratch*")
  (if (not (delq nil (mapcar 'buffer-file-name (buffer-list))))
      (new-untitled-buffer)))
(add-hook 'emacs-startup-hook 'cpence-close-scratch)

(defun cpence-close-untitled ()
  (save-current-buffer
    (if (get-buffer "Untitled")
	(kill-buffer "Untitled"))))
(add-hook 'find-file-hook 'cpence-close-untitled)

