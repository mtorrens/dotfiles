;; ELPA configuration
(require 'package)
(setq package-archives (cons '("tromey" . "http://tromey.com/elpa/") package-archives))
(package-initialize)

;; el-get configuration
(add-to-list 'load-path "~/.emacs.d/el-get/el-get")
(require 'el-get)

(setq el-get-sources
      '(el-get auctex cmake-mode emacs-goodies-el emacs-textmate haml-mode markdown-mode matlab-mode php-mode-improved python-mode rhtml-mode rst-mode ruby-mode sass-mode smarttabs smooth-scroll yasnippet
))

(el-get)
