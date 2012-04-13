(deftheme railscasts
  "Railscasts theme")

(custom-theme-set-faces
 'railscasts

 ;; Faces that aren't really "customized"
 '(bold ((t (:bold t))))
 '(bold-italic ((t (:italic t :bold t))))
 '(button ((t (:underine t))))
 '(italic ((t (:italic t))))
 '(underline ((t (:underline t))))

 ;; The basics
 '(default ((t (:foreground "#E6E1DC" :background "#232323"))))
 '(cursor ((t (:foreground "#FFFFFF"))))
 '(highlight ((t (:background "#333435"))))
 '(region ((t (:background "#5A647E"))))
 '(fringe ((t (:background "#2B2B2B"))))
 '(menu ((t (:foreground "#E6E1DC" :background "#232323"))))
 '(vertical-border ((t (:foreground "#5A647E"))))

 ;; Modeline
 '(modeline ((t (:background "#C2C2C2" :foreground "black"))))
 '(modeline-buffer-id ((t (:background "#C2C2C2" :foreground "black"))))
 '(modeline-mousable ((t (:background "#C2C2C2" :foreground "black"))))
 '(modeline-mousable-minor-mode ((t (:background "#C2C2C2" :foreground "black"))))

 ;; Minibuffer
 '(minibuffer-prompt ((t (:foreground "#BC9458"))))

 ;; font-lock
 '(font-lock-comment-face ((t (:foreground "#BC9458" :italic t))))
 '(font-lock-comment-delimiter-face ((t (:foreground "#BC9458" :italic t))))
 '(font-lock-doc-string-face ((t (:foreground "#BC9458" :italic t))))
 '(font-lock-string-face ((t (:foreground "#A5C261"))))
 '(font-lock-keyword-face ((t (:foreground "#CC7833"))))
 '(font-lock-builtin-face ((t (:foreground "#DA4939"))))
 '(font-lock-function-name-face ((t (:foreground "#FFC66D"))))
 '(font-lock-variable-name-face ((t (:foreground "#D0D0FF"))))
 '(font-lock-type-face ((t (:foreground "#FFFFFF"))))
 '(font-lock-constant-face ((t (:foreground "#6D9CBE"))))
 '(font-lock-preprocessor-face ((t (:foreground "#CC7833")))) 
 '(font-lock-warning-face ((t (:background "#990000" :foreground "#FFFFFF"))))
 '(c-annotation-face ((t (:inherit font-lock-constant-face))))

 ;; isearch
 '(isearch ((t (:background "#5A647E"))))
 '(isearch-fail ((t (:backgrond "#990000" :foreground "#FFFFFF"))))

 ;; external
 
 ;; auctex
 '(font-latex-bold-face ((t (:foreground nil :weight bold))))
 '(font-latex-italic-face ((t (:foreground nil :slant italic))))
 '(font-latex-string-face ((t (:foreground "#A5C261"))))
 '(font-latex-warning ((t (:inherit font-lock-warning-face))))
 '(font-latex-slide-title-face ((t (:inherit font-lock-type-face :weight normal :height 1.0))))

 ;; ido
 '(ido-only-match ((t (:foreground "#A5C261"))))
 '(ido-subdir ((t (:foreground "#DA4939"))))

 ;; show-paren-mode
 '(show-paren-match ((t (:background "#5A647E"))))
 '(show-paren-mismatch ((t (:background "#990000")))) 
)

(provide-theme 'railscasts)
