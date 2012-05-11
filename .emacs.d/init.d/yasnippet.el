
;; YASnippet
(add-to-list 'load-path "~/.emacs.d/packages/yasnippet.git")

(require 'yasnippet)

(setq yas/root-directory '("~/.emacs.d/packages/yasnippet.git/snippets"
                           "~/.emacs.d/snippets")
      yas/wrap-around-region t
      yas/prompt-functions '(yas/x-prompt yas/ido-prompt))
(mapc 'yas/load-directory yas/root-directory)

(yas/global-mode 1)

(add-to-list 'auto-mode-alist '("snippets/.*" . snippet-mode))


