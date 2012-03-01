
;; -------------------------------------
;; Add a bunch of paths

(push "/usr/local/bin" exec-path)
(push "/usr/texbin" exec-path)
(setenv "PATH" (mapconcat (lambda (dir) (or dir ".")) exec-path ":"))

;; This path is used by lots of different things
(add-to-list 'load-path "~/.emacs.d/packages")


;; -------------------------------------
;; Window settings

(require 'saveplace)
(require 'uniquify)

(setq default-frame-alist
      '((width . 115)
        (height . 40)
        (cursor-type . bar)
        (font . "Panic Sans-13")))

(scroll-bar-mode -1)
(tool-bar-mode -1)
(tooltip-mode -1)
(menu-bar-mode -1)
(mouse-wheel-mode t)

(set-fringe-style -1)

(blink-cursor-mode t)
(line-number-mode t)
(column-number-mode t)
(global-hl-line-mode t)
(show-paren-mode t)

(fset 'yes-or-no-p 'y-or-n-p)

(add-to-list 'custom-theme-load-path "~/.emacs.d/packages/solarized.git/")
(load-theme 'solarized-light t)

(setq-default save-place t)

(setq inhibit-startup-message t
      inhibit-splash-screen t
      visible-bell t
      echo-keystrokes 0.1
      font-lock-maximum-decoration t
      xterm-mouse-mode t
      search-highlight t
      query-replace-highlight t
      uniquify-buffer-name-style 'forward
      color-theme-is-global t
      save-place-file "~/.emacs.d/places")


;; -------------------------------------
;; Editing

(cua-mode t)
(delete-selection-mode t)

(setq-default tab-width 2)
(setq-default indent-tabs-mode nil)

(setq transient-mark-mode t
      x-select-enable-clipboard t
      fill-column 80
      cua-keep-region-after-copy t)


;; -------------------------------------
;; File writing

(global-auto-revert-mode 1)

(setq make-backup-files nil
      auto-save-default nil
      auto-save-list-file-name nil
      auto-save-list-file-prefix nil
      delete-by-moving-to-trash t)

(prefer-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-selection-coding-system 'utf-8)
(setq default-buffer-file-coding-system 'utf-8)
(setq x-select-request-type '(UTF8_STRING COMPOUND_TEXT TEXT STRING))


;; -------------------------------------
;; Auto-completion, with recent file support

(require 'recentf)
(recentf-mode 1)

(ido-mode t)
(setq ido-enable-prefix nil
      ido-enable-flex-matching t
      ido-create-new-buffer 'always
      ido-use-filename-at-point 'guess
      ido-max-prospects 10)

(defun recentf-ido-find-file ()
  "Find a recent file using Ido."
  (interactive)
  (let* ((file-assoc-list
          (mapcar (lambda (x)
                    (cons (file-name-nondirectory x)
                          x))
                  recentf-list))
         (filename-list
          (remove-duplicates (mapcar #'car file-assoc-list)
                             :test #'string=))
         (filename (ido-completing-read "Choose recent file: "
                                        filename-list
                                        nil
                                        t)))
    (when filename
      (find-file (cdr (assoc filename
                             file-assoc-list))))))


;; -------------------------------------
;; Global key bindings

;; On Mac OS X, turn Command into Ctrl
(if (string-equal system-type "darwin")
    (progn
      (setq ns-command-modifier 'control)
      (global-set-key [C-left] 'beginning-of-line)
      (global-set-key [C-right] 'end-of-line)))

(global-set-key [home] 'beginning-of-line)
(global-set-key [end] 'end-of-line)
(global-set-key [kp-home] 'beginning-of-line)
(global-set-key [kp-end] 'end-of-line)
(global-set-key [kp-delete] 'delete-char)

;; Set some other comfort keys from other editors
(global-set-key (kbd "C-a") 'mark-whole-buffer)
(global-set-key (kbd "C-l") 'goto-line)
(global-set-key (kbd "C-o") 'find-file)
(global-set-key (kbd "C-O") 'recentf-ido-find-file)
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

;; Add save on C-s, move find to C-f
(global-set-key (kbd "C-s") 'save-buffer)
(global-set-key (kbd "C-S-s") 'save-some-buffers)
(global-set-key (kbd "C-f") 'isearch-forward)
(define-key isearch-mode-map (kbd "C-f") 'isearch-repeat-forward)



;; -------------------------------------
;; Eshell

(global-set-key [f1] 'eshell)

(eval-after-load 'esh-opt
  '(progn
     (require 'em-cmpl)
     (require 'em-prompt)
     (require 'em-term)
     (setenv "PAGER" "cat")
     (add-hook 'eshell-mode-hook ;; for some reason this needs to be a hook
               '(lambda () (define-key eshell-mode-map "\C-a" 'eshell-bol)))
     (add-to-list 'eshell-visual-commands "ssh")
     (add-to-list 'eshell-visual-commands "tail")
     (add-to-list 'eshell-command-completions-alist
                  '("gunzip" "gz\\'"))
     (add-to-list 'eshell-command-completions-alist
                  '("tar" "\\(\\.tar|\\.tgz\\|\\.tar\\.gz\\|\\.tar\\.bz2\\)\\'"))
     (add-to-list 'eshell-output-filter-functions 'eshell-handle-ansi-color)))

(setq eshell-cmpl-cycle-completions nil
      eshell-save-history-on-exit t
      eshell-cmpl-dir-ignore "\\`\\(\\.\\.?\\|CVS\\|\\.svn\\|\\.git\\)/\\'"
      eshell-directory-name "~/.emacs.d/eshell")


;; -------------------------------------
;; Magit

(add-to-list 'load-path "~/.emacs.d/packages/magit.git")
(require 'magit)
(add-to-list 'auto-mode-alist '("COMMIT_EDITMSG$" . diff-mode))
(set-face-foreground 'magit-diff-add "green3")
(set-face-foreground 'magit-diff-del "red3")

;; -------------------------------------
;; YASnippet

(add-to-list 'load-path "~/.emacs.d/packages/yasnippet.git")
(require 'yasnippet)
(yas/global-mode 1)

;; -------------------------------------
;; Deft mode

(add-to-list 'load-path "~/.emacs.d/packages/deft.git")
(require 'deft)
(setq deft-extension "md")
(setq deft-directory "~/Dropbox/Charles/Notes")
(setq deft-text-mode 'markdown-mode)
(setq deft-use-filename-as-title t)
(global-set-key [f2] 'deft)

;; -------------------------------------
;; Markdown mode

(add-to-list 'load-path "~/.emacs.d/packages/markdown-mode.git")
(autoload 'markdown-mode "markdown-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.md$" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.markdown$" . markdown-mode))

;; -------------------------------------
;; CSS mode

(autoload 'css-mode "css-mode-1.0" nil t)
(add-to-list 'auto-mode-alist '("\\.css$" . css-mode))
(add-to-list 'auto-mode-alist '("\\.scss$" . css-mode))
(add-hook 'css-mode-hook '(lambda ()
                            (setq css-indent-level 2)
                            (setq css-indent-offset 2)))

;; -------------------------------------
;; Ruby mode

(autoload 'ruby-mode "ruby-mode-1.1" nil t)
(add-to-list 'auto-mode-alist '("Capfile" . ruby-mode))
(add-to-list 'auto-mode-alist '("Gemfile" . ruby-mode))
(add-to-list 'auto-mode-alist '("Rakefile" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.rake\\'" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.rb\\'" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.ru\\'" . ruby-mode))
(add-to-list 'completion-ignored-extensions ".rbc")

;; -------------------------------------
;; YAML mode

(add-to-list 'load-path "~/.emacs.d/packages/yaml-mode.git/")
(autoload 'yaml-mode "yaml-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.yml$" . yaml-mode))
(add-to-list 'auto-mode-alist '("\\.yaml$" . yaml-mode))

;; -------------------------------------
;; RHTML mode

(add-to-list 'load-path "~/.emacs.d/packages/rhtml.git/")
(autoload 'rhtml-mode "rhtml-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.erb\\'" . rhtml-mode))
(add-to-list 'auto-mode-alist '("\\.rjs\\'" . rhtml-mode))

;; -------------------------------------
;; JS2 mode

(add-to-list 'load-path "~/.emacs.d/packages/js2-mode.git/")
(autoload 'js2-mode "js2-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.js\\(on\\)?$" . js2-mode))

;; -------------------------------------
;; Python mode

(add-to-list 'load-path "~/.emacs.d/packages/python-mode.git/")
(autoload 'python-mode "python-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.py$" . python-mode))
(add-to-list 'interpreter-mode-alist '("python" . python-mode))

;; -------------------------------------
;; Haml mode

(add-to-list 'load-path "~/.emacs.d/packages/haml-mode.git/")
(autoload 'haml-mode "haml-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.haml$" . haml-mode))

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
;; Mode hooks

(defun cpence-text-mode-hook ()
  (interactive)
  (longlines-mode 1)
  (setq indent-line-function 'insert-tab)
)
(add-hook 'text-mode-hook 'cpence-text-mode-hook)

(defun cpence-latex-mode-hook ()
  (interactive)
  
  (local-set-key (kbd "C-r") 'TeX-command-master)
  (local-set-key [f7] 'TeX-command-master)
  (local-set-key (kbd "C-S-r") 'TeX-view)
  (local-set-key [f5] 'TeX-view)
  
  (TeX-PDF-mode 1)
  (setq TeX-save-query nil)
  (setq TeX-parse-self t)
  (setq TeX-auto-save t)
  (setq TeX-auto-untabify t)
  (setq TeX-view-program-list '(("Open" "open %s.pdf")))
  (setq TeX-view-program-selection '((output-pdf "Open")))
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

(defun cpence-code-mode-hook ()
  (interactive)

  ;; Newline = indent
  (local-set-key (kbd "RET") 'newline-and-indent)

  ;; And bind kill-line to indent-killing-kill-line in
  ;; all source modes
  (local-set-key (kbd "C-k") 'kill-and-join-forward)
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
(add-hook 'html-mode-hook 'cpence-code-mode-hook)
(add-hook 'css-mode-hook 'cpence-code-mode-hook)
(add-hook 'asm-mode-hook 'cpence-code-mode-hook)
(add-hook 'asm-mode-hook 'cpence-tab-stop-four)
(add-hook 'xml-mode-hook 'cpence-code-mode-hook)
(add-hook 'js2-mode-hook 'cpence-code-mode-hook)
(add-hook 'python-mode-hook 'cpence-code-mode-hook)
(add-hook 'python-mode-hook 'cpence-tab-stop-four)
(add-hook 'ruby-mode-hook 'cpence-code-mode-hook)
(add-hook 'rhtml-mode-hook 'cpence-code-mode-hook)
(add-hook 'yaml-mode-hook 'cpence-code-mode-hook)
(add-hook 'emacs-lisp-mode-hook 'cpence-code-mode-hook)


;; -------------------------------------
;; Custom variables block

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(safe-local-variable-values (quote ((encoding . utf-8)))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
