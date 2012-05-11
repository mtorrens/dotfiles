
;; Make the mark behave like a 21st-century application
(delete-selection-mode t)
(transient-mark-mode t)

;; Turn on the clipboard
(setq x-select-enable-clipboard t)

;; No tabs, 80-column width
(setq-default tab-width 2
              indent-tabs-mode nil
              fill-column 80)


;; Set the tab stops to a given width in various different modes
(defun set-tab-stop-width (width)
  "Set all tab stops to WIDTH in current buffer.
    
   This updates `tab-stop-list', but not `tab-width'.
    
   By default, `indent-for-tab-command' uses tabs to indent, see
   `indent-tabs-mode'."
  (interactive "nTab width: ")
  (let* ((max-col (car (last tab-stop-list)))
         ;; If width is not a factor of max-col,
         ;; then max-col could be reduced with each call.
         (n-tab-stops (/ max-col width)))
    (set (make-local-variable 'tab-stop-list)
         (mapcar (lambda (x) (* width x))
                 (number-sequence 1 n-tab-stops)))
    ;; So preserve max-col, by adding to end.
    (unless (zerop (% max-col width))
      (setcdr (last tab-stop-list)
              (list max-col)))))


;; Automatically revert everything all the time
(global-auto-revert-mode 1)


;; No backups or auto-saves or anything
(setq make-backup-files nil
      auto-save-default nil
      auto-save-list-file-name nil
      auto-save-list-file-prefix nil)


;; Make newlines
(setq require-final-newline t)


;; UTF-8 everywhere
(setq locale-coding-system 'utf-8)
(prefer-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-selection-coding-system 'utf-8)
(setq default-buffer-file-coding-system 'utf-8)
(set-language-environment "UTF-8")
(set-input-method nil)
(setq x-select-request-type '(UTF8_STRING COMPOUND_TEXT TEXT STRING))


;; Configure spell checking here
(setq ispell-dictionary "american"
      ispell-extra-args '("-a" "-i" "utf-8")
      ispell-silently-savep t
      ispell-local-dictionary-alist
      '((nil ; default
         "[A-Za-z]" "[^A-Za-z]" "[']" t ("-d" "en_US" "-i"
                                         "utf-8") nil utf-8)
        ("american" ; US English
         "[A-Za-z]" "[^A-Za-z]" "[']" t ("-d" "en_US" "-i"
                                         "utf-8") nil utf-8)))
(setq-default ispell-program-name "hunspell")

(setq flyspell-duplicate-distance 0
      flyspell-issue-message-flag nil
      flyspell-issue-welcome-flag nil)
