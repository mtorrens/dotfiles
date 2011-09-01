;;
;; My el-get package tree
;;

(add-to-list 'load-path "~/.emacs.d/el-get/el-get")
(require 'el-get)

(setq el-get-sources
      '((:name auctex :type elpa)
        (:name buffer-move
               :after (lambda ()
                        (global-set-key (kbd "<C-M-up>") 'buf-move-up)
                        (global-set-key (kbd "<C-M-down>") 'buf-move-down)
                        (global-set-key (kbd "<C-M-left>") 'buf-move-left)
                        (global-set-key (kbd "<C-M-right>") 'buf-move-right)))
        (:name smex
               :after (lambda ()
                        (setq smex-save-file "~/.emacs.d/.smex-items")
                        (global-set-key (kbd "M-x") 'smex)
                        (global-set-key (kbd "M-X") 'smex-major-mode-commands)))
        (:name muse
               :after (lambda ()
                        (require 'muse-mode)
                        (require 'muse-html)
                        (require 'muse-latex)
                        (require 'muse-wiki)
                        (require 'muse-project)
                        (setq muse-colors-autogen-headings nil)))
        (:name yasnippet
               :after (lambda ()
                        (require 'yasnippet)
                        (yas/initialize)
                        (setq yas/root-directory '("~/.emacs.d/snippets"
                                                   "~/.emacs.d/el-get/yasnippet/snippets"))
                        (mapc 'yas/load-directory yas/root-directory)))
        (:name scss-mode
               :after (lambda ()
                        (add-to-list 'auto-mode-alist '("\\.scss$" . scss-mode))))
        ))

(setq cpence-package-list
      (append
       '(el-get
         haml-mode
         yaml-mode
         magit
         markdown-mode
         muse
         smooth-scrolling
         sr-speedbar)
       (mapcar 'el-get-source-name el-get-sources)))

(el-get 'sync cpence-package-list)
