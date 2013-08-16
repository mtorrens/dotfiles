(add-to-list 'load-path "~/.emacs.d/el-get/el-get")

(unless (require 'el-get nil 'noerror)
  (with-current-buffer
      (url-retrieve-synchronously
       "https://raw.github.com/dimitri/el-get/master/el-get-install.el")
    (let (el-get-master-branch)
      (goto-char (point-max))
      (eval-print-last-sexp))))

(setq el-get-sources
    '((:name base16-themes
             :description "Base16 provides carefully chosen syntax highlighting and a default set of sixteen colors suitable for a wide range of applications."
             :website "http://chriskempson.github.io/base16/"
             :type github
             :pkgname "milkypostman/base16-emacs"
             :post-init (add-to-list 'custom-theme-load-path
                                     default-directory))
))

(setq my:el-get-packages
      '(base16-themes
        magit
        ethan-wspace
        auctex
        ruby-mode
        rspec-mode
        haml-mode
        sass-mode
        scss-mode
        markdown-mode
        yaml-mode
        icomplete+
        anything
        fill-column-indicator))

(add-to-list 'el-get-recipe-path "~/.emacs.d/el-get-user/recipes")
(el-get 'sync my:el-get-packages)


;; Customizations
(setq custom-file "~/.emacs.d/custom.el")
(load custom-file)

;; Fonts and visuals
(add-to-list 'default-frame-alist '(font . "Droid Sans Mono:pixelsize=14"))
(setq-default line-spacing 2)

(add-to-list 'default-frame-alist '(width . 90))
(add-to-list 'default-frame-alist '(height . 40))

(load-theme 'base16-railscasts-dark t)
(tool-bar-mode -1)
(global-linum-mode 1)
(setq linum-format "%6d ")
(global-hl-line-mode t)
(show-paren-mode t)
(define-globalized-minor-mode global-fci-mode fci-mode (lambda () (fci-mode 1)))
(global-fci-mode 1)

;; Don't change the format of this next line; Emacs looks for it.
(setq inhibit-startup-echo-area-message
      "cpence")
(setq inhibit-splash-screen t
      inhibit-startup-message t
      fringe-mode '(1 . 0)
      search-highlight t
      query-replace-highlight t
      show-paren-style 'parenthesis)

;; Keyboard settings
(cua-mode t)
(delete-selection-mode 1)
(setq x-select-enable-clipboard t
      interprogram-paste-function 'x-cut-buffer-or-selection-value)
(defalias 'yes-or-no-p 'y-or-n-p)

;; Scrolling
(setq scroll-margin 0
      scroll-conservatively 10000
      scroll-up-aggressively 0
      scroll-down-aggressively 0
      scroll-preserve-screen-position t)

;; File saving
(global-ethan-wspace-mode 1)
(setq-default fill-column 80
              indent-tabs-mode nil)
(setq make-backup-files nil
      locale-coding-system 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-selection-coding-system 'utf-8)
(prefer-coding-system 'utf-8)
(set-language-environment "UTF-8")
(set-input-method nil)
(setq read-quoted-char-radix 10)

;; Modeline
(line-number-mode t)
(column-number-mode t)

(setq-default mode-line-format
  (list
    ;; the buffer name; the file name as a tool tip
    '(:eval (propertize "%b " 'face 'font-lock-keyword-face
        'help-echo (buffer-file-name)))

    ;; line and column
    "(" ;; '%02' to set to 2 chars at least; prevents flickering
      (propertize "%02l" 'face 'font-lock-type-face) ","
      (propertize "%02c" 'face 'font-lock-type-face)
    ") "

    ;; relative position, size of file
    "["
    (propertize "%p" 'face 'font-lock-constant-face) ;; % above top
    "/"
    (propertize "%I" 'face 'font-lock-constant-face) ;; size
    "] "

    ;; the current major mode for the buffer.
    "["
    '(:eval (propertize "%m" 'face 'font-lock-string-face
              'help-echo buffer-file-coding-system))
    "] "


    "[" ;; insert vs overwrite mode, input-method in a tooltip
    '(:eval (propertize (if overwrite-mode "Ovr" "Ins")
              'face 'font-lock-preprocessor-face
              'help-echo (concat "Buffer is in "
                           (if overwrite-mode "overwrite" "insert") " mode")))

    ;; was this buffer modified since the last save?
    '(:eval (when (buffer-modified-p)
              (concat ","  (propertize "Mod"
                             'face 'font-lock-warning-face
                             'help-echo "Buffer has been modified"))))

    ;; is this buffer read-only?
    '(:eval (when buffer-read-only
              (concat ","  (propertize "RO"
                             'face 'font-lock-type-face
                             'help-echo "Buffer is read-only"))))
    "] "
    "%-" ;; fill with '-'
    ))

;; Minibuffer
(icomplete-mode t)
(setq icomplete-prospects-height 1
      icomplete-compute-delay 0)
(require 'icomplete+ nil noerror)

;; Anything
(require 'anything-config)
(global-set-key (kbd "C-x b")
                (lambda() (interactive)
                  (anything
                   :prompt "Switch to: "
                   :candidate-number-limit 10
                   :sources
                   '( anything-c-source-buffers
                      anything-c-source-recentf
                      anything-c-source-files-in-current-dir+
                      anything-c-source-locate))))

;; Buffer names
(require 'uniquify)
(setq uniquify-buffer-name-style 'post-forward
      uniquify-separator ":"
      uniquify-after-kill-buffer-p t
      uniquify-ignore-buffers-re "^\\*")

;; Recent and history
(setq savehist-autosave-interval 60
      savehist-file "~/.emacs.d/cache/savehist")
(savehist-mode t)
(require 'recentf)
(setq recentf-save-file "~/.emacs.d/cache/recentf"
      recentf-max-saved-items 100
      recentf-max-menu-items 15)
(recentf-mode t)
(setq auto-save-list-file-prefix "~/.emacs.d/cache/auto-save-list/.saves-")

;; Keyboard
(global-set-key (kbd "RET") 'newline-and-indent)

;; Visual Line Mode config
(defun visual-line-line-range ()
  (save-excursion
    (cons (progn (vertical-motion 0) (point))
          (progn (vertical-motion 1) (point)))))
(setq hl-line-range-function 'visual-line-line-range)

;; Ruby/RSpec
(setq rspec-use-rake-when-possible nil
      rspec-use-bundler-when-possible t)
(add-hook 'ruby-mode-hook
          (lambda ()
            (ethan-wspace-clean-all-modes)))

;; TeX
(add-hook 'TeX-mode-hook
          (lambda ()
            (visual-line-mode 1)
            (fci-mode 0)))

;; Markdown
(add-hook 'markdown-mode-hook
          (lambda ()
            (ethan-wspace-mode 0)
            (visual-line-mode 1)
            (fci-mode 0)))
