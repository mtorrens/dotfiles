;;; init.el
;;
;; cpence's emacs configuration
;;
;; N.B.: This is designed for Emacs 24 nightly builds; YMMV on Emacs 23
;; and earlier.
;;

;; Utilities for custom configuration on Mac/Linux
;; Check if system is Darwin/Mac OS X
(defun system-type-is-darwin ()
(interactive)
"Return true if system is darwin-based (Mac OS X)"
(string-equal system-type "darwin")
)

;; Check if system is GNU/Linux
(defun system-type-is-gnu ()
(interactive)
"Return true if system is GNU/Linux-based"
(string-equal system-type "gnu/linux")
)

;; Lisp path
(let ((default-directory "~/.emacs.d/site-lisp/"))
  (normal-top-level-add-to-load-path '("."))
  (normal-top-level-add-subdirs-to-load-path))
(add-to-list 'load-path "~/.emacs.d/el-get")

;; Themes path
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")

;; Executable path (and PATH)
(push "/usr/local/bin" exec-path)
(setenv "PATH" (concat "/usr/local/bin:" (getenv "PATH")))
(if (system-type-is-darwin)
    (progn
      (push "/usr/texbin" exec-path)
      (setenv "PATH" (concat "/usr/texbin:" (getenv "PATH")))))

;; Custom path
(setq custom-file "~/.emacs.d/custom.el")
(load custom-file)

;; .emacs.d bits
(load "~/.emacs.d/packages.el")

;; ----------------------------------------------------
;; Emacs GUI

;; Disable splash screen
(setq inhibit-splash-screen t)

;; Quick y/n prompts
(fset 'yes-or-no-p 'y-or-n-p)

;; Disable menubar if in the terminal
(if (not window-system) (menu-bar-mode -1) (menu-bar-mode 1))

;; Disable scroll bar, tool bar, fringe, tooltips
(toggle-scroll-bar -1)
(tool-bar-mode -1)
(set-fringe-style -1)
(tooltip-mode -1)

;; Line and column numbers
(line-number-mode t)
(column-number-mode t)

;; Make the region and cursor act like they should
(delete-selection-mode t)
(blink-cursor-mode t)

;; Show parens
(show-paren-mode t)

;; Tab bar mode
;;(dolist (func '(tabbar-mode tabbar-forward-tab tabbar-forward-group tabbar-backward-tab tabbar-backward-group))
;;(autoload func "tabbar" "Tabs at the top of buffers and easy control-tab navigation"))
;;(tabbar-mode 1)

;; ----------------------------------------------------
;; File saving

;; Don't make backups
(setq make-backup-files nil)
(setq auto-save-list-file-prefix nil)
(setq auto-save-default nil)
(setq delete-auto-save-files t)

;; Deal correctly with newlines
(setq next-line-add-newlines nil)
(setq require-final-newline t)

;; ----------------------------------------------------
;; Fonts and Colors

;; Load color theme
(load-theme 'Railscasts)

;; Enable maximum font-lock goodness
(if window-system
    (progn
      (setq font-lock-maximum-decoration t)
      (add-hook 'after-init-hook
		(global-font-lock-mode t))))

;; Set font
(set-frame-font "Panic Sans-14:antialias=subpixel")

;; ----------------------------------------------------
;; Keys

;; Set the OS X command-key to Control
(if (system-type-is-darwin)
    (setq mac-command-modifier 'ctrl)
)

;; Switch tabs (on the Mac keys)

