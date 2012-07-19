
;; -------------------------------------
;; Load all the bits where the real action happens

(push "~/bin" exec-path)
(push "/usr/local/bin" exec-path)
(push "/usr/texbin" exec-path)
(setenv "PATH" (mapconcat (lambda (dir) (expand-file-name (or dir ".")))
                          exec-path path-separator))

(setq custom-file "~/.emacs.d/custom.el")
(load custom-file 'noerror)

;; This path is used by lots of different single-file packages
(add-to-list 'load-path "~/.emacs.d/packages")

;; Visual/GUI settings
(load "~/.emacs.d/init.d/visual.el")
(load "~/.emacs.d/init.d/visual-line-mode.el")

;; File editing/writing settings
(load "~/.emacs.d/init.d/editing.el")
(load "~/.emacs.d/init.d/printing.el")

;; Global key bindings
(load "~/.emacs.d/init.d/keys.el")

;; These are used by several of the below
(require 'cl)
(require 'todochiku)
(setq todochiku-icons-directory "~/.emacs.d/packages/todochiku-icons")

;; Package configurations
(load "~/.emacs.d/init.d/ido.el")
(load "~/.emacs.d/init.d/dired.el")
(load "~/.emacs.d/init.d/eshell.el")

(load "~/.emacs.d/init.d/org.el")
(load "~/.emacs.d/init.d/jabber.el")

(load "~/.emacs.d/init.d/text.el")
(load "~/.emacs.d/init.d/markdown.el")
(load "~/.emacs.d/init.d/auctex.el")

(load "~/.emacs.d/init.d/yasnippet.el")
(load "~/.emacs.d/init.d/codemodes.el")
(load "~/.emacs.d/init.d/code.el")

;; Set up the modeline last, so we override all the crazy things other
;; packages do to global-mode-string
(load "~/.emacs.d/init.d/modeline.el")
