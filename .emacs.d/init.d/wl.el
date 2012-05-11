
;; Wanderlust
(add-to-list 'load-path "~/.emacs.d/packages/wl")

(autoload 'wl "wl" "Wanderlust" t)
(autoload 'wl-other-frame "wl" "Wanderlust on new frame." t)
(autoload 'wl-draft "wl-draft" "Write draft with Wanderlust." t)
(autoload 'wl-user-agent-compose "wl-draft" "Compose with Wanderlust." t)

(global-set-key [f12] 'wl)
(setq wl-init-file "~/.emacs.d/wl.el"
      wl-folders-file "~/.emacs.d/folders")

;; Use wanderlust for default compose-mail
(if (boundp 'mail-user-agent)
    (setq mail-user-agent 'wl-user-agent))
(if (fboundp 'define-mail-user-agent)
    (define-mail-user-agent
      'wl-user-agent
      'wl-user-agent-compose
      'wl-draft-send
      'wl-draft-kill
      'mail-send-hook))

(require 'octet)
(octet-mime-setup)


;; Wrap message buffers automatically when writing and reading
(add-hook 'mime-view-mode-hook '(lambda() (visual-line-mode t)))


