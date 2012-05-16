(deftheme tomorrow-night
  "Tomorrow Night theme")


(let ( (tn-fg "#C5C8C6")
       (tn-bg "#1D1F21")
       (tn-cursor "#AEAFAD")
       (tn-curline "#282A2E")
       (tn-selection "#373B41")
       (tn-lowlight "#969896")
       (tn-green "#B5BD68")
       (tn-purple "#B294BB")
       (tn-blue "#81A2BE")
       (tn-red "#CC6666")
       (tn-yellow "#F0C674")
       (tn-orange "#DE935F")
       (tn-aqua "#8ABEB7")
       (tn-error-bg "#DF5F5F")
       (tn-error-fg "#CED1CF")
       )

  (custom-theme-set-faces
   'tomorrow-night
   
   ;; Faces that aren't really "customized"
   '(bold ((t (:bold t))))
   '(bold-italic ((t (:italic t :bold t))))
   '(button ((t (:underine t))))
   '(italic ((t (:italic t))))
   '(underline ((t (:underline t))))
   
   ;; The basics
   `(default ((t (:foreground ,tn-fg :background ,tn-bg))))
   `(cursor ((t (:foreground ,tn-cursor))))
   `(highlight ((t (:background ,tn-curline))))
   `(region ((t (:background ,tn-selection))))
   `(fringe ((t (:background ,tn-curline))))
   `(vertical-border ((t (:foreground ,tn-selection))))
   
   ;; Modeline
   `(modeline ((t (:background ,tn-curline :foreground ,tn-fg))))
   `(modeline-buffer-id ((t (:background ,tn-curline :foreground ,tn-fg))))
   `(modeline-mousable ((t (:background ,tn-curline :foreground ,tn-fg))))
   `(modeline-mousable-minor-mode ((t (:background ,tn-curline :foreground ,tn-fg))))
   
   ;; Minibuffer
   `(minibuffer-prompt ((t (:foreground ,tn-green))))
   
   ;; font-lock
   `(font-lock-comment-face ((t (:foreground ,tn-lowlight))))
   `(font-lock-comment-delimiter-face ((t (:foreground ,tn-lowlight))))
   `(font-lock-doc-string-face ((t (:foreground ,tn-lowlight))))
   `(font-lock-string-face ((t (:foreground ,tn-green))))
   `(font-lock-keyword-face ((t (:foreground ,tn-purple))))
   `(font-lock-builtin-face ((t (:foreground ,tn-blue))))
   `(font-lock-function-name-face ((t (:foreground ,tn-blue))))
   `(font-lock-variable-name-face ((t (:foreground ,tn-red))))
   `(font-lock-type-face ((t (:foreground ,tn-yellow))))
   `(font-lock-constant-face ((t (:foreground ,tn-orange))))
   `(font-lock-preprocessor-face ((t (:foreground ,tn-aqua))))
   `(font-lock-warning-face ((t (:background ,tn-error-bg :foreground ,tn-error-fg))))
   `(c-annotation-face ((t (:foreground ,tn-lowlight))))
   
   ;; isearch
   `(isearch ((t (:background ,tn-selection))))
   `(isearch-fail ((t (:background ,tn-error-bg :foreground ,tn-error-fg))))
   
   ;; flyspell
   `(flyspell-incorrect ((t (:foreground ,tn-error-bg :underline t :weight normal))))
   
   ;; external
   
   ;; auctex
   '(font-latex-bold-face ((t (:foreground nil :weight bold))))
   '(font-latex-italic-face ((t (:foreground nil :slant italic))))
   `(font-latex-string-face ((t (:foreground ,tn-green))))
   `(font-latex-warning ((t (:background ,tn-error-bg :foreground ,tn-error-fg))))
   `(font-latex-slide-title-face ((t (:foreground ,tn-yellow :weight normal :height 1.0))))
   
   ;; eshell
   `(eshell-prompt ((t (:foreground ,tn-green))))
   `(eshell-ls-archive ((t (:foreground ,tn-red))))
   `(eshell-ls-backup ((t (:foreground ,tn-lowlight))))
   `(eshell-ls-clutter ((t (:foreground ,tn-lowlight))))
   `(eshell-ls-directory ((t (:foreground ,tn-blue :weight bold))))
   `(eshell-ls-executable ((t (:foreground ,tn-green :weight bold))))
   `(eshell-ls-missing ((t (:foreground ,tn-error-fg :background ,tn-error-bg))))
   `(eshell-ls-product ((t (:foreground ,tn-lowlight))))
   `(eshell-ls-special ((t (:foreground ,tn-green))))
   `(eshell-ls-symlink ((t (:foreground ,tn-aqua))))
   
   ;; ido
   `(ido-only-match ((t (:foreground ,tn-green))))
   `(ido-subdir ((t (:foreground ,tn-red))))
   
   ;; jabber
   `(jabber-chat-prompt-local ((t (:foreground ,tn-blue :weight normal))))
   `(jabber-chat-prompt-foreign ((t (:foreground ,tn-red :weight normal))))
   `(jabber-chat-prompt-system ((t (:foreground ,tn-green :weight normal))))
   `(jabber-chat-error ((t (:background ,tn-error-bg :foreground ,tn-error-fg :weight bold))))
   `(jabber-rare-time-face ((t (:foreground ,tn-green :weight normal :underline t))))
   `(jabber-activity-face ((t (:foreground ,tn-blue :weight normal))))
   `(jabber-activity-personal-face ((t (:foreground ,tn-blue :weight normal))))
   `(jabber-roster-user-chatty ((t (:foreground ,tn-aqua :weight bold))))
   `(jabber-roster-user-online ((t (:foreground ,tn-aqua :weight normal))))
   `(jabber-roster-user-away ((t (:foreground ,tn-green :slant italic))))
   `(jabber-roster-user-xa ((t (:foreground ,tn-purple :slant italic))))
   `(jabber-roster-user-dnd ((t (:foreground ,tn-orange :slant italic))))
   `(jabber-roster-user-offline ((t (:foreground ,tn-selection :slant italic))))
   
   ;; message mode
   `(message-cited-text ((t (:foreground ,tn-lowlight))))
   `(message-header-name ((t (:foreground ,tn-green))))
   `(message-header-other ((t (:foreground ,tn-green))))
   `(message-header-to ((t (:foreground ,tn-blue :weight normal))))
   `(message-header-from ((t (:foreground ,tn-aqua))))
   `(message-header-cc ((t (:foreground ,tn-blue))))
   `(message-header-bcc ((t (:foreground ,tn-blue))))
   `(message-header-subject ((t (:foreground ,tn-aqua))))
   `(message-header-xheader ((t (:foreground ,tn-green))))
   `(message-mml ((t (:foreground ,tn-green))))
   `(message-separator ((t (:foreground ,tn-lowlight))))
   
   ;; org
   `(org-agenda-date-today ((t (:foreground ,tn-orange :weight bold))))
   `(org-agenda-date ((t (:foreground ,tn-blue))))
   `(org-agenda-date-weekend ((t (:foreground ,tn-aqua))))
   `(org-agenda-structure ((t (:foreground ,tn-lowlight))))
   '(org-archived ((t (:inherit default :foreground nil :weight bold))))
   `(org-date ((t (:foreground ,tn-blue))))
   `(org-deadline-announce ((t (:foreground ,tn-red))))
   `(org-done ((t (:bold t :foreground ,tn-green))))
   `(org-formula ((t (:foreground ,tn-yellow))))
   `(org-headline-done ((t (:foreground ,tn-green))))
   `(org-hide ((t (:foreground ,tn-bg))))
   `(org-level-1 ((t (:foreground ,tn-orange))))
   `(org-level-2 ((t (:foreground ,tn-yellow))))
   `(org-level-3 ((t (:foreground ,tn-blue))))
   `(org-level-4 ((t (:foreground ,tn-aqua))))
   `(org-level-5 ((t (:foreground ,tn-purple))))
   `(org-level-6 ((t (:foreground ,tn-red))))
   `(org-level-7 ((t (:foreground ,tn-orange))))
   `(org-level-8 ((t (:foreground ,tn-yellow))))
   `(org-link ((t (:foreground ,tn-yellow :underline t))))
   `(org-scheduled ((t (:foreground ,tn-green))))
   `(org-scheduled-previously ((t (:foreground ,tn-red))))
   `(org-scheduled-today ((t (:foreground ,tn-blue))))
   `(org-special-keyword ((t (:foreground ,tn-yellow))))
   `(org-table ((t (:foreground ,tn-green))))
   '(org-tag ((t (:bold t :weight bold))))
   `(org-time-grid ((t (:foreground ,tn-orange))))
   `(org-todo ((t (:bold t :weight bold :foreground ,tn-red))))
   `(org-upcoming-deadline ((t (:foreground ,tn-purple))))
   `(org-warning ((t (:bold t :weight bold :foreground ,tn-red :inherit nil))))
   
   ;; show-paren-mode
   `(show-paren-match ((t (:background ,tn-selection))))
   `(show-paren-mismatch ((t (:background ,tn-error-bg))))
   
   ;; wl (wanderlust)
   `(wl-highlight-action-argument-face ((t (:foreground ,tn-red))))
   `(wl-highlight-folder-few-face ((t (:foreground ,tn-red))))
   `(wl-highlight-folder-many-face ((t (:foreground ,tn-red))))
   `(wl-highlight-folder-path-face ((t (:foreground ,tn-orange))))
   `(wl-highlight-folder-unread-face ((t (:foreground ,tn-blue))))
   '(wl-highlight-folder-zero-face ((t (:inherit default :foreground nil))))
   `(wl-highlight-folder-unknown-face ((t (:foreground ,tn-blue))))
   `(wl-highlight-message-citation-header ((t (:foreground ,tn-red))))
   `(wl-highlight-message-cited-text-1 ((t (:foreground ,tn-red))))
   `(wl-highlight-message-cited-text-2 ((t (:foreground ,tn-green))))
   `(wl-highlight-message-cited-text-3 ((t (:foreground ,tn-blue))))
   `(wl-highlight-message-cited-text-4 ((t (:foreground ,tn-blue))))
   `(wl-highlight-message-header-contents-face ((t (:foreground ,tn-green))))
   `(wl-highlight-message-headers-face ((t (:foreground ,tn-red))))
   `(wl-highlight-message-important-header-contents ((t (:foreground ,tn-green))))
   `(wl-highlight-message-header-contents ((t (:foreground ,tn-green))))
   `(wl-highlight-message-important-header-contents2 ((t (:foreground ,tn-green))))
   `(wl-highlight-message-signature ((t (:foreground ,tn-green))))
   `(wl-highlight-message-unimportant-header-contents ((t (:foreground ,tn-selection))))
   `(wl-highlight-summary-answered-face ((t (:foreground ,tn-blue))))
   `(wl-highlight-summary-disposed-face ((t (:foreground ,tn-selection :slant italic))))
   `(wl-highlight-summary-new-face ((t (:foreground ,tn-blue))))
   '(wl-highlight-summary-normal-face ((t (:inherit default :foreground nil))))
   `(wl-highlight-summary-thread-top-face ((t (:foreground ,tn-yellow))))
   `(wl-highlight-thread-indent-face ((t (:foreground ,tn-purple))))
   `(wl-highlight-summary-refiled-face ((t (:foreground ,tn-selection))))
   '(wl-highlight-summary-displaying-face ((t (:underline t :weight bold))))
   ))

(provide-theme 'tomorrow-night)
