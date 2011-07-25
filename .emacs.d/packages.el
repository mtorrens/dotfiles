;;
;; My el-get package tree
;;

(add-to-list 'load-path "~/.emacs.d/el-get/el-get")
(require 'el-get)

(setq el-get-sources
      '((:name auctex :type elpa)
        (:name word-count
               :type git
               :url "https://github.com/emacsmirror/word-count.git"
               :features word-count)
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
        ))

(setq cpence-package-list
      (append
       '(el-get
	 yasnippet
	 magit
	 markdown-mode
	 smooth-scrolling)
       (mapcar 'el-get-source-name el-get-sources)))

(el-get 'sync cpence-package-list)
