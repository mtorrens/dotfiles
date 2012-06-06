
;; -------------------------------------
;; Mode hooks

(defun cpence-text-mode-hook ()
  (interactive)

  (hl-line-mode)
  (set (make-local-variable 'hl-line-range-function) 'visual-line-line-range)

  (visual-line-mode)
  (set-visual-wrap-column 82)

  (set-tab-stop-width 2)
)
(add-hook 'text-mode-hook 'cpence-text-mode-hook)
