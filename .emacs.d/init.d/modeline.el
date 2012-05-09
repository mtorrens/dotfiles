
;; Enable these so line and column numbers get updated appropriately
(line-number-mode t)
(column-number-mode t)


;; Shorten some of the mode names
(add-hook 'emacs-lisp-mode-hook (lambda() (setq mode-name "el")))
(add-hook 'dired-mode-hook (lambda() (setq mode-name "Dir")))
(add-hook 'org-mode-hook (lambda() (setq mode-name "Org")))
(add-hook 'text-mode-hook (lambda() (setq mode-name "txt")))


;; Tweak out the modeline
(setq cp-mode-line-filename
      (list
       '(:eval (propertize "%b" 'face 'font-lock-string-face
                           'help-echo (buffer-file-name)))
       '(:eval (when (buffer-modified-p)
                 (propertize "*" 'face 'font-lock-variable-name-face
                             'help-echo "Buffer has been modified")))
       " "))

(setq cp-mode-line-mode
      (list
       "["
       '(:eval (propertize mode-name 'face 'font-lock-constant-face))
       "] "))

(setq cp-mode-line-position
      (list
       "("
       (propertize "%02l" 'face 'font-lock-builtin-face) ","
       (propertize "%02c" 'face 'font-lock-builtin-face)
       ") "))

(setq global-mode-string '(wl-modeline-biff-status
                           wl-modeline-biff-state-on
                           wl-modeline-biff-state-off))

(setq cp-mode-line-time
      (list
       '(:eval (propertize (format-time-string "%H:%M")
                           'help-echo (concat (format-time-string "%c; ")
                                              (emacs-uptime "Uptime: %hh"))))))

(setq-default mode-line-format (list " "
                                     cp-mode-line-filename
                                     cp-mode-line-mode
                                     cp-mode-line-position
                                     "%M "
                                     cp-mode-line-time
                                     " %-"
                                     ))
