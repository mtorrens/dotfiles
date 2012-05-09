
;; W3M
(add-to-list 'load-path "~/.emacs.d/packages/apel")
(add-to-list 'load-path "~/.emacs.d/packages/flim")
(add-to-list 'load-path "~/.emacs.d/packages/semi")
(add-to-list 'load-path "~/.emacs.d/packages/w3m")

(require 'w3m-load)
(require 'mime-w3m)

(setq w3m-use-cookies t
      mime-w3m-safe-url-regexp nil
      w3m-default-display-inline-images t
      w3m-toggle-inline-images-permanently nil)

;; Fix W3M's silly keys
(define-key w3m-mode-map [left] 'backward-char)
(define-key w3m-mode-map [right] 'forward-char)
(define-key w3m-mode-map [up] 'previous-line)
(define-key w3m-mode-map [down] 'next-line)
(define-key w3m-minor-mode-map [left] 'backward-char)
(define-key w3m-minor-mode-map [right] 'forward-char)
(define-key w3m-minor-mode-map [up] 'previous-line)
(define-key w3m-minor-mode-map [down] 'next-line)

;; External browser support (use Mac OS X's "open" command or "xdg-open")
(if (string-equal system-type "darwin")
    (setq browse-url-generic-program "open")
  (setq browse-url-generic-program "xdg-open"))
(setq browse-url-browser-function 'browse-url-generic
      browse-url-new-window-flag t)

