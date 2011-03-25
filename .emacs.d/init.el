;;; init.el
;;
;; cpence's emacs configuration
;;

;; Add everything in my elisp directories
(let ((default-directory "~/.emacs.d/site-lisp/"))
  (normal-top-level-add-to-load-path '("."))
  (normal-top-level-add-subdirs-to-load-path))

;; Disable splash screen, file backups
(setq inhibit-splash-screen t)
(setq make-backup-files nil)

;; Load color theme
(require 'color-theme-autoloads "color-theme-autoloads")
(color-theme-initialize)
(load-file "~/.emacs.d/site-lisp/color-theme/themes/color-theme-railscasts.el")
(color-theme-railscasts)

