;;; mbo-theme.el --- an Emacs 24 theme based on mbo (tmTheme)
;;
;;; Author: Auto Converted to Emacs 24 by tmtheme-to-deftheme
;;; Version: 1403877865
;;; Original author: Marko Bonaci
;;; Url: https://github.com/emacsfodder/tmThemeToDeftheme
;;; Package-Requires: ((emacs "24.0"))
;;
;;; Commentary:
;;  This theme was automatically generated by tmtheme-to-deftheme,
;;  from mbo (tmTheme) by Marko Bonaci
;;
;;; Code:

(deftheme mbo
  "mbo-theme - Created by tmtheme-to-deftheme - 2014-06-27 22:04:25 +0800")

(custom-theme-set-variables
 'mbo
 '(linum-format " %7i ")
 '(fringe-mode 5 nil (fringe))
)

(custom-theme-set-faces
 'mbo
 ;; basic theming.

 '(default ((t (:foreground "#ffffe9" :background "#2c2c2c"))))
 '(region  ((t (:background "#716C62"))))
 '(cursor  ((t (:background "#ffffec"))))

 ;; Temporary defaults
 '(linum                               ((t (:foreground "#545454"  :background "#393939" ))))
 '(minibuffer-prompt                   ((t (:foreground "#1278A8"  :background nil       :weight bold                                  ))))
 '(escape-glyph                        ((t (:foreground "orange"   :background nil                                                     ))))
 '(highlight                           ((t (:foreground "orange"   :background nil                                                     ))))
 '(shadow                              ((t (:foreground "#777777"  :background nil                                                     ))))
 '(secondary-selection                 ((t (                       :background "#342858"                                               ))))
 '(trailing-whitespace                 ((t (:foreground "#FFFFFF"  :background "#C74000"                                               ))))
 '(link                                ((t (:foreground "#00b7f0"  :background nil       :underline t                                  ))))
 '(link-visited                        ((t (:foreground "#4488cc"                       :underline t :inherit (link)                  ))))
 '(button                              ((t (:foreground "#FFFFFF"  :background "#444444" :underline t :inherit (link)                  ))))
 '(fringe                              ((t (                       :background "#393939" ))))
 '(next-error                          ((t (                                             :inherit (region)                             ))))
 '(query-replace                       ((t (                                             :inherit (isearch)                            ))))
 '(header-line                         ((t (:foreground "#EEEEEE"  :background "#444444" :box nil :inherit (mode-line)                 ))))
 '(mode-line-highlight                 ((t (                                             :box nil                                      ))))
 '(mode-line-emphasis                  ((t (                                             :weight bold                                  ))))
 '(mode-line-buffer-id                 ((t (                                             :box nil :weight bold                         ))))
 '(mode-line-inactive                  ((t (:foreground "#ffff87"  :background "#232323" :box nil :weight light :inherit (mode-line)   ))))
 '(mode-line                           ((t (:foreground "#ffffe9"  :background "#1a1a1a" :box nil ))))
 '(isearch                             ((t (:foreground "#99ccee"  :background "#444444"                                               ))))
 '(isearch-fail                        ((t (                       :background "#ffaaaa"                                               ))))
 '(lazy-highlight                      ((t (                       :background "#77bbdd"                                               ))))
 '(match                               ((t (                       :background "#3388cc"                                               ))))
 '(tooltip                             ((t (:foreground "black"    :background "LightYellow" :inherit (variable-pitch)                 ))))
 '(js3-function-param-face             ((t (:foreground "#BFC3A9"                                                                      ))))
 '(js3-external-variable-face          ((t (:foreground "#F0B090"  :bold t                                                             ))))
 '(cua-rectangle                       ((t (:foreground "#E0E4CC"  :background "#342858" ))))

 ;; flyspell-mode
 '(flyspell-incorrect                  ((t (:underline "#AA0000" :background nil :inherit nil ))))
 '(flyspell-duplicate                  ((t (:underline "#009945" :background nil :inherit nil ))))

 ;; flymake-mode
 '(flymake-errline                     ((t (:underline "#AA0000" :background nil :inherit nil ))))
 '(flymake-warnline                    ((t (:underline "#009945" :background nil :inherit nil ))))

 ;; Magit hightlight
 '(magit-item-highlight                ((t (:foreground "white" :background "#1278A8" :inherit nil ))))

 ;;git-gutter
 '(git-gutter:added                    ((t (:foreground "#609f60" :bold t))))
 '(git-gutter:modified                 ((t (:foreground "#3388cc" :bold t))))
 '(git-gutter:deleted                  ((t (:foreground "#cc3333" :bold t))))

 '(diff-added                          ((t (:background "#305030"))))
 '(diff-removed                        ((t (:background "#903010"))))
 '(diff-file-header                    ((t (:background "#362145"))))
 '(diff-context                        ((t (:foreground "#E0E4CC"))))
 '(diff-changed                        ((t (:foreground "#3388cc"))))
 '(diff-hunk-header                    ((t (:background "#242130"))))

 '(font-lock-comment-face ((t (:foreground "#655e25" ))))
 '(font-lock-string-face ((t (:foreground "#ffcf6c" ))))
 '(font-lock-builtin-face ((t (:foreground "#ffcf6c" ))))
 '(font-lock-variable-name-face ((t ( ))))
 '(font-lock-keyword-face ((t (:foreground "#ffcf6c" ))))
 '(font-lock-type-face ((t (:foreground "#ffffe9" ))))
 '(font-lock-function-name-face ((t (:foreground "#00a8c6" ))))
 '(font-lock-warning-face ((t (:foreground "#ffffed" :background "#004b59"))))
 '(diff-removed ((t (:foreground "#484032" ))))
 '(diff-added ((t (:foreground "#f6dbaa" ))))
 '(diff-changed ((t (:foreground "#ffffdc" ))))
 '(font-lock-comment-delimiter-face ((t (:foreground "#655e25" ))))
)

;; Rainbow delimiters
(defun mbo-rainbow-delim-set-face ()
  (set-face-attribute 'rainbow-delimiters-depth-1-face nil :foreground "#01778b")
  (set-face-attribute 'rainbow-delimiters-depth-2-face nil :foreground "#018398")
  (set-face-attribute 'rainbow-delimiters-depth-3-face nil :foreground "#018fa6")
  (set-face-attribute 'rainbow-delimiters-depth-4-face nil :foreground "#019ab4")
  (set-face-attribute 'rainbow-delimiters-depth-5-face nil :foreground "#01a6c2")
  (set-face-attribute 'rainbow-delimiters-depth-6-face nil :foreground "#02b2d0")
  (set-face-attribute 'rainbow-delimiters-depth-7-face nil :foreground "#02bede")
  (set-face-attribute 'rainbow-delimiters-depth-8-face nil :foreground "#02caec")
  (set-face-attribute 'rainbow-delimiters-depth-9-face nil :foreground "#02d6fa")
  (set-face-attribute 'rainbow-delimiters-unmatched-face nil :foreground "#FF0000"))

(eval-after-load "rainbow-delimiters" '(mbo-rainbow-delim-set-face))

;;;###autoload
(when load-file-name
  (add-to-list 'custom-theme-load-path
               (file-name-as-directory (file-name-directory load-file-name))))

(provide-theme 'mbo)

;; Local Variables:
;; eval: (when (fboundp 'rainbow-mode) (rainbow-mode +1))
;; End:

;;; mbo-theme.el ends here