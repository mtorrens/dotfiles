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
  (setq auto-package-update-delete-old-versions t)
  (setq auto-package-update-hide-results t)
  (auto-package-update-maybe))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Basic UI
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(setq inhibit-splash-screen t)
(tool-bar-mode -1)
(menu-bar-mode -1)

;; Color and fonts
(use-package base16-theme
  :config
  (load-theme 'base16-ocean t))
(set-default-font "Fantasque Sans Mono-11")

;; Don't minimize/hide/bg with C-z, this does not play nice with i3
(global-unset-key (kbd "C-z"))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; File reading/saving
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(prefer-coding-system 'utf-8)
(setq backup-inhibited t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Code formatting
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(setq-default indent-tabs-mode nil)
(setq-default tab-width 2)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Modes for various file types
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package markdown-mode)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; TeX
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package tex
  :ensure auctex
  :config
  (setq TeX-auto-save t)
  (setq TeX-parse-self t)
  
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
  :config
  (define-key global-map "\C-cl" 'org-store-link))

