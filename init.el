;; bootstrap straight.el package manager
(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 6))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/radian-software/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

;; have use-package with straight.el
(straight-use-package 'use-package)

;; configure use-package to always use straight.el by default
;; no more :straight t
(use-package straight
  :custom (straight-use-package-by-default t))


;; add lisp/ directory
(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))
;; general emacs config
(require 'init-basic)      ;; basic emacs configuration settings
(require 'init-themes)     ;; emacs theme settings
(require 'init-ui)         ;; emacs ui settings
(require 'init-windows-nt) ;; windows-nt specific settings
(require 'init-mac-os)     ;; macOS specific settings
(require 'init-evil)       ;; vim keybindings

;; third-party plugin configs
(require 'init-completion) ;; minibuffer completion
(require 'init-terminal)   ;; terminal emulation
(require 'init-magit)      ;; git interface
(require 'init-markdown)   ;; markdown files
(require 'init-nov)        ;; read .epub files
(require 'init-org)        ;; org
(require 'init-timer)      ;; timer

;; programming modes
(require 'init-eglot)       ;; lsp configuration
(require 'init-go-mode)     ;; go programming language
(require 'init-python-mode) ;; Python programming language
(require 'init-racket-mode) ;; Racket programming language
(require 'init-rust-mode)   ;; Rust programming language
(require 'init-zig-mode)    ;; Zig programming language
