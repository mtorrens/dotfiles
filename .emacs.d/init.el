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

;; Utility code used throughout
(load (concat user-emacs-directory "platforms.el"))

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

;; Recent files path
(require 'recentf)
(setq recentf-save-file "~/.emacs.d/recentf"
      recentf-max-saved-items 500
      recentf-menu-items 60)
(recentf-mode t)


;; ----------------------------------------------------
;; Load all external packages

;; YASnippet (currently SVN 20110412)
(require 'yasnippet)
(yas/initialize)
(yas/load-directory (concat user-emacs-directory "snippets"))

;; auctex (currently CVS 20110402)
(load "auctex.el" nil t t)
(load "preview-latex.el" nil t t)

;; darkroom-mode (currently HG 20100708, patched to use my personal
;; cp-toggle-fullscreen function)
(require 'darkroom-mode)

;; Tab bar mode (CVS from Debian, patched extensively)
(dolist (func '(tabbar-mode tabbar-forward-tab tabbar-forward-group tabbar-backward-tab tabbar-backward-group))
  (autoload func "tabbar" "Tabs at the top of buffers and easy control-tab navigation"))
(tabbar-mode 1)

;; TextMate mode (Git 2/22/11)
(require 'textmate)

;; Autopair mode (SVN 3/13/11)
(require 'autopair)
(autopair-global-mode)

;; Markdown Mode (currently git 20110410, m-m 1.7)
(autoload 'markdown-mode "markdown-mode.el"
   "Major mode for editing Markdown files" t)
(add-to-list 'auto-mode-alist '("\\.markdown" . markdown-mode))

;; Haml mode
(autoload 'haml-mode "haml-mode.el" "Major mode for editing Haml files" t)
(add-to-list 'auto-mode-alist '("\\.haml" . haml-mode))

;; RHTML mode
(autoload 'rhtml-mode "rhtml-mode.el" "Major mode for editing RHTML files" t)
(add-to-list 'auto-mode-alist '("\\.erb\\'" . rhtml-mode))
(add-to-list 'auto-mode-alist '("\\.rjs\\'" . rhtml-mode))

;; Yaml mode
(autoload 'yaml-mode "yaml-mode.el" "Major mode for editing YAML files" t)
(add-to-list 'auto-mode-alist '("\\.yml" . yaml-mode))
(add-to-list 'auto-mode-alist '("\\.yaml" . yaml-mode))

;; Sass mode
(autoload 'sass-mode "sass-mode.el" "Major mode for editing SASS files" t)
(add-to-list 'auto-mode-alist '("\\.sass" . sass-mode))
(add-to-list 'auto-mode-alist '("\\.scss" . sass-mode))

;; Ruby mode
(add-to-list 'auto-mode-alist '("Capfile" . ruby-mode))
(add-to-list 'auto-mode-alist '("Gemfile" . ruby-mode))
(add-to-list 'auto-mode-alist '("Rakefile" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.rake\\'" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.rb\\'" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.ru\\'" . ruby-mode))

;; ----------------------------------------------------
;; Other parts of my dot-emacs

(load (concat user-emacs-directory "fullscreen.el"))
(load (concat user-emacs-directory "untitled.el"))
(if (system-type-is-darwin) (load (concat user-emacs-directory "mac.el")))

;; ----------------------------------------------------
;; Emacs GUI

;; Disable splash screen
(setq inhibit-splash-screen t)
(setq inhibit-startup-message t)
(setq inhibit-startup-echo-area-message t)

;; Quick y/n prompts
(fset 'yes-or-no-p 'y-or-n-p)

;; Disable menubar if in the terminal
(if (not window-system) (menu-bar-mode -1) (menu-bar-mode 1))

;; Disable scroll bar, tool bar, fringe, tooltips
(toggle-scroll-bar -1)
(tool-bar-mode -1)
(tooltip-mode -1)

;; Line and column numbers
(line-number-mode t)
(column-number-mode t)

;; Make the region and cursor act like they should
(delete-selection-mode 1)
(blink-cursor-mode nil)
(transient-mark-mode 1)

;; Set the default GUI size
(if window-system
    (setq default-frame-alist
	  '(
	    (width             . 90)
	    (height            . 35)
	    (left              . 100)
	    (top               . 24)
	    (cursor-type       . bar)
	    )
	  )
)

;; Show parens
(show-paren-mode t)

;; All tabs in one group, and don't show tabs for special Emacs buffers
(setq tabbar-buffer-groups-function
      (lambda () (list "All Buffers")))
(setq tabbar-buffer-list-function
      (lambda ()
	(remove-if
	 (lambda(buffer)
	   (find (aref (buffer-name buffer) 0) " *"))
	 (buffer-list))))
(setq tabbar-tab-label-function
      (lambda (tab)
        (let ((label (format "  %s  " (tabbar-tab-value tab))))
           ;; Unless the tab bar auto scrolls to keep the selected tab
           ;; visible, shorten the tab label to keep as many tabs as possible
           ;; in the visible area of the tab bar.
           (if tabbar-auto-scroll-flag
               label
             (tabbar-shorten
              label (max 1 (/ (window-width)
                              (length (tabbar-view
                                       (tabbar-current-tabset))))))))))


;; ----------------------------------------------------
;; File saving

;; Don't make backups
(setq make-backup-files nil)
(setq auto-save-list-file-prefix nil)
(setq auto-save-default nil)
(setq delete-auto-save-files t)

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
      (setq font-lock-support-mode 'jit-lock-mode)
      (setq jit-lock-stealth-time 1)
      (setq font-lock-maximum-decoration t)
      (add-hook 'after-init-hook
		(global-font-lock-mode t))))

;; Set font
(if window-system
    (set-frame-font "Panic Sans-14:antialias=subpixel"))

;; ----------------------------------------------------
;; Keys

;; Push C-x to C-= and C-c to C--
(global-set-key (kbd "C-=") 'Control-X-prefix)
(global-set-key (kbd "C--") 'mode-specific-command-prefix)

;; Fix home, end, delete
(global-set-key [s-left] 'beginning-of-line)
(global-set-key [s-right] 'end-of-line)
(global-set-key [home] 'beginning-of-line)
(global-set-key [end] 'end-of-line)
(global-set-key [kp-delete] 'delete-char)

;; Control-pgup and pgdn
(global-set-key [C-prior] (lambda()(interactive)(goto-char (point-min))))
(global-set-key [C-next]  (lambda()(interactive)(goto-char (point-max))))

;; Set a bunch of things to emulate TextMate/Mac programs
(global-set-key (kbd "C-l") 'goto-line)
(global-set-key (kbd "C-o") 'find-file)
(global-set-key (kbd "C-{") 'tabbar-backward-tab)
(global-set-key (kbd "C-}") 'tabbar-forward-tab)
(global-set-key (kbd "C-f") 'isearch-forward)
(define-key isearch-mode-map (kbd "C-f") 'isearch-repeat-forward)
(global-set-key (kbd "C-s") 'save-buffer)
(global-set-key (kbd "C-S-s") 'save-some-buffers)
(global-set-key (kbd "C-a") 'mark-whole-buffer)
(global-set-key (kbd "C-w") 'kill-buffer) ;; FIXME: should this be less interactive?
(global-set-key (kbd "C-c") 'clipboard-kill-ring-save)
(global-set-key (kbd "C-x") 'clipboard-kill-region)
(global-set-key (kbd "C-v") 'clipboard-yank)
(global-set-key (kbd "C-q") 'save-buffers-kill-terminal)
(global-set-key (kbd "C-z") 'undo)


;; WriteRoom emulation on F11
(global-set-key [f11] 'darkroom-mode)


;; ----------------------------------------------------
;; Default to 2-space, no-tab tabs
(setq-default tab-width 2)
(setq-default indent-tabs-mode nil)


;; ----------------------------------------------------
;; Global text mode configuration

;; This should be the right way to do this, even for RTL languages.  Idea
;; taken from a bad solution on the Emacs mailing list, implementation
;; adapted from highline.el.
(defun visual-line-line-range ()
  (save-excursion
    (cons (progn (beginning-of-visual-line) (point))
	  (progn (beginning-of-visual-line 2) (point)))))

(defun cpence-text-mode-hook ()
  (interactive)
  
  ;; TextMate mode in all text-based buffers
  (textmate-mode)
  
  ;; Enable soft line wrapping
  (visual-line-mode t)
  
  ;; Fix hl-line-mode with visual-line-mode
  (if (window-system)
      (progn
	(hl-line-mode t)
	(set (make-local-variable 'hl-line-range-function) 'visual-line-line-range)))
  
  ;; Rebind keys to work with visual lines
  (local-set-key [s-left] 'beginning-of-visual-line)
  (local-set-key [s-right] 'end-of-visual-line)
  (local-set-key [home] 'beginning-of-visual-line)
  (local-set-key [end] 'end-of-visual-line)
)
(add-hook 'text-mode-hook 'cpence-text-mode-hook)

;; ----------------------------------------------------
;; TeX mode configuration

(defun cpence-latex-mode-hook ()
  (interactive)

  ;; Add BuildTex script
  (add-to-list 'TeX-command-list '("XeLaTeX" "%`xelatex -output-driver='xdvipdfmx -q -E'%(mode)%' %t" TeX-run-LaTeX nil t))
  (add-to-list 'TeX-command-list '("BuildTeX" "~/bin/buildtex %t" TeX-run-LaTeX nil t))
  (setq TeX-command-default "BuildTeX")
  
  ;; Curly quotes support
  (font-latex-add-quotes '("“" "”"))
  
  ;; BuildTeX is making PDF files
  (TeX-PDF-mode 1)
  
  ;; Bind the TeX building and viewing commands
  (local-set-key (kbd "C-r") 'TeX-command-master)
  (local-set-key [f7] 'TeX-command-master)
  (local-set-key (kbd "C-S-r") 'TeX-view)
  (local-set-key [f5] 'TeX-view)
)
(add-hook 'LaTeX-mode-hook 'cpence-latex-mode-hook)

;; ----------------------------------------------------
;; All programming modes
(defun cpence-language-mode-hook ()
  (interactive)

  ;; TextMate mode in all code buffers
  (textmate-mode)
)

;; There's no "general" mode-hook that handles all of the
;; programming modes, so we have to set all these hooks
;; ourselves.
(add-hook 'c-mode-common-hook 'cpence-language-mode-hook)
(add-hook 'css-mode-hook 'cpence-language-mode-hook)
(add-hook 'ruby-mode-hook 'cpence-language-mode-hook)
(add-hook 'emacs-lisp-mode-hook 'cpence-language-mode-hook)
(add-hook 'asm-mode-hook 'cpence-language-mode-hook)
(add-hook 'xml-mode-hook 'cpence-language-mode-hook)
(add-hook 'html-mode-hook 'cpence-language-mode-hook)
(add-hook 'haml-mode-hook 'cpence-language-mode-hook)
(add-hook 'yaml-mode-hook 'cpence-language-mode-hook)
(add-hook 'javascript-mode-hook 'cpence-language-mode-hook)
(add-hook 'css-mode-hook 'cpence-language-mode-hook)
(add-hook 'rhtml-mode-hook 'cpence-language-mode-hook)
