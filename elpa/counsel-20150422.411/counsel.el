;;; counsel.el --- Various completion functions using Ivy -*- lexical-binding: t -*-

;; Copyright (C) 2015  Free Software Foundation, Inc.

;; Author: Oleh Krehel <ohwoeowho@gmail.com>
;; URL: https://github.com/abo-abo/swiper
;; Package-Version: 20150422.411
;; Version: 0.1.0
;; Package-Requires: ((emacs "24.1") (swiper "0.3.0"))
;; Keywords: completion, matching

;; This file is part of GNU Emacs.

;; This file is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 3, or (at your option)
;; any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; For a full copy of the GNU General Public License
;; see <http://www.gnu.org/licenses/>.

;;; Commentary:
;;
;; Just call one of the interactive functions in this file to complete
;; the corresponding thing using `ivy'.
;;
;; Currently available: Elisp symbols, Clojure symbols, Git files.

;;; Code:

(require 'swiper)

(defun counsel-el ()
  "Elisp completion at point."
  (interactive)
  (counsel--generic
   (lambda (str) (all-completions str obarray))))

(defvar counsel-describe-map
  (let ((map (make-sparse-keymap)))
    (define-key map (kbd "C-.") 'counsel-find-symbol)
    map))

(defun counsel-find-symbol ()
  "Jump to the definition of the current symbol."
  (interactive)
  (setq ivy--action 'counsel--find-symbol)
  (setq ivy-exit 'done)
  (exit-minibuffer))

(defun counsel--find-symbol ()
  (let ((sym (read ivy--current)))
    (cond ((boundp sym)
           (find-variable sym))
          ((fboundp sym)
           (find-function sym))
          ((or (featurep sym)
               (locate-library
                (prin1-to-string sym)))
           (find-library (prin1-to-string sym)))
          (t
           (error "Couldn't fild definition of %s"
                  sym)))))

(defvar counsel-describe-symbol-history nil
  "History for `counsel-describe-variable' and `counsel-describe-function'.")

