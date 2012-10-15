;; Wishlist
;; -------------------
;;
;; M-x c location aware so you can find <viewdir>/new.html.erb etc
;; S-<arrow> to select text
;; Duplicate a line
;; Copy command
;; Kill whole line
;; Move window borders instead of sizes
;; Flip buffers in 2 windows
;; Line numbers always on
;; Toggle between buffers
;; No prompt on save all
;; Shortcut to indent region
;; Comment block/line ruby
;; Comment sexp paredit
;; Change font size
;; Switch to new window on creation
;; Muti-edit mode

;; Wishlist - sorted!
;; -------------------
;; Goto line shortcut - Texmate mode ⌘L

;; Allow hash to be entered  
(global-set-key (kbd "M-3") '(lambda () (interactive) (insert "#")))
(global-set-key (kbd "M-§") '(lambda () (interactive) (insert "#")))
(global-set-key (kbd "C-§") '(lambda () (interactive) (insert "⌘")))


(global-set-key (kbd "S-C-<left>")  'shrink-window-horizontally)
(global-set-key (kbd "S-C-<right>") 'enlarge-window-horizontally)
(global-set-key (kbd "S-C-<down>")  'shrink-window)
(global-set-key (kbd "S-C-<up>")    'enlarge-window)

;; (autoload 'linum-mode "linum" "toggle line numbers on/off" t) 
(global-set-key (kbd "C-<f5>") 'linum-mode)

; Windows and buffers
(add-to-list 'same-window-buffer-names "*Buffer List*")

;; Setup packages
(require 'package)
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
(add-to-list 'package-archives '("elpa"      . "http://tromey.com/elpa/"))
(package-initialize)

;; Add in your own as you wish:
(defvar my-packages '(starter-kit starter-kit-lisp starter-kit-bindings starter-kit-ruby clojure-mode ac-slime auto-complete)
  "A list of packages to ensure are installed at launch.")

(dolist (p my-packages)
  (when (not (package-installed-p p))
    (package-install p)))

;; Setup colors
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")
(load-theme 'twilight t)

;; Modes
(global-linum-mode t)
(add-to-list 'auto-mode-alist '("*" . textmate-mode))
(add-to-list 'auto-mode-alist '("\\.coffee$" . coffee-mode))
(add-to-list 'auto-mode-alist '("Cakefile"   . coffee-mode))
(add-to-list 'auto-mode-alist '("\\.html.*" . auto-complete-mode))
(add-to-list 'auto-mode-alist '("\\.html.*" . html-mode))
(add-to-list 'auto-mode-alist '("\\.html"   . html-mode))
(add-to-list 'auto-mode-alist '("\\.haml"   . haml-mode))
(add-to-list 'auto-mode-alist '("\\.sass"   . sass-mode))
(add-to-list 'auto-mode-alist '("\\.css"    . css-mode))
(add-to-list 'auto-mode-alist '("\\.scss"   . css-mode))

; autocomplete for slime
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/dict")
(ac-config-default)

(require 'ac-slime)
(add-hook 'slime-mode-hook 'set-up-slime-ac)
(add-hook 'slime-repl-mode-hook 'set-up-slime-ac)
(eval-after-load "auto-complete"
  '(add-to-list 'ac-modes 'slime-repl-mode))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes (quote ("6cfe5b2f818c7b52723f3e121d1157cf9d95ed8923dbc1b47f392da80ef7495d" default)))
 '(fill-column 7000)
 '(textmate-mode t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )


(defadvice ruby-indent-line (after line-up-args activate)
  (let (indent prev-indent arg-indent)
    (save-excursion
      (back-to-indentation)
      (when (zerop (car (syntax-ppss)))
        (setq indent (current-column))
        (skip-chars-backward " \t\n")
        (when (eq ?, (char-before))
          (ruby-backward-sexp)
          (back-to-indentation)
          (setq prev-indent (current-column))
          (skip-syntax-forward "w_.")
          (skip-chars-forward " ")
          (setq arg-indent (current-column)))))
    (when prev-indent
      (let ((offset (- (current-column) indent)))
        (cond ((< indent prev-indent)
               (indent-line-to prev-indent))
              ((= indent prev-indent)
               (indent-line-to arg-indent)))
        (when (> offset 0) (forward-char offset))))))

(setq ruby-deep-indent-paren nil)

(setq css-electric-keys nil)

(add-to-list 'load-path "~/.emacs.d/")
(load "revbufs.el")
