;;; TomorrowNight-theme.el --- Custom face theme for Emacs

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

(deftheme TomorrowNight
  "")

(let ((background "#1d1f21")
      (cursor "#aeafad")
      (curline "#282a2e")
      (selection "#373b41")
      (foreground "#c5c8c6")
      (comment "#969896")
      (red "#cc6666")
      (orange "#de935f")
      (yellow "#f0c674")
      (green "#b5bd68")
      (aqua "#8abeb7")
      (blue "#81a2be")
      (purple "#b294bb")
      (errorfg "#ced2cf")
      (errorbg "#df5f5f"))
  
  (custom-theme-set-faces
   'TomorrowNight
   `(default ((t (:background ,background :foreground ,foreground))))
   `(cursor ((t (:background ,cursor :foreground "#000000"))))
   `(region ((t (:background ,selection))))
   `(mode-line ((t (:background ,foreground :foreground ,curline))))
   `(mode-line-inactive ((t (:background ,curline :foreground ,foreground))))
   `(fringe ((t (:background ,curline))))
   `(minibuffer-prompt ((t (:foreground ,orange))))
   `(font-lock-builtin-face ((t (:foreground ,blue))))
   `(font-lock-comment-face ((t (:foreground ,comment))))
   `(font-lock-constant-face ((t (:foreground ,orange))))
   `(font-lock-function-name-face ((t (:foreground ,blue))))
   `(font-lock-keyword-face ((t (:foreground ,purple))))
   `(font-lock-string-face ((t (:foreground ,green))))
   `(font-lock-type-face ((t (:foreground ,yellow))))
   `(font-lock-variable-name-face ((t (:foreground ,red))))
   `(font-lock-warning-face ((t (:background ,errorbg :foreground ,errorfg))))
   `(isearch ((t (:background ,selection))))
   `(lazy-highlight ((t (:background ,curline))))
   '(link ((t (:underline t))))
   '(link-visited ((t (:underline t))))
   '(button ((t (:underline t))))
   `(header-line ((t (:background ,foreground :foreground ,curline))))
   `(hl-line ((t (:background ,curline))))
   `(show-paren-match-face ((t (:background ,selection))))
   `(show-paren-mismatch-face ((t (:background ,errorbg :foreground ,errorfg))))
   '(font-latex-sectioning-0-face ((t (:inherit font-latex-sectioning-1-face :height unspecified))))
   '(font-latex-sectioning-1-face ((t (:inherit font-latex-sectioning-2-face :height unspecified))))
   '(font-latex-sectioning-2-face ((t (:inherit font-latex-sectioning-3-face :height unspecified))))
   '(font-latex-sectioning-3-face ((t (:inherit font-latex-sectioning-4-face :height unspecified))))
   '(font-latex-sectioning-4-face ((t (:inherit font-latex-sectioning-5-face :height unspecified))))
   `(font-latex-sectioning-5-face ((t (:inherit default :bold t :height unspecified :foreground ,green))))
   '(font-latex-slide-title-face ((t (:bold t))))
   '(font-latex-italic-face ((t (:inherit default :foreground unspecified :slant italic))))
   `(font-latex-string-face ((t (:foreground ,green))))
   `(muse-link ((t (:foreground ,red :underline t :weight unspecified))))
   `(muse-bad-link ((t (:background ,errorbg :foreground ,errorfg))))
   `(muse-verbatim ((t (:foreground ,comment))))
   '(muse-header-1 ((t (:inherit muse-header-2 :height unspecified))))
   '(muse-header-2 ((t (:inherit muse-header-3 :height unspecified))))
   '(muse-header-3 ((t (:inherit muse-header-4 :height unspecified))))
   '(muse-header-4 ((t (:inherit muse-header-5 :height unspecified))))
   `(muse-header-5 ((t (:inherit default :bold t :height unspecified :foreground ,green))))
   '(tabbar-default ((t (:background "#b4b4b4"))))
   '(tabbar-unselected ((t (:background "#d6d7d6" :foreground "#000000" :box nil))))
   '(tabbar-selected ((t (:background "#e7e7e7" :foreground "#000000" :box nil))))
   '(tabbar-separator ((t (:height 0.7))))
   )
)
(provide-theme 'TomorrowNight)

;; Local Variables:
;; no-byte-compile: t
;; End:

;;; TomorrowNight-theme.el  ends here
