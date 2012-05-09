
;; Emacs-Jabber
(add-to-list 'load-path "~/.emacs.d/packages/emacs-jabber-0.8.91")

(require 'jabber-autoloads)
(add-hook 'jabber-chat-mode-hook 'goto-address)

;; Disable avatars
(setq jabber-vcard-avatars-retrieve nil
      jabber-vcard-avatars-publish nil
      jabber-chat-buffer-show-avatar nil)


;; Make jabber.el notify through libnotify/growl when I get a new message
(setq jabber-message-alert-same-buffer nil)

(defun cp-jabber-todochiku-notify (from buf text proposed-alert)
  "(jabber.el hook) Notify of new Jabber chat messages via ToDoChiKu"
  (when (or jabber-message-alert-same-buffer
            (not (memq (selected-window) (get-buffer-window-list buf))))
    (if (jabber-muc-sender-p from)
        (todochiku-message (format "(PM) %s" (jabber-jid-displayname (jabber-jid-user from))) 
                           (format "%s: %s" (jabber-jid-resource from) text))
      (todochiku-message (format "%s" (jabber-jid-displayname from)) 
                         text))))

(if (featurep 'todochiku)
    (add-hook 'jabber-alert-message-hooks 'cp-jabber-todochiku-notify))

;; Same as above, for groupchats
(defun cp-jabber-muc-todochiku-notify (nick group buf text proposed-alert)
  "(jabber.el hook) Notify of new Jabber MUC messages via ToDoChiKu"
  (when (or jabber-message-alert-same-buffer
	    (not (memq (selected-window) (get-buffer-window-list buf))))
    (if nick
        (when (or jabber-muc-alert-self
                  (not (string= 
                        nick (cdr (assoc group *jabber-active-groupchats*)))))
          (todochiku-message (format "%s" (jabber-jid-displayname group))
                             (format "%s: %s" nick text)))
      (todochiku-message (format "%s" (jabber-jid-displayname group)) 
                         text))))

(if (featurep 'todochiku)
    (add-hook 'jabber-alert-muc-hooks 'cp-jabber-muc-todochiku-notify))


;; Get the secrets file and load Jabber
(defun cp-start-jabber ()
  (interactive)
  (require 'secrets "~/.private/secrets.el.gpg")
  (jabber-connect-all))
(define-key jabber-global-keymap "\C-c" 'cp-start-jabber)
(global-set-key [f8] 'cp-start-jabber)
