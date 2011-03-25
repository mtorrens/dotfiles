;; ELPA packages
(require 'package)
(setq package-archives (cons '("tromey" . "http://tromey.com/elpa/") package-archives))
(package-initialize)

;; el-get packages
(require 'el-get)
