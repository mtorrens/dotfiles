
;; Enable recent-file mode
(require 'recentf)
(recentf-mode 1)
(setq recentf-exclude '("ido.last" "~$"))


;; Turn on IDO, with flexible matching and whatnot
(ido-mode 'both)
(setq ido-enable-prefix nil
      ido-enable-flex-matching t
      ido-create-new-buffer 'always
      ido-save-directory-list-file "~/.emacs.d/cache/ido.last"
      ido-ignore-buffers '("\\` " "^\*Mess" "^\*Back" ".*Completion" "^\*Ido" "^\*trace"
                           "^\*compilation" "^\*GTAGS" "^session\.*" "^\*Minibuf"
                           "^\*mu4e-proc" "^\*Echo" ".*[oO]utput\*$")
      ido-ignore-files (append ido-ignore-files
                               (list
                                ".*\\.org_archive$"
                                ".*\\.fdb_latexmk$"
                                ".*\\.pdf$"
                                ".*\\.toc$"
                                ".*\\.blg$"
                                ".*\\.aux$"
                                ".*\\.dvi$"
                                ".*\\.ps$"
                                ".*\\.eps$"
                                ".*\\.nav$"
                                ".*\\.fls$"
                                ".*\\.out$"
                                ".*\\.png$"
                                ".*\\.jpg$"
                                ".*\\.DS_Store$"
                                ".*\\.gz$"))
      ido-case-fold t
      ido-enable-last-directory-history t
      ido-max-work-directory-list 30
      ido-use-filename-at-point nil
      ido-use-url-at-point nil
      confirm-nonexistent-file-or-buffer nil)


;; Give me my spacebar back
(defun ido-my-keys ()
  (define-key ido-completion-map " " 'self-insert-command))
(add-hook 'ido-setup-hook 'ido-my-keys)


;; increase minibuffer size when ido completion is active
(add-hook 'ido-minibuffer-setup-hook 
          (function
           (lambda ()
             (make-local-variable 'resize-minibuffer-window-max-height)
             (setq resize-minibuffer-window-max-height 1))))


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

