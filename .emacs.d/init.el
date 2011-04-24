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


;; ----------------------------------------------------
;; Load all external packages

;; Smooth scrolling (Adam Spiers, 20070910)
(require 'smooth-scrolling)
(setq smooth-scroll-margin 25)

;; YASnippet (currently SVN 20110412)
(require 'yasnippet)
(yas/initialize)
(yas/load-directory (concat user-emacs-directory "snippets"))
(add-to-list 'hippie-expand-try-functions-list 'yas/hippie-try-expand)

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

;; Smart-Tab mode (Git 2/26/11)
(require 'smart-tab)
(global-smart-tab-mode 1)

;; Smooth Scrolling
(require 'smooth-scrolling)

;; Autopair mode (SVN 3/13/11)
(require 'autopair)
(setq autopair-autowrap nil)
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

;; Enable the server
(server-start)

;; Disable splash screen
(setq inhibit-splash-screen t)
(setq inhibit-startup-message t)

;; Quick y/n prompts
(fset 'yes-or-no-p 'y-or-n-p)

;; If in the terminal, disable menu bar and enable mouse
(if (not window-system)
    (progn
      (menu-bar-mode -1)
      (xterm-mouse-mode t)
    ))

;; Set the default GUI size
(if window-system
    (setq default-frame-alist
	  '(
	    (width             . 90)
	    (height            . 35)
	    (left              . 300)
	    (top               . 24)
	    (cursor-type       . bar)
      (vertical-scroll-bars . nil)
      (horizontal-scroll-bars . nil)
      (font              . "Panic Sans-14:antialias=subpixel")
	    )
	  )
)

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

;; Default to text-mode, not fundamental-mode
(setq-default major-mode 'text-mode)

;; ----------------------------------------------------
;; File saving

;; A few bits of the encoding system cannot be set via Customize
(prefer-coding-system 'utf-8)
(setq locale-coding-system 'utf-8)

;; ----------------------------------------------------
;; Fonts and Colors

;; Load color theme
(load-theme 'Railscasts)

;; ----------------------------------------------------
;; Keys

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
(global-set-key (kbd "C-w") (lambda()(interactive)(kill-buffer (current-buffer))))
(global-set-key (kbd "C-q") 'save-buffers-kill-terminal)


;; WriteRoom emulation on F11
(global-set-key [f11] 'darkroom-mode)

;; Speedbar on C-p
(require 'speedbar)
(defun cpence-toggle-speedbar ()
  (interactive)
  (if (frame-live-p (speedbar-current-frame))
      (speedbar)
    (progn
      (speedbar)
      (other-frame 1))))
(global-set-key (kbd "C-p") 'cpence-toggle-speedbar)

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

  ;; Fix hl-line-mode for visual-line-mode
  (set (make-local-variable 'hl-line-range-function) 'visual-line-line-range)
  
  ;; Rebind keys to work with visual lines
  (local-set-key [s-left] 'beginning-of-visual-line)
  (local-set-key [s-right] 'end-of-visual-line)
  (local-set-key [home] 'beginning-of-visual-line)
  (local-set-key [end] 'end-of-visual-line)

  ;; Make the tab key work more normally
  (setq indent-line-function 'insert-tab)
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
;; Markdown mode
(defun cpence-markdown-mode-hook ()
  (interactive)

  ;; Actually insert tab characters and newlines, indentation stuff
  ;; goes crazy in markdown-mode for some reason
  (define-key markdown-mode-map (kbd "<tab>") 'tab-to-tab-stop)
  (define-key markdown-mode-map (kbd "C-m") 'newline)
)
(add-hook 'markdown-mode-hook 'cpence-markdown-mode-hook)

;; ----------------------------------------------------
;; All programming modes
(defun cpence-language-mode-hook ()
  (interactive)

  ;; TextMate mode in all code buffers
  (textmate-mode)
  
  ;; Bind return to intending-return in all source modes
  (local-set-key (kbd "RET") 'newline-and-indent)
  
  ;; And bind kill-line to indent-killing-kill-line in
  ;; all source modes
  (local-set-key (kbd "C-k") 'kill-and-join-forward)

  ;; No tabs, only spaces
  (setq indent-tabs-mode nil)
)

(defun cpence-tab-stop-four ()
  (interactive)
  (setq tab-width 4)
  (setq standard-indent 4)
)

;; There's no "general" mode-hook that handles all of the
;; programming modes, so we have to set all these hooks
;; ourselves.  Change tab stops based on what I like for
;; a given language (Ruby people all use two, but I like
;; four for C, Python, other real code).
(add-hook 'c-mode-common-hook 'cpence-language-mode-hook)
(add-hook 'c-mode-common-hook 'cpence-tab-stop-four)
(add-hook 'css-mode-hook 'cpence-language-mode-hook)
(add-hook 'ruby-mode-hook 'cpence-language-mode-hook)
(add-hook 'rspec-mode-hook 'cpence-language-mode-hook)
(add-hook 'asm-mode-hook 'cpence-language-mode-hook)
(add-hook 'asm-mode-hook 'cpence-tab-stop-four)
(add-hook 'xml-mode-hook 'cpence-language-mode-hook)
(add-hook 'html-mode-hook 'cpence-language-mode-hook)
(add-hook 'haml-mode-hook 'cpence-language-mode-hook)
(add-hook 'yaml-mode-hook 'cpence-language-mode-hook)
(add-hook 'javascript-mode-hook 'cpence-language-mode-hook)
(add-hook 'css-mode-hook 'cpence-language-mode-hook)
(add-hook 'rhtml-mode-hook 'cpence-language-mode-hook)
(add-hook 'python-mode-hook 'cpence-language-mode-hook)
(add-hook 'python-mode-hook 'cpence-tab-stop-four)

;; In all programming modes, indent code automatically when
;; pasted
(dolist (command '(yank yank-pop))
  (eval `(defadvice ,command (after indent-region activate)
           (and (not current-prefix-arg)
                (member major-mode '(ruby-mode       rspec-mode
                                     python-mode     c-mode
                                     c++-mode        objc-mode
                                     latex-mode      plain-tex-mode
                                     css-mode        asm-mode
                                     xml-mode        html-mode
                                     haml-mode       js-mode
                                     css-mode        rhtml-mode))
                (let ((mark-even-if-inactive transient-mark-mode))
                  (indent-region (region-beginning) (region-end) nil))))))

;; When killing a line, strip the indentation characters off
;; of the front
(defun kill-and-join-forward (&optional arg)
  (interactive "P")
  (if (and (eolp) (not (bolp)))
      (progn (forward-char 1)
             (just-one-space 0)
             (backward-char 1)
             (kill-line arg))
    (kill-line arg)))


;; ----------------------------------------------------
;; C mode

(defun cpence-c-mode-hook ()
  (interactive)

  ;; Engage automatic-everything mode
  (c-toggle-auto-state 1)

  ;; Don't indent namespaces, do indent comments
  (c-set-offset 'innamespace 0)
  (setq c-comment-only-line-offset 0)

  ;; Set cleanups
  (add-to-list 'c-cleanup-list 'defun-close-semi)
  (add-to-list 'c-cleanup-list 'space-before-funcall)
)

(add-hook 'c-mode-common-hook 'cpence-c-mode-hook)

;; Set indentation options
(setq-default c-default-style "bsd")
(setq c-basic-offset 4)

