;;; init.el
;;
;; cpence's emacs configuration
;;
;; N.B.: This is designed for Emacs 24 nightly builds; YMMV on Emacs 23
;; and earlier.
;;

;; Lisp path
(let ((default-directory (concat user-emacs-directory "site-lisp/")))
  (normal-top-level-add-to-load-path '("."))
  (normal-top-level-add-subdirs-to-load-path))

;; Local lisp pieces
(load (concat user-emacs-directory "platforms.el"))
(load (concat user-emacs-directory "fullscreen.el"))


;; Themes path
(add-to-list 'custom-theme-load-path (concat user-emacs-directory "themes"))

;; Executable path (and PATH)
(push "/usr/local/bin" exec-path)
(setenv "PATH" (concat "/usr/local/bin:" (getenv "PATH")))
(if (system-type-is-darwin)
    (progn
      (push "/usr/texbin" exec-path)
      (setenv "PATH" (concat "/usr/texbin:" (getenv "PATH")))))

;; Custom path
(setq custom-file (concat user-emacs-directory "custom.el"))
(load custom-file)


;; ----------------------------------------------------
;; Load all external packages

;; auctex (currently CVS 20110402)
(load "auctex.el" nil t t)
(load "preview-latex.el" nil t t)

;; darkroom-mode (currently HG 20100708, patched to use my personal
;; cp-toggle-fullscreen function)
(require 'darkroom-mode)

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

;; WriteRoom emulation on F11
(global-set-key [f11] 'darkroom-mode)
