; -*- Mode: Emacs-Lisp; -*- 

(setq elmo-maildir-folder-path "~/Dropbox/Charles/Mail/"
      elmo-archive-folder-path "~/Dropbox/Charles/Mail/"

      wl-from "Charles Pence <charles@charlespence.net>"
      wl-forward-subject-prefix "Fwd: "

      wl-default-folder ".Personal/inbox"
      wl-draft-folder ".Personal/drafts"
      wl-trash-folder ".Personal/trash"
      wl-queue-folder ".Personal/outbox"
      wl-fcc ".Personal/sent"
      wl-fcc-force-as-read t
      
      wl-temporary-file-directory "~/Dropbox/Charles/Mail/"
      wl-icon-directory "~/.emacs.d/packages/wl/icons/"

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
      )

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

