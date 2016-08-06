;; NobbZ init.el
;; Real stuff happens in =settings.org=

(require 'package)
(setq package-archives
      '(("gnu"   . "http://elpa.gnu.org/packages/")
        ("melpa" . "http://melpa.org/packages/")
        ("org"   . "http://orgmode.org/elpa/")))
(when (boundp 'package-pinned-packages)
  (setq package-pinned-packages
        '((org . "org"))))
(package-initialize)
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(eval-when-compile
  (require 'use-package))

;; Set the load path
(add-to-list 'load-path "~/.emacs.d/lisp/")
(add-to-list 'load-path "~/.emacs.d/vendor/org/lisp" t)
(add-to-list 'load-path "~/.emacs.d/vendor/org/contrib/lisp" t)

;; Moved all the custom.el stuff into its own file called
;; =~/.emacs.d/customize.el=
(setq custom-file "~/.emacs.d/customize.el")
(load custom-file)

(setq hostname
  (replace-regexp-in-string "\\`[ \t\n]*" ""
    (replace-regexp-in-string "[ \t\n]*\\'" ""
      (shell-command-to-string "hostname"))))

(require 'org)
(defface org-block-begin-line
  '((t (:foreground "#99968b" :background "#303030")))
  "Face used for line delimiting the begin of source blocks.")

(defface org-block-end-line
  '((t (:foreground "#99968b" :background "#303030")))
  "Face used for line delimiting the end of source blocks.")

(org-babel-load-file "~/.emacs.d/settings.org")
