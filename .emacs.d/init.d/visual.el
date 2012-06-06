
;; Default window settings
(setq default-frame-alist
      '((width . 115)
        (height . 40)
        (cursor-type . bar)
        (font . "Meslo LG M-13")))

(scroll-bar-mode 1)
(set-scroll-bar-mode 'right)

(tool-bar-mode -1)
(tooltip-mode -1)
(set-fringe-style -1)
(blink-cursor-mode t)

(setq ns-pop-up-frames nil)


;; Color theme, with rainbow-mode for editing the theme
(add-to-list 'custom-theme-load-path "~/.emacs.d/packages/themes")
(add-to-list 'custom-theme-load-path "~/.emacs.d/packages/color-theme-solarized.git")
(load-theme 'tomorrow-night)
(require 'rainbow-mode)


;; Fill Column Indicator mode
(add-to-list 'load-path "~/.emacs.d/packages/fill-column-indicator.git")
(autoload 'fci-mode "fill-column-indicator" nil t)
(setq fci-rule-color "#282A2E")


;; Save buffer positions
(require 'saveplace)
(setq-default save-place t)
(setq save-place-file "~/.emacs.d/cache/places")


;; Make buffer names unique when there's multiple identical filenames
(require 'uniquify)
(setq uniquify-buffer-name-style 'post-forward-angle-brackets)


;; Scrolling
(mouse-wheel-mode t)
(require 'smooth-scrolling)


;; Fix the minibuffer
(fset 'yes-or-no-p 'y-or-n-p)
(setq enable-recursive-minibuffers t
      max-mini-window-height .25
      minibuffer-scroll-window nil
      resize-mini-windows nil)


;; Various other variables for highlighting and decorating things in
;; useful and nonobtrusive ways
(show-paren-mode t)

(setq inhibit-startup-message t
      inhibit-splash-screen t
      visible-bell t
      echo-keystrokes 0.1
      font-lock-maximum-decoration t
      xterm-mouse-mode t
      search-highlight t
      query-replace-highlight t
      confirm-kill-emacs 'y-or-n-p)
