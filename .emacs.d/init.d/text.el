
;; -------------------------------------
;; Markdown mode

(add-to-list 'load-path "~/.emacs.d/packages/markdown-mode.git")
(autoload 'markdown-mode "markdown-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.md$" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.markdown$" . markdown-mode))

;; -------------------------------------
;; AUCTeX

(add-to-list 'load-path "~/.emacs.d/packages/auctex-11.86")
(load "auctex.el" nil t t)
(load "preview-latex.el" nil t t)
(add-to-list 'completion-ignored-extensions ".aux")
(add-to-list 'completion-ignored-extensions ".ent")
(add-to-list 'completion-ignored-extensions ".toc")
(add-to-list 'completion-ignored-extensions ".bbl")
(add-to-list 'completion-ignored-extensions ".blg")
(add-to-list 'completion-ignored-extensions ".fdb_latexmk")

(setq TeX-save-query nil
      TeX-parse-self t
      TeX-auto-save t
      TeX-auto-untabify t
      TeX-command-default "Latexmk"
      TeX-view-program-list '(("Open" "open %s.pdf"))
      TeX-view-program-selection '((output-pdf "Open"))
      font-latex-fontify-sectioning 'color
      TeX-command-list '(
                         ("Latexmk" "latexmk -pdf -ps- -dvi- -pdflatex='pdflatex -interaction=nonstopmode %%O %%S' %s" TeX-run-command nil t :help "Run Latexmk on file")
                         ("XeLatexmk" "latexmk -pdf -ps- -dvi- -pdflatex='xelatex -interaction=nonstopmode %%O %%S' %s" TeX-run-command nil t :help "Run Latexmk on file")
                         ("View" "%V" TeX-run-discard-or-function nil t :help "Run Viewer")
                         ("Clean" "latexmk -c %s" TeX-run-command nil t :help "Delete generated intermediate files")))

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

(defun cpence-latex-mode-hook ()
  (interactive)

  ;; Patch up some variables
  (make-local-variable 'indent-line-function)
  (setq indent-line-function 'LaTeX-indent-line)

  ;; Make sure these stay set right
  (TeX-PDF-mode-on)
  (setq TeX-command-default "Latexmk")

  ;; Check spelling
  (flyspell-mode 1)
  (local-set-key (kbd "<f7>") 'ispell-buffer)
  (local-set-key (kbd "S-<f7>") 'ispell-word)
)
(add-hook 'LaTeX-mode-hook 'cpence-latex-mode-hook)

(defun cpence-markdown-mode-hook ()
  (interactive)

  (setq mode-name "md")
  
  ;; Actually insert tab characters and newlines, indentation stuff
  ;; goes crazy in markdown-mode for some reason
  (define-key markdown-mode-map (kbd "<tab>") 'tab-to-tab-stop)
  (define-key markdown-mode-map (kbd "C-m") 'newline)

  (set-tab-stop-width 4)
)
(add-hook 'markdown-mode-hook 'cpence-markdown-mode-hook)
