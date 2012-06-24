
;; Holidays should be configured *before* we get Org mode set up
(require 'holidays)
(setq holiday-other-holidays '(
                               (holiday-fixed 2 2 "Darwin Day")
                               ))
(setq calendar-holidays (append holiday-general-holidays
                                holiday-local-holidays
                                holiday-other-holidays
                                holiday-christian-holidays
                                holiday-solar-holidays))


;; Org-mode
(add-to-list 'load-path "~/.emacs.d/packages/org-7.8.09")
(add-to-list 'load-path "~/.emacs.d/packages/org-7.8.09-contrib")

(require 'org-install)
(require 'org-capture)
(require 'org-contacts)

(add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))

(setq org-directory "~/Dropbox/Charles/Org/")
(setq org-default-notes-file (concat org-directory "Agenda/Inbox.org"))
(setq org-agenda-files (list (concat org-directory "Agenda/")))
(setq org-contacts-files (list (concat org-directory "Contacts.org")))

(global-set-key (kbd "<f11>") (lambda () (interactive) (org-agenda nil "n")))
(global-set-key (kbd "S-<f11>") 'org-capture)

(global-set-key (kbd "<f10>") (lambda () (interactive) (ido-find-file-in-dir (concat org-directory "Agenda"))))
(global-set-key (kbd "S-<f10>") (lambda () (interactive) (find-file (concat org-directory "Agenda/Inbox.org"))))

(global-set-key (kbd "S-<f12>") 'org-contacts)
(global-set-key (kbd "C-<f12>") (lambda () (interactive) (find-file (concat org-directory "Contacts.org"))))

(global-set-key (kbd "C-c l") 'org-store-link)
(global-set-key (kbd "C-c a") 'org-agenda)
(global-set-key (kbd "C-c b") 'org-iswitchb)

(setq org-log-done 'time
      org-use-fast-todo-selection t
      org-M-RET-may-split-line nil
      org-support-shift-select 'always
      org-agenda-buffer-name "Org: Agenda"
      org-agenda-ndays 7
      org-agenda-show-all-dates t
      org-agenda-skip-deadline-if-done t
      org-agenda-skip-scheduled-if-done t
      org-agenda-start-on-weekday nil
      org-agenda-skip-additional-timestamps-same-entry nil
      org-agenda-window-setup 'current-window
      org-refile-targets (quote ((nil :maxlevel . 9)
                                 (org-agenda-files :maxlevel . 9)))
      org-refile-use-outline-path 'file
      org-outline-path-complete-in-steps t
      org-refile-allow-creating-parent-nodes (quote confirm)
      org-completion-use-ido t
      org-attach-method 'cp
      calenar-date-mode 'iso
      bookmark-default-file "~/.emacs.d/cache/bookmarks"
      org-id-locations-file "~/.emacs.d/cache/org-id-locations")

(setq org-todo-keywords
      (quote ((sequence "TODO(t)" "NEXT(n)" "|" "DONE(d)")
              (sequence "WAITING(w)" "HOLD(h)" "|" "CANCELLED(c)"))))

(setq org-todo-keyword-faces
      (quote (("TODO" :foreground "#CC6666" :weight bold)
              ("NEXT" :foreground "#81A2BE" :weight bold)
              ("DONE" :foreground "#B5BD68" :weight bold)
              ("WAITING" :foreground "#DE935F" :weight bold)
              ("CANCELLED" :foreground "#F0C674" :weight bold))))

(setq org-agenda-custom-commands
      '(("n" "Agenda and next actions"
         ((todo "NEXT")
          (agenda "")))
        ("P" "Timestamped items in the past"
         ((tags "TIMESTAMP<=\"<now>\"")))))


;; Capture templates
(setq org-capture-templates
      '(("t" "Todo Item" entry (file (concat org-directory "Agenda/Inbox.org"))
         "* TODO %?")
        ("n" "Next Action" entry (file (concat org-directory "Agenda/Inbox.org"))
         "* NEXT %?")
        ("e" "Calendar Event" entry (file (concat org-directory "Agenda/Inbox.org"))
         "* %?\n  %^T")
        ("c" "Contacts" entry (file "~/Dropbox/Charles/Personal/Contacts.org")
         "* %(org-contacts-template-wl-name)\n  :PROPERTIES:\n  :EMAIL: %(org-contacts-template-wl-email)\n  :END:")))


;; Export settings
(setq org-export-latex-classes
      '(("cp-org-article"
"\\documentclass[12pt]{article}
\\usepackage{cpxearticle}
\\title{}
      [NO-DEFAULT-PACKAGES]
      [NO-PACKAGES]"
               ("\\section{%s}" . "\\section*{%s}")
               ("\\subsection{%s}" . "\\subsection*{%s}")
               ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
               ("\\paragraph{%s}" . "\\paragraph*{%s}")
               ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))
      org-latex-to-pdf-process '("latexmk -f -pdf -xelatex %f")
      org-export-latex-default-class "cp-org-article")

(defun cpence-org-mode-hook ()
  (interactive)

  ;; Patch up some variables
  (make-local-variable 'indent-line-function)
  (setq indent-line-function 'org-indent-line-function)

  ;; N.B. Do /not/ enable flyspell-mode here!  It overrides a few things
  ;; that are really important, like C-c $ for archive, and it makes it
  ;; unbearably slow to start up an agenda buffer.

  (require 'typopunct)
  (typopunct-change-language 'english)
  (typopunct-mode 1)
)
(add-hook 'org-mode-hook 'cpence-org-mode-hook)


;; Deft mode for Org-mode notes
(add-to-list 'load-path "~/.emacs.d/packages/deft.git")
(require 'deft)

(setq deft-extension "org")
(setq deft-directory (concat org-directory "Notes/"))
(setq deft-text-mode 'org-mode)

(global-set-key [f2] 'deft)


;; Google Maps integration (awesome)
(add-to-list 'load-path "~/.emacs.d/packages/google-maps.git")
(require 'google-maps)
(require 'org-location-google-maps)
