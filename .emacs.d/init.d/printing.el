(require 'printing)
(require 'ps-samp)

(setq pr-txt-name 'hl5280dw
      pr-txt-printer-alist '((hl5280dw "lprpdf" nil "Brother_HL_5280DW_series"))

      pr-ps-name 'hl5280dw
      pr-ps-printer-alist '((hl5280dw "lprpdf" nil "-P" "Brother_HL_5280DW_series"))

      pr-gv-command "lprpreview")

(defun pr-mu4e-print (n-up filename header-list)
  "Print *Article* current message in PostScript."
  (pr-ps-message-from-summary n-up filename header-list
                              'mu4e~view-buffer 'mu4e~view-buffer-name))

(defun pr-mu4e-lpr (header-list)
  "Print *Article* current message in text printer."
  (pr-lpr-message-from-summary header-list
                               'mu4e~view-buffer 'mu4e~view-buffer-name))

(add-to-list 'pr-mode-alist
             '(mu4e-view-mode
               pr-mu4e-lpr  pr-mu4e-print
               2
               (ps-article-subject ps-article-author)
               nil
               nil
               ))

(pr-update-menus t)
(global-set-key (kbd "M-p") 'pr-ps-buffer-print)
