;;; ansible-autoloads.el --- automatically extracted autoloads
;;
;;; Code:
(add-to-list 'load-path (or (file-name-directory #$) (car load-path)))

;;;### (autoloads nil "ansible" "ansible.el" (21632 14945 949235
;;;;;;  56000))
;;; Generated autoloads from ansible.el

(defvar ansible::key-map (make-sparse-keymap) "\
Keymap for Ansible.")

(autoload 'ansible "ansible" "\
Ansible minor mode.

\(fn &optional ARG)" t nil)

(autoload 'ansible::snippets-initialize "ansible" "\


\(fn)" nil nil)

(eval-after-load 'yasnippet '(ansible::snippets-initialize))

(autoload 'ansible::dict-initialize "ansible" "\


\(fn)" nil nil)

;;;***

;;;### (autoloads nil nil ("ansible-pkg.el") (21632 14945 963600
;;;;;;  924000))

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; End:
;;; ansible-autoloads.el ends here