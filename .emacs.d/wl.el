; -*- Mode: Emacs-Lisp; -*- 
(require 'elmo-search)

(setq elmo-maildir-folder-path "~/Dropbox/Charles/Mail/"
      elmo-archive-folder-path "~/Dropbox/Charles/Mail/"
      elmo-lost+found-folder ".Personal/lost+found"

      elmo-passwd-life-time nil
      elmo-passwd-alist-file-name "~/.private/elmo-passwd.gpg"

      wl-from "Charles Pence <charles@charlespence.net>"
      wl-user-mail-address-list '("charles@charlespence.net"
                                  "cpence@nd.edu"
                                  "cpence@gmail.com")
      
      wl-forward-subject-prefix "Fwd: "

      wl-default-folder ".Personal/inbox"
      wl-draft-folder ".Personal/drafts"
      wl-trash-folder ".Personal/trash"
      wl-queue-folder ".Personal/outbox"
      wl-fcc ".Personal/sent"
      wl-summary-showto-folder-regexp "\..*/sent.*"
      wl-fcc-force-as-read t

      wl-biff-check-folder-list '(".Personal/inbox" ".Personal/lists"
                                  ".Family/inbox")
      wl-biff-check-interval 60
      wl-biff-use-idle-timer t
      wl-mode-line-display-priority-list '(title)

      ssl-certificate-verification-policy 1
      wl-smtp-connection-type 'starttls
      wl-smtp-posting-port 587
      wl-smtp-authenticate-type "plain"
      wl-smtp-posting-user "charles@charlespence.net"
      wl-smtp-posting-server "smtp.gmail.com"
      
      mime-edit-split-message nil
      default-mime-charset-for-write 'utf-8
      default-mime-charset 'utf-8
      wl-draft-reply-buffer-style 'keep

      wl-temporary-file-directory "~/Dropbox/Charles/Mail/"
      wl-icon-directory "~/.emacs.d/packages/wl/icons/"
      wl-highlight-body-too t
      wl-use-highlight-mouse-line nil

      ;; I won't much use refile in the family account, but when I do it's
      ;; probably to put a message into the Hold folder.
      wl-refile-rule-alist '(
                             (("To" "Cc" "Delivered-To")
                              ("julia\.and@charlespence\.net" . ".Family/hold")
                              ("." . ".Personal/storage/2012")))

      ;; For offlineimap with GMail, we just want to delete the messages outright,
      ;; not trash them.
      wl-dispose-folder-alist '(("\.Family" . remove)
                                ("\.Personal" . trash))

      ;; Don't check the storage folders unless I tell you to do it manually.
      wl-auto-uncheck-folder-list '("\.Personal/storage")

      ;; Set up the summary buffer
      wl-summary-line-format "%T%P%1@ %t%[%20(%c %f%) %] %50(%s%) %h:%m %M/%D/%Y"
      wl-summary-width 110
      wl-thread-insert-opened t
      wl-thread-open-reading-thread t
      
      ;; Set all the headers
      wl-message-ignored-field-list '("^.*:")
      wl-message-visible-field-list '("^To:"
                                      "^Cc:"
                                      "^From:"
                                      "^Subject:"
                                      "^Date:")
      wl-message-sort-field-list '("^From:"
                                   "^To:"
                                   "^Cc:"
                                   "^Date:"
                                   "^Subject:")
      )

;; Sort appropriately
(defun wl-summary-overview-entity-compare-by-rdate (x y)
  (not (wl-summary-overview-entity-compare-by-date x y)))
(add-to-list 'wl-summary-sort-specs 'rdate)

(defun cp-wl-summary-sort-hook ()
  (wl-summary-rescan "rdate"))
(add-hook 'wl-summary-prepared-hook 'cp-wl-summary-sort-hook)

;; Enable mu search
(elmo-search-register-engine
 'mu 'local-file
 :prog "mu"
 :args '("find" pattern "-o" "plain" "-f" "l")
 :charset 'utf-8)

(setq elmo-search-default-engine 'mu
      wl-default-spec "[")

;; Invert behaviour of with and without argument replies. (AKA: Default to
;; reply-to-author, rather than reply-all.)
(setq wl-draft-reply-without-argument-list
      '(("Reply-To" ("Reply-To") nil nil)
        ("Mail-Reply-To" ("Mail-Reply-To") nil nil)
        ("From" ("From") nil nil)))
(setq wl-draft-reply-with-argument-list
      '(("Followup-To" nil nil ("Followup-To"))
        ("Mail-Followup-To" ("Mail-Followup-To") nil ("Newsgroups"))
        ("Reply-To" ("Reply-To") ("To" "Cc" "From") ("Newsgroups"))
        ("From" ("From") ("To" "Cc") ("Newsgroups"))))

;; Link up the BBDB
(require 'bbdb-wl)
(bbdb-wl-setup)
(require 'mime-bbdb)

(add-hook 'wl-mail-setup-hook 'bbdb-insinuate-sendmail)

;; Auto-mail-check
(add-hook 'wl-init-hook 'wl-biff-start)

