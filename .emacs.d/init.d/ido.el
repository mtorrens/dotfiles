
;; Enable recent-file mode
(require 'recentf)
(recentf-mode 1)
(setq recentf-exclude '("ido.last" "~$"))


;; Turn on IDO, with flexible matching and whatnot
(ido-mode t)
(setq ido-enable-prefix nil
      ido-enable-flex-matching t
      ido-create-new-buffer 'always
      ido-save-directory-list-file "~/.emacs.d/cache/ido.last")


;; A great function for looking through the recent-files list using IDO
;; http://emacswiki.org/emacs/RecentFiles
(defun recentf-ido-find-file ()
  "Find a recent file using Ido."
  (interactive)
  (let* ((file-assoc-list
          (mapcar (lambda (x)
                    (cons (file-name-nondirectory x)
                          x))
                  recentf-list))
         (filename-list
          (remove-duplicates (mapcar #'car file-assoc-list)
                             :test #'string=))
         (filename (ido-completing-read "Choose recent file: "
                                        filename-list
                                        nil
                                        t)))
    (when filename
      (find-file (cdr (assoc filename
                             file-assoc-list))))))


;; Turn on IDO buffer switching by default
(global-set-key (kbd "C-x C-b") 'ido-switch-buffer)
;; Enable the recent-file key (this overwrites find-file-read-only,
;; which is just fine)
(global-set-key (kbd "C-x C-r") 'recentf-ido-find-file)

