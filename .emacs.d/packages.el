;; ELPA packages
(require 'package)
(setq package-archives (cons '("tromey" . "http://tromey.com/elpa/") package-archives))
(package-initialize)

;; el-get packages
(require 'el-get)

(setq el-get-sources
      '(el-get ruby-mode ruby-compilation clevercss emacs-textmate rvm rhtml-mode yaml-mode haml-mode sass-mode
	
        (:name inf-ruby :type elpa)
        (:name css-mode :type elpa)
	(:name auctex :type elpa)
))
(el-get)

