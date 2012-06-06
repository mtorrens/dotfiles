
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

