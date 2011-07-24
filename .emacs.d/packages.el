;;
;; My el-get package tree
;;

(add-to-list 'load-path "~/.emacs.d/el-get/el-get")
(require 'el-get)

(setq el-get-sources
      '((:name auctex :type elpa)
        (:name word-count
               :type git
               :url "https://github.com/emacsmirror/word-count.git")
        (:name tex-wcount
               :type git
               :url "https://github.com/emacsmirror/tex-wcount.git")
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
