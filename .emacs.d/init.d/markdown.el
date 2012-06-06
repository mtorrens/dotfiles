
;; -------------------------------------
;; Markdown mode

(add-to-list 'load-path "~/.emacs.d/packages/markdown-mode.git")
(autoload 'markdown-mode "markdown-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.md$" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.markdown$" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.text$" . markdown-mode))


(defun cpence-markdown-mode-hook ()
  (interactive)

  ;; Actually insert tab characters and newlines, indentation stuff
  ;; goes crazy in markdown-mode for some reason
  (define-key markdown-mode-map (kbd "<tab>") 'tab-to-tab-stop)
  (define-key markdown-mode-map (kbd "C-m") 'newline)

  (set-tab-stop-width 4)
)
(add-hook 'markdown-mode-hook 'cpence-markdown-mode-hook)
