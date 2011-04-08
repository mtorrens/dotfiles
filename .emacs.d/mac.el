;;
;; Random pieces to deal with the quirks of Emacs on MacOS
;;

;; I like CMD to be interpreted as CTRL
(setq mac-command-modifier 'ctrl)

;; Add "open" to the AuCTeX view list
(setq TeX-view-program-list (quote (("open" "open %o"))))
(setq TeX-view-program-selection (quote ((output-pdf "open") (output-html "open"))))

;; OS X Emacs has a propensity to spew frames everywhere, stop it
(setq ns-pop-up-frames nil)
