
;; -------------------------------------
;; Compilation with support for root project folders

(require 'compile)

(defun upward-find-file (filename &optional startdir)
  "Move up directories until we find a certain filename. If we
  manage to find it, return the containing directory. Else if we
  get to the toplevel directory and still can't find it, return
  nil. Start at startdir or . if startdir not given"

  (let ((dirname (expand-file-name
		  (if startdir startdir ".")))
	(found nil) ; found is set as a flag to leave loop if we find it
	(top nil))  ; top is set when we get
		    ; to / so that we only check it once

    ; While we've neither been at the top last time nor have we found
    ; the file.
    (while (not (or found top))
      ; If we're at / set top flag.
      (if (string= (expand-file-name dirname) "/")
	  (setq top t))
      
      ; Check for the file
      (if (file-exists-p (expand-file-name filename dirname))
	  (setq found t)
	; If not, move up a directory
	(setq dirname (expand-file-name ".." dirname))))
    ; return statement
    (if found dirname nil)))

(defun get-vc-pathname ()
  "Determine the closest parent directory containing some sort of version control files (e.g.,
.git, .svn, .hg).  Also looks for autoconf related things."
  (or (upward-find-file ".git")
      (or
       (upward-find-file ".svn")
       (or (upward-find-file ".hg")
           (upward-file-file "configure.ac")))))

(defun get-compile-command ()
  "Look for a Rakefile, Makefile, or CMakeLists.txt in the version control folder, and run
the appropriate thing in response.  The only real custom behavior here is that for
CMake and autoconf: I assume we're doing out-of-tree builds with these, in the
`../build' directory above the root."
  (let ((root (get-vc-pathname)))
    (if (not root)
        (message "Cannot find appropriate folder to run compilation")
      (if (file-exists-p (expand-file-name "configure.ac" root))
          (concat "cd " root "/../build && make -k")
        (if (file-exists-p (expand-file-name "Makefile" root))
            (concat "cd " root " && make -k")
          (if (file-exists-p (expand-file-name "Rakefile" root))
              (concat "cd " root " && rake")
            (if (file-exists-p (expand-file-name "CMakeLists.txt" root))
                (concat "cd " root "/../build && cmake -G 'Unix Makefiles' " root " && make -k")
              (message (concat "Don't know how to compile in folder: " root)))))))))


(defun set-compile-command-hook ()
  "Set the compile command either to something that makes sense, or back to the
default of make -k"
  (set (make-local-variable 'compile-command)
       (or (get-compile-command)
           "make -k")))

;; Notify with todochiku when compilation finishes
(defun cp-compile-todochiku-notify (buffer msg)
  (if (string-match "^finished" msg)
      (progn
        (delete-windows-on buffer)
        (todochiku-message "Compilation" "Compilation finished successfully"
                           (todochiku-icon 'compile)))
    (todochiku-message "Compilation" "Compilation failed"
                       (todochiku-icon 'alert)))
    (setq current-frame (car (car (cdr (current-frame-configuration)))))
    (select-frame-set-input-focus current-frame))
(if (featurep 'todochiku) (add-hook 'compilation-finish-functions
                                    'cp-compile-todochiku-notify))

;; Since I'm setting the command intelligently, don't confirm it
(setq compilation-read-command nil
      compilation-scroll-output t)

;; Set the compilation command for languages in which it makes sense (C, ASM,
;; Ruby), and also for a few things that are always bundled with those
;; projects (RHTML, YAML, HAML, etc.)
(add-hook 'c-mode-hook 'set-compile-command-hook)
(add-hook 'asm-mode-hook 'set-compile-command-hook)
(add-hook 'python-mode-hook 'set-compile-command-hook)
(add-hook 'ruby-mode-hook 'set-compile-command-hook)
(add-hook 'rhtml-mode-hook 'set-compile-command-hook)
(add-hook 'haml-mode-hook 'set-compile-command-hook)
(add-hook 'yaml-mode-hook 'set-compile-command-hook)

;; Bind a nice global key
(global-set-key (kbd "<f7>") 'compile)

