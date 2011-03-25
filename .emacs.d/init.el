;;; init.el
;;
;; cpence's emacs configuration
;;

;; Add everything in my elisp directories
(let ((default-directory "~/.emacs.d/site-lisp/"))
  (normal-top-level-add-to-load-path '("."))
  (normal-top-level-add-subdirs-to-load-path))

;; ----------------------------------------------------
;; Emacs GUI

;; Disable splash screen
(setq inhibit-splash-screen t)

;; Disable menubar if in the terminal
(if (not window-system) (menu-bar-mode -1) (menu-bar-mode 1))

;; Disable scroll bar, tool bar
(scroll-bar-mode nil)
(tool-bar-mode nil)

;; Line and column numbers
(line-number-mode t)
(column-number-mode t)

;; ----------------------------------------------------
;; File saving

;; Don't make backups
(setq make-backup-files nil)

;; Deal correctly with newlines
(setq next-line-add-newlines nil)
(setq require-final-newline t)

;; ----------------------------------------------------
;; Fonts and Colors

;; Load color theme
(require 'color-theme-autoloads "color-theme-autoloads")
(color-theme-initialize)
(load-file "~/.emacs.d/site-lisp/color-theme/themes/color-theme-railscasts.el")
(color-theme-railscasts)

;; Enable maximum font-lock goodness
(if window-system
    (progn
      (setq font-lock-maximum-decoration t)
      (add-hook 'after-init-hook
		(global-font-lock-mode t))))

;; Set font
(set-face-font 'default "Panic Sans-14:antialias=subpixel")

;; ----------------------------------------------------
;; Keys

;; 