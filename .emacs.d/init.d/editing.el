
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


;; UTF-8 everywhere
(prefer-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-selection-coding-system 'utf-8)
(setq default-buffer-file-coding-system 'utf-8)
(setq x-select-request-type '(UTF8_STRING COMPOUND_TEXT TEXT STRING))

