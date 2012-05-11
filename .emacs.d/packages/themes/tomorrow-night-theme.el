(deftheme tomorrow-night
  "Tomorrow Night theme")

(custom-theme-set-faces
 'tomorrow-night

 ;; Faces that aren't really "customized"
 '(bold ((t (:bold t))))
 '(bold-italic ((t (:italic t :bold t))))
 '(button ((t (:underine t))))
 '(italic ((t (:italic t))))
 '(underline ((t (:underline t))))

 ;; The basics
 '(default ((t (:foreground "#C5C8C6" :background "#1D1F21"))))
 '(cursor ((t (:foreground "#AEAFAD"))))
 '(highlight ((t (:background "#282A2E"))))
 '(region ((t (:background "#373B41"))))
 '(fringe ((t (:background "#282A2E"))))
 '(vertical-border ((t (:foreground "#373B41"))))

 ;; Modeline
 '(modeline ((t (:background "#2A2A2A" :foreground "#C5C8C6"))))
 '(modeline-buffer-id ((t (:background "#2A2A2A" :foreground "#C5C8C6"))))
 '(modeline-mousable ((t (:background "#2A2A2A" :foreground "#C5C8C6"))))
 '(modeline-mousable-minor-mode ((t (:background "#2A2A2A" :foreground "#C5C8C6"))))

 ;; Minibuffer
 '(minibuffer-prompt ((t (:foreground "#B5BD68"))))

 ;; font-lock
 '(font-lock-comment-face ((t (:foreground "#969896"))))
 '(font-lock-comment-delimiter-face ((t (:foreground "#969896"))))
 '(font-lock-doc-string-face ((t (:foreground "#969896"))))
 '(font-lock-string-face ((t (:foreground "#B5BD68"))))
 '(font-lock-keyword-face ((t (:foreground "#B294BB"))))
 '(font-lock-builtin-face ((t (:foreground "#81A2BE"))))
 '(font-lock-function-name-face ((t (:foreground "#81A2BE"))))
 '(font-lock-variable-name-face ((t (:foreground "#CC6666"))))
 '(font-lock-type-face ((t (:foreground "#F0C674"))))
 '(font-lock-constant-face ((t (:foreground "#DE935F"))))
 '(font-lock-preprocessor-face ((t (:foreground "#8ABEB7"))))
 '(font-lock-warning-face ((t (:background "#DF5F5F" :foreground "#CED1CF"))))
 '(c-annotation-face ((t (:inherit font-lock-constant-face))))

 ;; isearch
 '(isearch ((t (:background "#373B41"))))
 '(isearch-fail ((t (:background "#DF5F5F" :foreground "#CED2CF"))))

 ;; flyspell
 '(flyspell-incorrect ((t (:foreground "#DF5F5F" :underline t :weight normal))))
 
 ;; external
 
 ;; auctex
 '(font-latex-bold-face ((t (:foreground nil :weight bold))))
 '(font-latex-italic-face ((t (:foreground nil :slant italic))))
 '(font-latex-string-face ((t (:foreground "#B5BD68"))))
 '(font-latex-warning ((t (:inherit font-lock-warning-face))))
 '(font-latex-slide-title-face ((t (:inherit font-lock-type-face :weight normal :height 1.0))))

 ;; eshell
 '(eshell-prompt ((t (:inherit font-lock-string-face :foreground nil))))
 '(eshell-ls-archive ((t (:inherit font-lock-variable-name-face :foreground nil))))
 '(eshell-ls-backup ((t (:inherit font-lock-comment-face :foreground nil))))
 '(eshell-ls-clutter ((t (:inherit font-lock-comment-face :foreground nil))))
 '(eshell-ls-directory ((t (:inherit font-lock-builtin-face :foreground nil :weight bold))))
 '(eshell-ls-executable ((t (:inherit font-lock-string-face :foreground nil :weight bold))))
 '(eshell-ls-missing ((t (:inherit font-lock-warning-face :foreground nil))))
 '(eshell-ls-product ((t (:inherit font-lock-comment-face :foreground nil))))
 '(eshell-ls-special ((t (:inherit font-lock-string-face :foreground nil))))
 '(eshell-ls-symlink ((t (:inherit font-lock-preprocessor-face :foreground nil))))

 ;; ido
 '(ido-only-match ((t (:foreground "#B5BD68"))))
 '(ido-subdir ((t (:foreground "#CC6666"))))

 ;; jabber
 '(jabber-chat-prompt-local ((t (:foreground "#81A2BE" :weight normal))))
 '(jabber-chat-prompt-foreign ((t (:foreground "#CC6666" :weight normal))))
 '(jabber-chat-prompt-system ((t (:foreground "#B5BD68" :weight normal))))
 '(jabber-chat-error ((t (:background "#DF5F5F" :foreground "#CED2CF" :weight bold))))
 '(jabber-rare-time-face ((t (:foreground "#B5BD68" :weight normal :underline t))))
 '(jabber-activity-face ((t (:foreground "#81A2BE" :weight normal))))
 '(jabber-activity-personal-face ((t (:foreground "#81A2BE" :weight normal))))
 '(jabber-roster-user-chatty ((t (:foreground "#8ABEB7" :weight bold))))
 '(jabber-roster-user-online ((t (:foreground "#81A2BE" :weight normal))))
 '(jabber-roster-user-away ((t (:foreground "#B5BD68" :slant italic))))
 '(jabber-roster-user-xa ((t (:foreground "#B5BD68" :slant italic))))
 '(jabber-roster-user-dnd ((t (:foreground "#DE935F" :slant italic))))
 '(jabber-roster-user-offline ((t (:foreground "#373B41" :slant italic))))

 ;; org
 '(org-agenda-date-today ((t (:inherit font-lock-constant-face :foreground nil :weight bold))))
 '(org-agenda-date ((t (:inherit font-lock-builtin-face :foreground nil))))
 '(org-agenda-date-weekend ((t (:inherit font-lock-preprocessor-face :foreground nil))))
 '(org-agenda-structure ((t (:inherit font-lock-comment-face :foreground nil))))
 '(org-archived ((t (:inherit default :foreground nil :weight bold))))
 '(org-date ((t (:inherit font-lock-builtin-face :foreground nil))))
 '(org-deadline-announce ((t (:inherit font-lock-variable-name-face :foreground nil))))
 '(org-done ((t (:inherit font-lock-string-face :bold t :foreground nil))))
 '(org-formula ((t (:inherit font-lock-type-face :foreground nil))))
 '(org-headline-done ((t (:inherit font-lock-string-face :foreground nil))))
 '(org-hide ((t (:foreground "#1D1F21"))))
 '(org-level-1 ((t (:inherit font-lock-constant-face :foreground nil))))
 '(org-level-2 ((t (:inherit font-lock-type-face :foreground nil))))
 '(org-level-3 ((t (:inherit font-lock-builtin-face :foreground nil))))
 '(org-level-4 ((t (:inherit font-lock-preprocessor-face :foreground nil))))
 '(org-level-5 ((t (:inherit font-lock-builtin-face :foreground nil))))
 '(org-level-6 ((t (:inherit font-lock-builtin-face :foreground nil))))
 '(org-level-7 ((t (:inherit font-lock-builtin-face :foreground nil))))
 '(org-level-8 ((t (:inherit font-lock-builtin-face :foreground nil))))
 '(org-link ((t (:inherit font-lock-type-face :foreground nil :underline t))))
 '(org-scheduled ((t (:inherit font-lock-string-face :foreground nil))))
 '(org-scheduled-previously ((t (:inherit font-lock-variable-name-face :foreground nil))))
 '(org-scheduled-today ((t (:inherit font-lock-builtin-face :foreground nil))))
 '(org-special-keyword ((t (:inherit font-lock-type-face :foreground nil))))
 '(org-table ((t (:inherit font-lock-string-face :foreground nil))))
 '(org-tag ((t (:bold t :weight bold))))
 '(org-time-grid ((t (:inherit font-lock-constant-face :foreground nil))))
 '(org-todo ((t (:bold t :weight bold :inherit font-lock-variable-name-face :foreground nil))))
 '(org-upcoming-deadline ((t (:inherit font-lock-keyword-face))))
 '(org-warning ((t (:bold t :weight bold :inherit font-lock-variable-name-face :foreground nil))))

 ;; show-paren-mode
 '(show-paren-match ((t (:background "#373B41"))))
 '(show-paren-mismatch ((t (:background "#DF5F5F"))))

 ;; wl (wanderlust)
 '(wl-highlight-action-argument-face ((t (:inherit font-lock-variable-name-face :foreground nil))))
 '(wl-highlight-folder-few-face ((t (:inherit font-lock-variable-name-face :foreground nil))))
 '(wl-highlight-folder-many-face ((t (:inherit font-lock-variable-name-face :foreground nil))))
 '(wl-highlight-folder-path-face ((t (:inherit font-lock-constant-face :foreground nil))))
 '(wl-highlight-folder-unread-face ((t (:inherit font-lock-builtin-face :foreground nil))))
 '(wl-highlight-folder-zero-face ((t (:inherit default :foreground nil))))
 '(wl-highlight-folder-unknown-face ((t (:inherit font-lock-builtin-face :foreground nil))))
 '(wl-highlight-message-citation-header ((t (:inherit font-lock-variable-name-face :foreground nil))))
 '(wl-highlight-message-cited-text-1 ((t (:inherit font-lock-variable-name-face :foreground nil))))
 '(wl-highlight-message-cited-text-2 ((t (:inherit font-lock-string-face :foreground nil))))
 '(wl-highlight-message-cited-text-3 ((t (:inherit font-lock-builtin-face :foreground nil))))
 '(wl-highlight-message-cited-text-4 ((t (:inherit font-lock-builtin-face :foreground nil))))
 '(wl-highlight-message-header-contents-face ((t (:inherit font-lock-string-face :foreground nil))))
 '(wl-highlight-message-headers-face ((t (:inherit font-lock-variable-name-face :foreground nil))))
 '(wl-highlight-message-important-header-contents ((t (:inherit font-lock-string-face :foreground nil))))
 '(wl-highlight-message-header-contents ((t (:inherit font-lock-string-face :foreground nil))))
 '(wl-highlight-message-important-header-contents2 ((t (:inherit font-lock-string-face :foreground nil))))
 '(wl-highlight-message-signature ((t (:inherit font-lock-string-face :foreground nil))))
 '(wl-highlight-message-unimportant-header-contents ((t (:foreground "#373B41"))))
 '(wl-highlight-summary-answered-face ((t (:inherit font-lock-builtin-face :foreground nil))))
 '(wl-highlight-summary-disposed-face ((t (:foreground "#373B41"
                                                       :slant italic))))
 '(wl-highlight-summary-new-face ((t (:inherit font-lock-builtin-face :foreground nil))))
 '(wl-highlight-summary-normal-face ((t (:inherit default :foreground nil))))
 '(wl-highlight-summary-thread-top-face ((t (:inherit font-lock-type-face :foreground nil))))
 '(wl-highlight-thread-indent-face ((t (:foreground "#B294BB"))))
 '(wl-highlight-summary-refiled-face ((t (:foreground "#373B41"))))
 '(wl-highlight-summary-displaying-face ((t (:underline t :weight bold))))
)

(provide-theme 'tomorrow-night)
