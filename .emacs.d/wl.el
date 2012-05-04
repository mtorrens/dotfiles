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

      wl-refile-rule-alist '(
                             (("To" "Cc" "Delivered-To")
                              ("julia\.and@charlespence\.net" . ".Family/all_mail")
                              ("." . ".Personal/storage/2012")))
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

