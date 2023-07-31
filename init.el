;;; init.el --- Emacs Config -*- lexical-binding: t -*-

;;; Commentary:

;;; Code:

;; bootstrap straight.el package manager
;; (setq straight-repository-branch "develop") ;; sometimes needed if latest emacs breaks straight
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

;; tell emacs to use latest emacs instead of built-in
(condition-case nil
    (straight-use-package 'org)
  (error
   (display-warning 'init "Could not install latest org-mode. Falling back to bundled version.")))

;; Have straight work with use-package macro for simple configuration
(straight-use-package 'use-package)

;; configure use-package to always use straight.el by default, no more :straight t
(use-package straight
  :custom
  (straight-use-package-by-default t))

;; add lisp/ directory
(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))

(require 'init-general)     ;; general emacs configuration settings
(require 'init-ui)          ;; emacs ui settings
(require 'init-os)          ;; OS specific settings
(require 'init-evil)        ;; vim keybindings
(require 'init-programming) ;; programming configuration
(require 'init-git)         ;; git interface
(require 'init-completion)  ;; minibuffer completion
(require 'init-terminal)    ;; terminal emulation
(require 'init-misc)        ;; misc

;;; init.el ends here
