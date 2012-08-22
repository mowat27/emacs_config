;;; .loaddefs.el --- automatically extracted autoloads
;;
;;; Code:


;;;### (autoloads (midje-mode) "midje-mode/midje-mode" "midje-mode/midje-mode.el"
;;;;;;  (20531 15644))
;;; Generated autoloads from midje-mode/midje-mode.el

(autoload 'midje-mode "midje-mode/midje-mode" "\
A minor mode for running Midje tests when in `slime-mode'.

\\{midje-mode-map}

\(fn &optional ARG)" t nil)

(defun midje-mode-maybe-enable nil "\
Enable midje-mode if the current buffer contains a \"midje.\" string." (let ((regexp "midje\\.")) (save-excursion (when (or (re-search-backward regexp nil t) (re-search-forward regexp nil t)) (midje-mode t)))))

(add-hook 'clojure-mode-hook 'midje-mode-maybe-enable)

;;;***

;;;### (autoloads nil nil ("el-get/el-get-install.el" "el-get/el-get.el"
;;;;;;  "midje-mode/clojure-jump-to-file.el" "midje-mode/midje-mode-pkg.el"
;;;;;;  "midje-mode/midje-mode-praise.el") (20531 15645 331900))

;;;***

(provide '.loaddefs)
;; Local Variables:
;; version-control: never
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; .loaddefs.el ends here
