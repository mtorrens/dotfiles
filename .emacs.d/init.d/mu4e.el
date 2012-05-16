
;; mu4e
(add-to-list 'load-path "~/.emacs.d/packages/mu4e-0.9.8.4")
(require 'mu4e)
(require 'org-mu4e)

(global-set-key (kbd "<f12>") 'mu4e)

(setq mu4e-get-mail-command "~/bin/getallmail"
      mu4e-update-interval nil

      ;; I know these are internal, but I don't want asterisks at the
      ;; beginning of all my real mu4e buffer names, as that gets
      ;; them clobbered by ido
      mu4e~main-buffer-name "mu4e: Main"
      mu4e~headers-buffer-name "mu4e: Folder"
      mu4e~view-buffer-name "mu4e: View Message"
      mu4e~view-raw-buffer-name "mu4e: Raw Message"

      mu4e-maildir "~/Dropbox/Charles/Mail"
      mu4e-sent-folder "/Personal/sent"
      mu4e-drafts-folder "/Personal/drafts"
      mu4e-trash-folder "/Personal/trash"

      mu4e-attachment-dir "~/Downloads"

      mu4e-maildir-shortcuts '(("/Personal/inbox" . ?i)
                               ("/Personal/hold" . ?h)
                               ("/Personal/lists" . ?l)
                               ("/Personal/action" . ?a)
                               ("/Personal/archive" . ?x)
                               ("/Personal/storage/2012" . ?s)
                               ("/Personal/drafts" . ?d)
                               ("/Personal/trash" . ?t)
                               ("/Family/inbox" . ?f)
                               ("/Family/hold" . ?j))

      mu4e-bookmarks '(("flag:unread AND NOT flag:trashed" "Unread messages" ?u)
                       ("date:today..now" "Today's messages" ?t)
                       ("date:7d..now" "Last 7 days" ?w))

      user-mail-address "charles@charlespence.net"
      user-full-name "Charles Pence"
      mu4e-user-mail-address-regexp "charles@charlespence\.net\\|cpence@nd\.edu\\|cpence@gmail.com\\|cpence@princeton\.edu"

      mu4e-html2text-command "pandoc -f html -t org"
      mu4e-view-fields '(:from :to :cc :subject :date :attachments)

      mail-user-agent 'mu4e-user-agent)


;; Wrap mail buffers with longlines-mode; I don't want fill-region to be
;; applied as is mu4e's default behavior
(defadvice mu4e-view (after add-longlines-mode activate)
  "Turn on longlines mode in mail view buffers after loading."
  (longlines-mode 1))


;; Enable org-contacts
(setq mu4e-org-contacts-file (concat org-directory "Contacts.org"))
(add-to-list 'mu4e-headers-actions
             '("org-contact-add" ?o mu4e-action-add-org-contact) t)
(add-to-list 'mu4e-view-actions
             '("org-contact-add" ?o mu4e-action-add-org-contact) t)

;; Send mail through GMail
(require 'smtpmail)
(setq message-send-mail-function 'smtpmail-send-it
      starttls-use-gnutls t
      smtpmail-starttls-credentials '(("smtp.gmail.com" 587 nil nil))
      smtpmail-default-smtp-server "smtp.gmail.com"
      smtpmail-smtp-server "smtp.gmail.com"
      smtpmail-smtp-service 587
      auth-sources (list (expand-file-name "~/.private/authinfo.gpg")))
