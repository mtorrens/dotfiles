;; -*-mode: Emacs-Lisp-*- 
;;;
;; Copyright (C) 2009-2010  Charles Pence
;;
;; Includes some things from the .emacs of DJCB:
;;   Copyright (C) 1996-2009  Dirk-Jan C. Binnema.
;;   URL: http://www.djcbsoftware.nl/dot-emacs.html

;; This file is free software licensed under the terms of the
;; GNU General Public License, version 3 or later.

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; loadpath; this will recursivel add all dirs in 'elisp-path' to load-path 
(defconst elisp-path '("~/.emacs.d/elisp/")) ;; my elisp directories
(mapcar '(lambda(p)
           (add-to-list 'load-path p) 
           (cd p) (normal-top-level-add-subdirs-to-load-path)) elisp-path)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Window configuration

;; Modeline
(line-number-mode t)
(column-number-mode t)
(display-time-mode -1)

;; Give me a reasonable window size
(if window-system
    (setq default-frame-alist
	  '(
	    (width             . 120)
	    (height            . 45)
	    (left              . 0)
	    (top               . 0)
	    (cursor-type       . bar)
	    )
	  )
)

;; Change title bar to ~/file-directory if the current buffer is a
;; real file or buffer name if it is just a buffer.
(setq frame-title-format 
      '(:eval 
        (if buffer-file-name 
            (replace-regexp-in-string (getenv "HOME") "~"
				      buffer-file-name)
          (buffer-name))))

;; Disable tool, scroll, menu bars if they're available
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))

;; Activate mouse if not in a windowing system
(if (not window-system) (xterm-mouse-mode t))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; General settings

;; Set the PATH to include various OS X locations
(setenv "PATH" (concat "/opt/local/bin:/usr/texbin:" (getenv "PATH")))
(setq exec-path (cons "/usr/texbin" exec-path))
(setq exec-path (cons "/opt/local/bin" exec-path))

;; Show the mark, and enable deletion
(transient-mark-mode t)
(delete-selection-mode t)

