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
;; File Input/Output

(require 'recentf)
(setq recentf-save-file (concat user-emacs-directory "recentf"))
(recentf-mode 1)

(global-auto-revert-mode 1)

;; Default to text-mode, not fundamental-mode
(setq-default major-mode 'text-mode)

(setq make-backup-files nil)
(setq auto-save-default nil)
(setq auto-save-list-file-name nil)
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
        '(width . 130)
        '(height . 40)
        '(font . "Panic Sans-14")
        '(cursor-type . bar)
        '(line-spacing . 1)
        '(alpha . 100))
       default-frame-alist))

(setq inhibit-splash-screen t)
(setq inhibit-startup-message t)

(scroll-bar-mode -1)
(tool-bar-mode -1)
(tooltip-mode -1)

;; On Mac, you get the top-screen menu bar anyway
(unless (system-type-is-darwin)
  (menu-bar-mode -1))

;; Enable mouse and disable menu in console
(if (not window-system)
    (progn
      (menu-bar-mode -1)
      (xterm-mouse-mode t)))

(set-frame-font "Panic Sans-14")
(load-theme 'TomorrowNight)

(blink-cursor-mode t)
(show-paren-mode t)
(global-hl-line-mode 1)
(setq search-highlight t)
(setq query-replace-highlight t)

(fset 'yes-or-no-p 'y-or-n-p)

(line-number-mode t)
(column-number-mode t)

(setq pop-up-windows nil)


;; -------------------------------------
;; Load el-get packages

(load (concat user-emacs-directory "packages.el"))


;; -------------------------------------
;; Modernize editing

(delete-selection-mode t)
(transient-mark-mode 1)
(setq x-select-enable-clipboard t)

(setq fill-column 80)

;; Auto-complete *everything*
(require 'ido)
(ido-mode t)
(setq ido-save-directory-list-file "~/.emacs.d/.ido.last")
(setq ido-enable-flex-matching t)
(setq ido-use-filename-at-point 'guess)
(setq ido-show-dot-for-dired t)

;; Speedbar
(require 'sr-speedbar)
(setq speedbar-supported-extension-expressions
    '(".org" ".[ch]\\(\\+\\+\\|pp\\|c\\|h\\|xx\\)?"
       ".tex\\(i\\(nfo\\)?\\)?" ".el"
       ".java" ".p[lm]" ".pm" ".py"  ".s?html"  "Makefile.am" "configure.ac"
       ".redo" ".m4" ".rb" ".bib" ".blg" ".log" ".muse"
       ".css"))
(setq sr-speedbar-width-x 20)
(setq sr-speedbar-right-side t)

;; Spelling
(if (system-type-is-darwin)
    (progn
      (setq ispell-local-dictionary-alist
            '(("en_US"
               "[a-zA-Z]" "[^a-zA-Z]"
               "[']" nil
               ("-d" "/Library/Spelling/en_US") nil utf-8)))
      (setq ispell-local-dictionary "en_US")))


;; -------------------------------------
;; Keys

(cua-mode t)
(setq cua-auto-tabify-rectangles nil)
(setq cua-keep-region-after-copy t)

(windmove-default-keybindings 'meta)
(setq windmove-wrap-around t)

(global-set-key [home] 'beginning-of-line)
(global-set-key [end] 'end-of-line)
(global-set-key [kp-home] 'beginning-of-line)
(global-set-key [kp-end] 'end-of-line)
(global-set-key [kp-delete] 'delete-char)

;; Add save on C-s, move find to C-f
(global-set-key (kbd "C-s") 'save-buffer)
(global-set-key (kbd "C-S-s") 'save-some-buffers)
(global-set-key (kbd "C-f") 'isearch-forward)
(define-key isearch-mode-map (kbd "C-f") 'isearch-repeat-forward)

;; Set some other comfort keys from other editors
(global-set-key (kbd "C-a") 'mark-whole-buffer)
(global-set-key (kbd "C-l") 'goto-line)
(global-set-key (kbd "C-o") 'find-file)
(global-set-key (kbd "C-{") 'previous-buffer)
(global-set-key (kbd "C-}") 'next-buffer)
(global-set-key (kbd "C-w") (lambda () (interactive) (kill-buffer (current-buffer))))
(global-set-key (kbd "C-q") 'save-buffers-kill-terminal)
(global-set-key (kbd "M-q") 'quoted-insert)

(global-set-key (kbd "<C-prior>") (lambda () (interactive) (goto-char (point-min))))
(global-set-key (kbd "<C-next>") (lambda () (interactive) (goto-char (point-max))))
(global-set-key (kbd "C-`") (lambda () (interactive nil) (raise-frame (next-frame))))

(global-set-key (kbd "<M-tab>") 'ido-switch-buffer)
(global-set-key (kbd "C-x C-b") 'ido-switch-buffer)
(global-set-key (kbd "C-x C-c") 'ido-switch-buffer)
(global-set-key (kbd "C-x B") 'ibuffer)

;; Actually useful shortcut keys
(global-set-key (kbd "<f11>")
                (lambda () (interactive) (find-file "~/Dropbox/Charles/Muse/Index.muse")))
(global-set-key (kbd "<f12>") 'sr-speedbar-toggle)


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
  
  ;; Normal TAB key in text editing
  (setq indent-line-function 'insert-tab)
 )
(add-hook 'text-mode-hook 'cpence-text-mode-hook)


(defun cpence-latex-mode-hook ()
  (interactive)
  
  ;; Bind the TeX building and viewing commands
  (local-set-key (kbd "C-r") 'TeX-command-master)
  (local-set-key [f7] 'TeX-command-master)
  (local-set-key (kbd "C-S-r") 'TeX-view)
  (local-set-key [f5] 'TeX-view)
  
  ;; Configure AucTeX
  (TeX-PDF-mode 1)
  (setq TeX-save-query nil)
  (setq TeX-parse-self t)
  (setq TeX-auto-save t)
  (setq TeX-auto-untabify t)
  
  ;; Set an OS-appropriate TeX view command
  (setq TeX-view-program-list '(("Skim" "open %s.pdf") ("Okular" "okular %s.pdf")))
  
  (if (system-type-is-gnu)
      (setq TeX-view-program-selection '((output-pdf "Okular") (output-dvi "Okular"))))
  (if (system-type-is-darwin)
      (setq TeX-view-program-selection '((output-pdf "Skim"))))
)
(add-hook 'LaTeX-mode-hook 'cpence-latex-mode-hook)


(defun cpence-markdown-mode-hook ()
  (interactive)

  ;; Actually insert tab characters and newlines, indentation stuff
  ;; goes crazy in markdown-mode for some reason
  (define-key markdown-mode-map (kbd "<tab>") 'tab-to-tab-stop)
  (define-key markdown-mode-map (kbd "C-m") 'newline)
)
(add-hook 'markdown-mode-hook 'cpence-markdown-mode-hook)


(defun cpence-code-mode-hook ()
  (interactive)

  ;; Newline = indent
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
;; ourselves.  Change tab stops to four for heavy-duty
;; programming languages where I like that sort of thing.
(add-hook 'c-mode-common-hook 'cpence-code-mode-hook)
(add-hook 'c-mode-common-hook 'cpence-tab-stop-four)
(add-hook 'css-mode-hook 'cpence-code-mode-hook)
(add-hook 'asm-mode-hook 'cpence-code-mode-hook)
(add-hook 'asm-mode-hook 'cpence-tab-stop-four)
(add-hook 'xml-mode-hook 'cpence-code-mode-hook)
(add-hook 'html-mode-hook 'cpence-code-mode-hook)
(add-hook 'javascript-mode-hook 'cpence-code-mode-hook)
(add-hook 'python-mode-hook 'cpence-code-mode-hook)
(add-hook 'python-mode-hook 'cpence-tab-stop-four)
(add-hook 'emacs-lisp-mode-hook 'cpence-code-mode-hook)

;; In all programming modes, indent code automatically when
;; pasted
(dolist (command '(yank yank-pop))
  (eval `(defadvice ,command (after indent-region activate)
           (and (not current-prefix-arg)
                (member major-mode '(python-mode     c-mode
                                     c++-mode        objc-mode
                                     latex-mode      plain-tex-mode
                                     css-mode        asm-mode
                                     xml-mode        html-mode
                                     js-mode         css-mode
                                     emacs-lisp-mode))
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
)
(add-hook 'c-mode-common-hook 'cpence-c-mode-hook)

;; Set indentation options
(setq-default c-default-style "bsd")
(setq c-basic-offset 4)


;; -------------------------------------
;; Muse Mode

(setq cpence-muse-style-sheet
      (concat "<link rel=\"stylesheet\" type=\"text/css\""
              " charset=\"utf-8\" media=\"all\""
              " href=\"notes.css\" />"))
(muse-derive-style "cpence-xhtml" "xhtml"
                   :style-sheet cpence-muse-style-sheet)

(setq muse-project-alist
      '(("Muse" ("~/Dropbox/Charles/Muse" :default "Index")
         (:base "cpence-xhtml" :path "~/Dropbox/Charles/Muse/html")
         (:base "pdf" :path "~/Dropbox/Charles/Muse/latex"))))
