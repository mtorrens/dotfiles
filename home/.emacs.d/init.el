;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Bootstrap and package management configuration
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Set this, but don't load it; I'm using use-package rather than the internal
;; dependency management in package.el.
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))

;; Bootstrap package.el and MELPA
(require 'package)
(setq package-enable-at-startup nil)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/"))

(package-initialize)

;; Bootstrap use-package
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(eval-when-compile
  (require 'use-package))
(setq use-package-always-ensure t)

;; Bootstrap auto-updating
(use-package auto-package-update
  :config
  (setq auto-package-update-delete-old-versions t
        auto-package-update-hide-results t)
  (auto-package-update-maybe))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Basic UI
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(setq inhibit-splash-screen t)
(tool-bar-mode -1)
(menu-bar-mode -1)

(setq line-number-mode t)
(column-number-mode 1)

;; Color and fonts
(use-package base16-theme
  :config
  (load-theme 'base16-ocean t))
(set-default-font "SauceCodePro Nerd Font Mono:pixelsize=14:style=Medium")
(setq-default line-spacing 2)

;; Usual key bindings that match every other app on earth
(cua-mode t)
(setq cua-auto-tabify-rectangles nil
      cua-keep-region-after-copy t)

;; Show selections, parentheses, highlight current line
(transient-mark-mode 1)
(delete-selection-mode 1)
(show-paren-mode 1)
(global-hl-line-mode)

;; Don't minimize/hide/bg with C-z, this does not play nice with i3
(global-unset-key (kbd "C-z"))

;; Enable undo and redo on normal key bindings
(use-package undo-tree
  :config (global-undo-tree-mode)
  :bind (("C-z" . undo-tree-undo)
         ("C-S-z" . undo-tree-redo)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; File reading/saving
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(prefer-coding-system 'utf-8)

(setq backup-inhibited t
      make-backup-files nil
      auto-save-default nil)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Code formatting
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(setq-default indent-tabs-mode nil
              tab-width 2)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Notes
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package markdown-mode
  :commands (markdown-mode gfm-mode)
  :mode (("README\\.md\\'" . gfm-mode)
         ("\\.md\\'" . markdown-mode)
         ("\\.markdown\\'" . markdown-mode))
  :config (setq markdown-asymmetric-header t))

(use-package deft
  :bind ("<f12>" . deft)
  :commands (deft)
  :config (setq deft-directory "~/Dropbox/Charles/Work/Research Notes"
                deft-extensions '("md")
                deft-default-extension "md"
                deft-recursive t
                deft-use-filename-as-title nil
                deft-use-filter-string-for-filename t
                deft-markdown-mode-title-level 1))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; TeX
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package tex
  :ensure auctex
  :config
  (setq TeX-auto-save t
        TeX-parse-self t)
  
  (add-to-list 'TeX-view-program-list '("xreader-custom" "xreader %o" "xreader") t)
  (setq TeX-view-program-selection '(((output-dvi has-no-display-manager)
				                              "dvi2tty")
				                             ((output-dvi style-pstricks)
				                              "dvips and gv")
				                             (output-dvi "xdvi")
				                             (output-pdf "xreader-custom")
				                             (output-html "xdg-open")))

  (add-hook 'LaTeX-mode-hook (function (lambda ()
                                         (setq TeX-PDF-mode t)
                                         (setq TeX-command-default "LatexMk")))))

(use-package auctex-latexmk
  :config
  (setq auctex-latexmk-inherit-TeX-PDF-mode t)
  (auctex-latexmk-setup))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Org
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package org
  :init
  (setq org-replace-disputed-keys t)
  :config
  (define-key global-map "\C-cl" 'org-store-link))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Editing for non-code files
;;
;; If it's not code, enable visual-line-mode and center up the display using the
;; fringes.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package adaptive-wrap)
(use-package visual-fill-column
  :config
  (setq visual-fill-column 80))

(defun text-editing-mode ()
  ;; Enable visual-line-mode, and have it respect indentation (like org-mode)
  (visual-line-mode 1)
  (visual-fill-column-mode 1)
  (adaptive-wrap-prefix-mode 1)

  ;; Re-enable hl-line-mode
  (hl-line-mode 1))

(add-hook 'markdown-mode-hook 'text-editing-mode)
(add-hook 'LaTeX-mode-hook 'text-editing-mode)
(add-hook 'org-mode-hook 'text-editing-mode)
