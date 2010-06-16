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
	    (width             . 181)
	    (height            . 50)
	    (left              . 0)
	    (top               . 0)
	    (cursor-type       . bar)
	    (left-fringe       . 0)
	    (right-fringe      . 0)
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

;; If we're in a window system, disable the toolbar and scroll bar
(if window-system
    (progn
      (tool-bar-mode -1)
      (set-scroll-bar-mode nil)))

;; If we're not in a window system, disable the menu bar, activate mouse
(if (not window-system)
    (progn
      (menu-bar-mode -1)
      (xterm-mouse-mode t)))

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
(set-language-environment "UTF-8")
(set-input-method nil)

;; Highlight the current line if we're in a window system
(if window-system
    (global-hl-line-mode 1))

;; Proper fonts
(if window-system
    (set-face-font 'default "Inconsolata-14"))

;; Kill silly splash screens/messages
(setq inhibit-splash-screen t)
(setq inhibit-startup-message t)
(setq inhibit-startup-echo-area-message t)

;; Kill backups and auto-saves
(setq backup-inhibited t)
(setq auto-save-default nil)
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
      (require 'zenburn)
      (color-theme-initialize)
      (setq color-theme-is-global t)
      (color-theme-zenburn)
      
      ;; Enable this to cycle through color themes
      ;;(require 'doremi-cmd)
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

;; For some reason, this version of the code needs to be used on some versions of Emacs...
;;
;;    (mapc (lambda (e) (setq completion-ignored-extensions
;;			    (funcall add-or-remove 'completion-ignored-extensions e)))
;;	  '(".aux" ".bbl" ".blg" ".dvi" ".log" ".nav" ".out" ".pdf" ".snm" ".toc" ".gz"))

;; While this code needs to be used on other versions of Emacs...
;;
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
  (make-local-variable 'left-fringe-width)
  (setq left-fringe-width 275)
  (make-local-variable 'right-fringe-width)
  (setq right-fringe-width 275)
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

