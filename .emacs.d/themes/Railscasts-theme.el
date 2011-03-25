;;; Railscasts-theme.el --- Custom face theme for Emacs

;; Copyright (C) 2010 .

;; This file is free software: you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This file is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs.  If not, see <http://www.gnu.org/licenses/>.

;;; Code:

(deftheme Railscasts
  "")

(custom-theme-set-faces
 'Railscasts
 '(default ((t (:background "#282828" :foreground "#e6e1dc"))))
 '(cursor ((t (:background "#000000" :foreground "#ffffff"))))
 '(region ((t (:background "#5a647e"))))
 '(mode-line ((t (:background "#e6e1dc" :foreground "#323232"))))
 '(mode-line-inactive ((t (:background "#e6e1dc" :foreground "#333435"))))
 '(fringe ((t (:background "#323232"))))
 '(minibuffer-prompt ((t (:foreground "#ffc66d"))))
 '(font-lock-builtin-face ((t (:foreground "#da4939"))))
 '(font-lock-comment-face ((t (:slant italic :foreground "#bc9458"))))
 '(font-lock-constant-face ((t (:foreground "#6d9cbe"))))
 '(font-lock-function-name-face ((t (:foreground "#ffc66d"))))
 '(font-lock-keyword-face ((t (:foreground "#cc7833"))))
 '(font-lock-string-face ((t (:foreground "#a5c261"))))
 '(font-lock-type-face ((t (:foreground "#6e9cbe"))))
 '(font-lock-variable-name-face ((t (:foreground "#d0d0ff"))))
 '(font-lock-warning-face ((t (:background "#ffffff" :foreground "#990000"))))
 '(isearch ((t (:background "#5a647e"))))
 '(lazy-highlight ((t (:background "#323232"))))
 '(link ((t (:underline t))))
 '(link-visited ((t (:underline t))))
 '(button ((t (:underline t))))
 '(header-line ((t (:background "#e5e5e5" :foreground "#333333")))))

(provide-theme 'Railscasts)

;; Local Variables:
;; no-byte-compile: t
;; End:

;;; Railscasts-theme.el  ends here