;; Smooth scrolling
(require 'smooth-scrolling)

;; Enable font highlighting, always
(global-font-lock-mode t)
(setq font-lock-support-mode 'jit-lock-mode)
(setq jit-lock-stealth-time 1)

;; Save files in UTF-8 unless told otherwise
(prefer-coding-system 'utf-8)
(setq locale-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-selection-coding-system 'utf-8)
(setq default-buffer-file-coding-system 'utf-8)
(set-language-environment "UTF-8")
(set-input-method nil)

;; Highlight the current line if we're in a window system
(if window-system
    (global-hl-line-mode 1))

;; Set the font to fixed-with by default, and we'll use
;; proportional occasionally below.
(if window-system
    (progn
	  (set-face-font 'default "Droid Sans Mono-13")
	  (set-face-font 'variable-pitch "Sabon LT Std-16")))

;; Kill silly splash screens/messages
(setq inhibit-splash-screen t)
(setq inhibit-startup-message t)
(setq inhibit-startup-echo-area-message t)
(defalias 'yes-or-no-p 'y-or-n-p)

;; Kill backups and auto-saves
(setq backup-inhibited t)
(setq auto-save-default nil)

;; Name duplicate buffers something reasonable
(require 'uniquify)
(setq uniquify-buffer-name-style 'reverse)
(setq uniquify-separator "|")
(setq uniquify-after-kill-buffer-p t)
(setq uniquify-ignore-buffers-re "^\\*")

;; Show unfinished multi-keystrokes quickly
(setq echo-keystrokes 0.1)

;; Make C-x b not suck
(iswitchb-mode t)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Color theme settings

;; Hilight opposing parenthesis -- load before the color theme, which will
;; set the color for it
(require 'paren)
(setq show-paren-style 'parenthesis)
(show-paren-mode t)

;; If we're not in a window system, rely on the terminal emulator to set our
;; color scheme
(if window-system
    (progn
      (require 'color-theme)
      (color-theme-initialize)
      (setq color-theme-is-global t)
	  (color-theme-pence)
      ))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; External program launching (in ansi-term), other utility functions for keys

;; Disable a handful of things in ansi-term mode
(defadvice term-char-mode (after term-char-mode-fixes ())
  (set (make-local-variable 'transient-mark-mode) nil)
  (set (make-local-variable 'global-hl-line-mode) nil)
  (setq term-scroll-to-bottom-on-output nil)
  (ad-activate 'term-char-mode))

(defun djcb-term-start-or-switch (prg &optional use-existing)
  "* run program PRG in a terminal buffer. If USE-EXISTING is non-nil "
  " and PRG is already running, switch to that buffer instead of starting"
  " a new instance."
  (interactive)
  (delete-other-windows)
  (let ((bufname (concat "*" prg "*")))
    (when (not (and use-existing
                 (let ((buf (get-buffer bufname)))
                   (and buf (buffer-name (switch-to-buffer bufname))))))
      (ansi-term prg prg))))

(defmacro djcb-program-shortcut (name key &optional use-existing)
  "* macro to create a key binding KEY to start some terminal program PRG; 
    if USE-EXISTING is true, try to switch to an existing buffer"
  `(global-set-key ,key 
     '(lambda()
        (interactive)
        (djcb-term-start-or-switch ,name ,use-existing))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Key bindings

;; Goto-line should be where I expect it
(global-set-key (kbd "M-g") 'goto-line)

;; Home and end should work, please
(global-set-key [s-left] 'beginning-of-line)
(global-set-key [s-right] 'end-of-line)
(global-set-key [home] 'beginning-of-line)
(global-set-key [end] 'end-of-line)

;; As should delete
(global-set-key [kp-delete] 'delete-char)

;; Go to start and end
(global-set-key [C-prior] (lambda()(interactive)(goto-char (point-min))))
(global-set-key [C-next]  (lambda()(interactive)(goto-char (point-max))))

;; Compilation shortcut
(global-set-key (kbd "<f7>") 'compile)

;; Ignore Control-Z
(global-set-key (kbd "C-z") nil)

;; Bind smart-quotes mode
(require 'smart-quotes)
(global-set-key (kbd "<f12>") 'smart-quotes-mode)

;; Productivity: bash
(djcb-program-shortcut "bash" (kbd "<f1>") t)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; File completion settings

;; Some great code (thanks StackOverflow!) for making .tex file completion much
;; more painless
(defadvice find-file-read-args (around find-file-read-args-limit-choices activate)

  "set some stuff up for controlling extensions when tab completing"
  (let ((completion-ignored-extensions completion-ignored-extensions)

        (find-file-limit-choices t))

    ad-do-it))

(defadvice minibuffer-complete (around minibuffer-complete-limit-choices nil activate)

  "When in find-file, check for files of extension .tex, and if they're found, ignore TeX auto-generated outputs"
  (let ((add-or-remove
	 (if (and (boundp 'find-file-limit-choices) find-file-limit-choices

		  (save-excursion
		    (let ((b (progn (beginning-of-line) (point)))
			  (e (progn (end-of-line) (point))))
		      (directory-files (file-name-directory (buffer-substring-no-properties b e)) nil "\\.tex$"))))

	     'add-to-list
	   'remove)))

      (setq completion-ignored-extensions
	    (funcall add-or-remove 'completion-ignored-extensions
	       '(".aux" ".bbl" ".blg" ".dvi" ".log" ".nav" ".out" ".pdf" ".snm" ".toc" ".gz")))
    )

  ad-do-it)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Persistent recent files information

(require 'recentf)
(setq recentf-save-file "~/.emacs.d/recentf"
      recentf-max-saved-items 500
      recentf-menu-items 60)
(recentf-mode t)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Configuration for all buffers that are text-related at all

(defun cpence-all-text-mode-hook ()
  (interactive)
  
  ;; Add a huge fringe so we get a nice buffer width
  ;;(make-local-variable 'left-fringe-width)
  ;;(setq left-fringe-width 275)
  ;;(make-local-variable 'right-fringe-width)
  ;;(setq right-fringe-width 275)
)

(add-hook 'text-mode-hook 'cpence-all-text-mode-hook)
(add-hook 'LaTeX-mode-hook 'cpence-all-text-mode-hook)
(add-hook 'html-mode-hook 'cpence-all-text-mode-hook)
(add-hook 'outline-mode-hook 'cpence-all-text-mode-hook)
(add-hook 'lisp-interaction-mode-hook 'cpence-all-text-mode-hook)
(add-hook 'emacs-lisp-mode-hook 'cpence-all-text-mode-hook)
(add-hook 'c-mode-common-hook 'cpence-all-text-mode-hook)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Text mode configuration

;; This is from the Emacs mailing list, where I'm told it's the Wrong Thing to do
;; for RTL languages, but I don't much care.
(defun visual-line-line-range ()
  (save-excursion
    (cons (progn (vertical-motion 0) (point))
	  (progn (vertical-motion 1) (point))))) 

(require 'word-count)

(defun cpence-text-mode-hook ()
  (interactive)
  
  ;; Set visual-line-mode (soft line wrapping)
  (visual-line-mode t)
  
  ;; Fix hl-line-mode
  (set (make-local-variable 'hl-line-range-function) 'visual-line-line-range)
  
  ;; Rebind keys to work with visual lines
  (local-set-key [s-left] 'beginning-of-visual-line)
  (local-set-key [s-right] 'end-of-visual-line)
  (local-set-key [home] 'beginning-of-visual-line)
  (local-set-key [end] 'end-of-visual-line)
  
  ;; Enable word-count-mode
  (word-count-mode)
  (word-count-set-region-off)
  (mell-marker-set 'word-count-marker-beginning (point-min))
  (mell-sign-marker word-count-marker-beginning word-count-marker-face)
  
  ;; Load the right spelling dictionary and bind a spell-check
  ;; key
  (ispell-change-dictionary "american")
  (setq ispell-program-name "aspell")
  (local-set-key (kbd "<f9>") 'ispell-buffer)
  
  ;; If we're using visual-line-mode, I want proportional fonts
  ;;(variable-pitch-mode t)
  ;;(set 'line-spacing 7)
  )

(add-hook 'text-mode-hook 'cpence-text-mode-hook)
(add-hook 'LaTeX-mode-hook 'cpence-text-mode-hook)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; TeX mode configuration
(load "auctex.el" nil t t)
(load "preview-latex.el" nil t t)

(setq TeX-parse-self t)
(setq TeX-auto-save t)
(setq TeX-auto-local ".auctex/")
(setq TeX-style-local ".auctex/")
(setq TeX-save-query nil)
(setq TeX-show-compilation nil)

(autoload 'tex-wcount-mode "tex-wcount.el")



(defun cpence-tex-mode-hook ()
  (interactive)

  ;; Set the output view style to just call "open"
  (setq TeX-view-program-list (quote (("open" "open %o"))))
  (setq TeX-view-program-selection (quote ((output-pdf "open") (output-html "open"))))
  
  ;; Add XeLaTeX
  (add-to-list 'TeX-command-list '("XeLaTeX" "%`xelatex -output-driver='xdvipdfmx -q -E'%(mode)%' %t" TeX-run-LaTeX nil t))

  ;; Add my build script
  (add-to-list 'TeX-command-list '("BuildTeX (CP)" "~/bin/buildtex %t" TeX-run-LaTeX nil t))

  ;; Set the default TeX command
  (setq TeX-command-default "BuildTeX (CP)")
  
  ;; Use PDF output
  (TeX-PDF-mode 1)

  ;; More curly-quote support
  (font-latex-add-quotes '("“" "”"))
  )

(add-hook 'LaTeX-mode-hook 'cpence-tex-mode-hook)
(add-hook 'LaTeX-mode-hook 'tex-wcount-mode)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; C/C++/etc. mode configuration
(require 'cc-mode)

(setq-default c-basic-offset 4)
(setq cua-auto-tabify-rectangles nil)

(defadvice align (around smart-tabs activate)
  (let ((indent-tabs-mode nil)) ad-do-it))

(defadvice align-regexp (around smart-tabs activate)
  (let ((indent-tabs-mode nil)) ad-do-it))

(defadvice indent-relative (around smart-tabs activate)
  (let ((indent-tabs-mode nil)) ad-do-it))

(defadvice indent-according-to-mode (around smart-tabs activate)
  (let ((indent-tabs-mode indent-tabs-mode))
    (if (memq indent-line-function
	      '(indent-relative
		indent-relative-maybe))
	(setq indent-tabs-mode nil))
    ad-do-it))

(defmacro smart-tabs-advice (function offset)
  (defvaralias offset 'tab-width)
  `(defadvice ,function (around smart-tabs activate)
     (cond
      (indent-tabs-mode
       (save-excursion
	 (beginning-of-line)
	 (while (looking-at "\t*\\( +\\)\t+")
	   (replace-match "" nil nil nil 1)))
       (setq tab-width tab-width)
       (let ((tab-width fill-column)
	     (,offset fill-column))
	 ad-do-it))
      (t
       ad-do-it))))

(smart-tabs-advice c-indent-line c-basic-offset)
(smart-tabs-advice c-indent-region c-basic-offset)

(setq-default tab-width 4)
(setq-default indent-tabs-mode t)

(setq-default c-default-style "bsd")

(defun cpence-c-mode-hook ()
  (interactive)
  
  ;; Not sure which one of these I want to use yet
  (c-toggle-auto-state 1)
  
  ;;(define-key c-mode-base-map (kbd "RET") 'newline-and-indent)
)

(add-hook 'c-mode-common-hook 'cpence-c-mode-hook)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; YASnippet configuration
(require 'yasnippet)

(yas/initialize)
(yas/load-directory "~/.emacs.d/snippets")
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Markdown mode configuration
(autoload 'markdown-mode "markdown-mode.el"
  "Major mode for editing Markdown files" t)
(setq auto-mode-alist
      (cons '("\\.markdown" . markdown-mode) auto-mode-alist))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Last thing: reset the default directory to ~
(setq default-directory "~/")
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

