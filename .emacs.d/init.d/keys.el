
;; On Mac OS X, turn Command into Super
(if (string-equal system-type "darwin")
    (setq ns-command-modifier 'super))


;; Fix home and end to use visual-line-mode, which still works even when
;; vl-mode isn't turned on
(global-set-key [home] 'beginning-of-visual-line)
(global-set-key [end] 'end-of-visual-line)
(global-set-key [kp-home] 'beginning-of-visual-line)
(global-set-key [kp-end] 'end-of-visual-line)
(global-set-key [kp-delete] 'delete-char)
(if (string-equal system-type "darwin")
    (progn
      (global-set-key [s-left] 'beginning-of-visual-line)
      (global-set-key [s-right] 'end-of-visual-line)))


;; Add swbuff to switch between buffers like alt-tab
(require 'swbuff)
(require 'swbuff-x)
(global-set-key [C-tab] 'swbuff-switch-to-next-buffer)
(global-set-key [C-S-tab] 'swbuff-switch-to-previous-buffer)


;; Some really common global keys I want to Just Work
(global-set-key (kbd "M-g") 'goto-line)
(global-set-key (kbd "C-z") 'undo)