(defun counsel-describe-variable (variable &optional buffer frame)
  "Forward to (`describe-variable' VARIABLE BUFFER FRAME)."
  (interactive
   (let ((v (variable-at-point))
         (enable-recursive-minibuffers t)
         (preselect (thing-at-point 'symbol))
         val)
     (setq ivy--action nil)
     (setq val (ivy-read
                "Describe variable: "
                (let (cands)
                  (mapatoms
                   (lambda (vv)
                     (when (or (get vv 'variable-documentation)
                               (and (boundp vv) (not (keywordp vv))))
                       (push (symbol-name vv) cands))))
                  cands)
                :keymap counsel-describe-map
                :preselect preselect
                :history 'counsel-describe-symbol-history
                :require-match t
                :sort t))
     (list (if (equal val "")
               v
             (intern val)))))
  (unless (eq ivy--action 'counsel--find-symbol)
    (describe-variable variable buffer frame)))

(defun counsel-describe-function (function)
  "Forward to (`describe-function' FUNCTION) with ivy completion."
  (interactive
   (let ((fn (function-called-at-point))
         (enable-recursive-minibuffers t)
         (preselect (thing-at-point 'symbol))
         val)
     (setq ivy--action nil)
     (setq val (ivy-read "Describe function: "
                         (let (cands)
                           (mapatoms
                            (lambda (x)
                              (when (fboundp x)
                                (push (symbol-name x) cands))))
                           cands)
                         :keymap counsel-describe-map
                         :preselect preselect
                         :history 'counsel-describe-symbol-history
                         :require-match t
                         :sort t))
     (list (if (equal val "")
               fn (intern val)))))
  (unless (eq ivy--action 'counsel--find-symbol)
    (describe-function function)))

(defvar info-lookup-mode)
(declare-function info-lookup->completions "info-look")
(declare-function info-lookup->mode-value "info-look")
(declare-function info-lookup-select-mode "info-look")
(declare-function info-lookup-change-mode "info-look")
(declare-function info-lookup "info-look")

(defun counsel-info-lookup-symbol (symbol &optional mode)
  "Forward to (`info-describe-symbol' SYMBOL MODE) with ivy completion."
  (interactive
   (progn
     (require 'info-look)
     (let* ((topic 'symbol)
            (mode (cond (current-prefix-arg
                         (info-lookup-change-mode topic))
                        ((info-lookup->mode-value
                          topic (info-lookup-select-mode))
                         info-lookup-mode)
                        ((info-lookup-change-mode topic))))
            (completions (info-lookup->completions topic mode))
            (enable-recursive-minibuffers t)
            (value (ivy-read
                    "Describe symbol: "
                    (mapcar #'car completions))))
       (list value info-lookup-mode))))
  (info-lookup 'symbol symbol mode))

(defun counsel-unicode-char ()
  "Insert a Unicode character at point."
  (interactive)
  (let* ((minibuffer-allow-text-properties t)
         (char (ivy-read "Unicode name: "
                         (mapcar (lambda (x)
                                   (propertize
                                    (format "% -60s%c" (car x) (cdr x))
                                    'result (cdr x)))
                                 (ucs-names)))))
    (insert-char (get-text-property 0 'result char))))

(declare-function cider-sync-request:complete "ext:cider-client")
(defun counsel-clj ()
  "Clojure completion at point."
  (interactive)
  (counsel--generic
   (lambda (str)
     (mapcar
      #'cl-caddr
      (cider-sync-request:complete str ":same")))))

(defun counsel-git ()
  "Find file in the current Git repository."
  (interactive)
  (let* ((default-directory (locate-dominating-file
                             default-directory ".git"))
         (cands (split-string
                 (shell-command-to-string
                  "git ls-files --full-name --")
                 "\n"
                 t))
         (file (ivy-read "Find file: " cands)))
    (when file
      (find-file file))))

(defvar counsel--git-grep-dir nil
  "Store the base git directory.")

(defun counsel-git-grep-count (str)
  "Quickly count the amount of git grep STR matches."
  (let* ((default-directory counsel--git-grep-dir)
         (out (shell-command-to-string
               (format "git grep -i -c '%s' | sed 's/.*:\\(.*\\)/\\1/g' | awk '{s+=$1} END {print s}'"
                       (ivy--regex str)))))
    (string-to-number out)))

(defvar counsel--git-grep-count nil
  "Store the line count in current repository.")

(defun counsel-git-grep-function (string &optional _pred &rest _unused)
  "Grep in the current git repository for STRING."
  (if (and (> counsel--git-grep-count 20000)
           (< (length string) 3))
      (progn
        (setq ivy--full-length counsel--git-grep-count)
        (list ""
              (format "%d chars more" (- 3 (length ivy-text)))))
    (let* ((default-directory counsel--git-grep-dir)
           (cmd (format "git --no-pager grep --full-name -n --no-color -i -e \"%s\""
                        (ivy--regex string t)))
           res)
      (if (<= counsel--git-grep-count 20000)
          (progn
            (setq res (shell-command-to-string cmd))
            (setq ivy--full-length nil))
        (setq res (shell-command-to-string (concat cmd " | head -n 2000")))
        (setq ivy--full-length (counsel-git-grep-count ivy-text)))
      (split-string res "\n" t))))

(defun counsel-git-grep ()
  "Grep for a string in the current git repository."
  (interactive)
  (unwind-protect
       (let* ((counsel--git-grep-dir (locate-dominating-file
                                      default-directory ".git"))
              (counsel--git-grep-count (counsel-git-grep-count ""))
              (ivy--dynamic-function (when (> counsel--git-grep-count 20000)
                                       'counsel-git-grep-function))
              (ivy--persistent-action (lambda (x)
                                        (setq lst (split-string x ":"))
                                        (find-file (expand-file-name (car lst) counsel--git-grep-dir))
                                        (goto-char (point-min))
                                        (forward-line (1- (string-to-number (cadr lst))))
                                        (setq swiper--window (selected-window))
                                        (swiper--cleanup)
                                        (swiper--add-overlays (ivy--regex ivy-text))))
              (val (ivy-read "pattern: " 'counsel-git-grep-function))
              lst)
         (when val
           (funcall ivy--persistent-action val)))
    (swiper--cleanup)))

(defun counsel-locate-function (str &rest _u)
  (if (< (length str) 3)
      (list ""
            (format "%d chars more" (- 3 (length ivy-text))))
    (split-string
     (shell-command-to-string (concat "locate -i -l 20 --regex " (ivy--regex str))) "\n" t)))

(defun counsel-locate ()
  "Call locate."
  (interactive)
  (let* ((ivy--dynamic-function 'counsel-locate-function)
         (val (ivy-read "pattern: " 'counsel-locate-function)))
    (when val
      (find-file val))))

(defun counsel--generic (completion-fn)
  "Complete thing at point with COMPLETION-FN."
  (let* ((bnd (bounds-of-thing-at-point 'symbol))
         (str (if bnd
                  (buffer-substring-no-properties
                   (car bnd) (cdr bnd))
                ""))
         (candidates (funcall completion-fn str))
         (ivy-height 7)
         (res (ivy-read (format "pattern (%s): " str)
                        candidates)))
    (when (stringp res)
      (when bnd
        (delete-region (car bnd) (cdr bnd)))
      (insert res))))

(provide 'counsel)

;;; counsel.el ends here