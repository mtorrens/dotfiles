
;; Emacs-Jabber
(add-to-list 'load-path "~/.emacs.d/packages/emacs-jabber-0.8.91")

(require 'jabber-autoloads)
(add-hook 'jabber-chat-mode-hook 'goto-address)

;; Disable debugging output (switch these on if trouble)
(setq fsm-debug nil
      jabber-debug-keep-process-buffers nil
      jabber-debug-log-xml nil)

;; Disable avatars
(setq jabber-vcard-avatars-retrieve nil
      jabber-vcard-avatars-publish nil
      jabber-chat-buffer-show-avatar nil)

;; Save history
(setq jabber-history-enabled t
      jabber-use-global-history nil
      jabber-history-dir "~/Dropbox/Charles/Mail/Chats/"
      jabber-backlog-number 10
      jabber-backlog-days 14
      jabber-history-enable-rotation t
      jabber-history-size-limit 1024)

;; Nice buffer names (things with * get clobbered by ido)
(setq jabber-chat-buffer-format "Jabber: %n"
      jabber-roster-buffer "Jabber: Roster")

;; Nice mode names
(add-hook 'jabber-chat-mode-hook (lambda () (setq mode-name "jc")))
(add-hook 'jabber-roster-mode-hook (lambda () (setq mode-name "jr")))

;; Nice buffer nicks
(setq jabber-activity-make-string
      (lambda (jid) (concat " [" (jabber-activity-make-string-default jid) "]")))


;; Make jabber.el notify through libnotify/growl when I get a new message
(setq jabber-message-alert-same-buffer nil)

(defun cp-jabber-todochiku-notify (from buf text proposed-alert)
  (when (or jabber-message-alert-same-buffer
            (not (memq (selected-window) (get-buffer-window-list buf))))
    (todochiku-message (format "%s" (jabber-jid-displayname from)) text
                       (todochiku-icon 'irc))))
(if (featurep 'todochiku) (add-hook 'jabber-alert-message-hooks 'cp-jabber-todochiku-notify))


;; Get the secrets file and load Jabber
(defun cp-start-jabber ()
  (interactive)
  (require 'secrets "~/.private/secrets.el.gpg")
  (jabber-connect-all))
(define-key jabber-global-keymap "\C-c" 'cp-start-jabber)
(global-set-key [f9] 'cp-start-jabber)
