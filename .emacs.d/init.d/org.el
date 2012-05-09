
;; Org-mode
(add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))

(global-set-key [f11] (lambda () (interactive) (org-agenda nil "n")))
(global-set-key [f9] (lambda () (interactive) (find-file "~/Dropbox/Charles/Personal/Org/Agenda/")))

(global-set-key [f10] 'org-agenda)
(global-set-key (kbd "C-c a") 'org-agenda)

(global-set-key "\C-cl" 'org-store-link)

(setq org-directory "~/Dropbox/Charles/Org/")
(setq org-agenda-files '("~/Dropbox/Charles/Org/Agenda/"))
(setq org-default-notes-file (concat org-directory "Agenda/Inbox.org"))

(setq org-log-done 'time
      org-use-fast-todo-selection t
      org-M-RET-may-split-line nil
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
)
(add-hook 'org-mode-hook 'cpence-org-mode-hook)

