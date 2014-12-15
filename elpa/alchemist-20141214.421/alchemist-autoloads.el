;;; alchemist-autoloads.el --- automatically extracted autoloads
;;
;;; Code:
(add-to-list 'load-path (or (file-name-directory #$) (car load-path)))

;;;### (autoloads nil "alchemist" "alchemist.el" (21646 12684 995401
;;;;;;  0))
;;; Generated autoloads from alchemist.el

(autoload 'alchemist-version "alchemist" "\
Display Alchemist's version.

\(fn &optional SHOW-VERSION)" t nil)

(autoload 'alchemist-mode "alchemist" "\
Toggle alchemist mode.

Key bindings:
\\{alchemist-mode-map}

\(fn &optional ARG)" t nil)

;;;***

;;;### (autoloads nil "alchemist-iex" "alchemist-iex.el" (21646 12685
;;;;;;  19401 0))
;;; Generated autoloads from alchemist-iex.el

(defalias 'run-elixir 'alchemist-iex-run)

(autoload 'alchemist-iex-run "alchemist-iex" "\
Start an IEx process.
Show the IEx buffer if an IEx process is already run.

\(fn &optional ARG)" t nil)

(autoload 'alchemist-iex-project-run "alchemist-iex" "\
Start an IEx process with mix 'iex -S mix' in the
context of an Elixir project.
Show the IEx buffer if an IEx process is already run.

\(fn)" t nil)

;;;***

;;;### (autoloads nil nil ("alchemist-buffer.el" "alchemist-company.el"
;;;;;;  "alchemist-compile.el" "alchemist-complete.el" "alchemist-execute.el"
;;;;;;  "alchemist-help.el" "alchemist-hooks.el" "alchemist-message.el"
;;;;;;  "alchemist-mix.el" "alchemist-pkg.el" "alchemist-project.el"
;;;;;;  "alchemist-utils.el") (21646 12685 30855 578000))

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; End:
;;; alchemist-autoloads.el ends here