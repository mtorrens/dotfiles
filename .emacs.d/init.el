;;; init.el
;;
;; cpence's emacs configuration
;;
;; N.B.: This is designed for Emacs 24 nightly builds; YMMV on Emacs 23
;; and earlier.
;;


;; -------------------------------------
;; Utility code

(load (concat user-emacs-directory "platform.el"))


;; -------------------------------------
;; Path variables

;; Lisp loading path
(let ((default-directory (concat user-emacs-directory "site-lisp/")))
  (normal-top-level-add-to-load-path '("."))
  (normal-top-level-add-subdirs-to-load-path))

;; Themes path
(add-to-list 'custom-theme-load-path (concat user-emacs-directory "themes"))

;; Customize tool output
(setq custom-file (concat user-emacs-directory "custom.el"))
(load custom-file)

;; Executable path
(add-dir-to-path "/usr/local/bin")
(if (system-type-is-darwin)
    (add-dir-to-path "/usr/texbin"))


;; -------------------------------------
;; File Output

(require 'recentf)
(setq recentf-save-file (concat user-emacs-directory "recentf"))
(recentf-mode 1)

(setq make-backup-files nil)
(setq auto-save-default nil)
(setq auto-save-list-file-prefix nil)

;; UTF-8 *everywhere*
(prefer-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-selection-coding-system 'utf-8)
(setq default-buffer-file-coding-system 'utf-8)
(setq x-select-request-type '(UTF8_STRING COMPOUND_TEXT TEXT STRING))
(if (system-type-is-windows)
    (set-clipboard-coding-system 'utf-16le-dos))


;; -------------------------------------
;; Aesthetics

(setq default-frame-alist
      (append
       (list
        '(width . 85)
        '(height . 35)
        '(cursor-type . bar)
        '(line-spacing . 1))
       default-frame-alist))

(setq inhibit-startup-message t)

(scroll-bar-mode -1)
(tool-bar-mode -1)
(tooltip-mode -1)

(set-frame-font "Panic Sans-14")
(load-theme 'Railscasts)

(blink-cursor-mode t)
(show-paren-mode t)

(fset 'yes-or-no-p 'y-or-n-p)

(column-number-mode t)


;; -------------------------------------
;; Load el-get packages

(load (concat user-emacs-directory "packages.el"))


;; -------------------------------------
;; Modernize editing

(delete-selection-mode t)
(transient-mark-mode 1)

(setq fill-column 80)


;; -------------------------------------
;; Keys

(cua-mode t)
(setq cua-auto-tabify-rectangles nil)
(setq cua-keep-region-after-copy t)

(global-set-key [home] 'beginning-of-line)
(global-set-key [end] 'end-of-line)
(global-set-key [kp-delete] 'delete-char)


;; -------------------------------------
;; Tabs

(setq-default tab-width 2)
(setq-default indent-tabs-mode nil)


;; -------------------------------------
;; Mode Hooks

(defun cpence-text-mode-hook ()
  (interactive)
  
  ;; Enable longlines-mode for text
  (longlines-mode 1)
)
(add-hook 'text-mode-hook 'cpence-text-mode-hook)
