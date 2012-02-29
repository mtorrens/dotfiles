
;; -------------------------------------
;; Executable paths
(push "/usr/local/bin" exec-path)
(push "/usr/texbin" exec-path)

;; -------------------------------------
;; Definitely required packages
(cua-mode t)
(require 'cl)
(require 'saveplace)
(require 'uniquify)
(require 'ansi-color)
(require 'recentf)

;; -------------------------------------
;; General Emacs configuration
(setq default-frame-alist
      '((width . 115)
        (height . 40)
        (cursor-type . bar)))

(setq-default tab-width 2)
(setq-default indent-tabs-mode nil)
(setq-default save-place t)

(fset 'yes-or-no-p 'y-or-n-p)

(delete-selection-mode t)
(scroll-bar-mode -1)
(tool-bar-mode -1)
(blink-cursor-mode t)
(show-paren-mode t)
(column-number-mode t)
(set-fringe-style -1)
(tooltip-mode -1)
(recentf-mode 1)
(menu-bar-mode -1)
(ido-mode t)
(mouse-wheel-mode t)

(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(prefer-coding-system 'utf-8)

(setq make-backup-files nil
      auto-save-default nil
      inhibit-startup-message t
      visible-bell t
      echo-keystrokes 0.1
      font-lock-maximum-decoration t
      transient-mark-mode t
      color-theme-is-global t
      delete-by-moving-to-trash t
      uniquify-buffer-name-style 'forward
      xterm-mouse-mode t
      save-place-file "~/.emacs.d/places"
      ido-enable-prefix nil
      ido-enable-flex-matching t
      ido-create-new-buffer 'always
      ido-use-filename-at-point t
      ido-max-prospects 10
      cua-keep-region-after-copy t)

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
(global-set-key (kbd "C-x f") 'recentf-ido-find-file)

;; -------------------------------------
;; Theme and fonts
(add-to-list 'custom-theme-load-path "~/.emacs.d/packages/solarized.git/")
(set-frame-font "Panic Sans-13")
(load-theme 'solarized-light t)

(add-to-list 'load-path "~/.emacs.d/packages")

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
(global-set-key [f1] 'deft)

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
