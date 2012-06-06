
;; Enable these so line and column numbers get updated appropriately
(line-number-mode t)
(column-number-mode t)
(setq line-number-display-limit nil
      line-number-display-limit-width 99999999)

;; Set up the time display
(setq display-time-24hr-format t
      display-time-default-load-average nil)
(display-time-mode t)


;; Tweak out the modeline
(setq cp-mode-line-filename
      (list
       '(:eval (propertize "%b" 'face 'font-lock-string-face
                           'help-echo (buffer-file-name)))
       '(:eval (when (buffer-modified-p)
                 (propertize "*" 'face 'font-lock-variable-name-face
                             'help-echo "Buffer has been modified")))
       " "))

;; Shorten lots of mode names
(defvar cp-mode-shorten-alist
  '(("Fundamental" . "")
    ("Emacs-Lisp" . "el")
    ("Lisp Interaction" . "eli")
    ("Org-mode" . "Org")
    ("Org-Agenda.*" . "OrgA")
    ("Dired" . "Dir")
    ("Text" . "txt")
    ("Markdown" . "md")
    ("\\(La\\)?TeX.*" . "TeX")
    ("jabber-chat" . "jc")
    ("jabber-roster" . "jr")
    ("Ruby" . "rb")
    ("mu4e.main" . "m4m")
    ("mu4e.headers" . "m4h")
    ("mu4e.view" . "m4v")
    ("mu4e.compose" . "m4c")))

(defun cp-get-short-mode-name ()
  (or
   (assoc-default (format-mode-line mode-name) cp-mode-shorten-alist 'string-match)
   (format-mode-line mode-name)))

(setq cp-mode-line-mode
      (list
       "["
       '(:eval (propertize (cp-get-short-mode-name) 'face 'font-lock-constant-face))
       "] "))

(setq cp-mode-line-position
      (list
       "("
       (propertize "%02l" 'face 'font-lock-builtin-face) ","
       (propertize "%02c" 'face 'font-lock-builtin-face)
       ") "))

;; Hook some other packages into the modeline
(setq global-mode-string '((t jabber-activity-mode-string)
                           " "
                           display-time-string))

(setq-default mode-line-format (list " "
                                     cp-mode-line-filename
                                     cp-mode-line-mode
                                     cp-mode-line-position
                                     "%M %-"
                                     ))
