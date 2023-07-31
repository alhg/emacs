;;; init-programming.el --- Emacs Programming Configuration -*- lexical-binding: t -*-

;;; Commentary:

;; This file configures programming languages modes. Also configures
;; eglog, which can use lsp with various lanaguage modes

;;; Code:

;; eldoc shows documentation in minibuffer or buffer.
;; eglot uses it by default to show docs.
(use-package eldoc
  :config
  ;; prefer eldoc buffer over minibuffer
  (setq eldoc-echo-area-prefer-doc-buffer t)
  ;; limit eldoc's minibuffer expansion
  (setq eldoc-echo-area-use-multiline-p 3))


;; 'elgot-ensure will setup eglot in mode, but I prefer to enable eglot manually
(use-package eglot
  ;;:hook
  ;;(rust-mode . eglot-ensure)
  ;;(rust-ts-mode .eglost-ensure)
  :bind (:map eglot-mode-map
	      ("C-c ." . eglot-code-actions)
	      ("C-c e r" . eglot-rename)
	      ("C-c e f" . eglot-format)
	      ("M-?" . xref-find-references)
	      ("M-." . xref-find-definitions)
	      ("C-c f n" . flymake-goto-next-error)
	      ("C-c f p" . flymake-goto-prev-error)
	      ("C-c f d" . flymake-show-project-diagnostics))
  :custom
  ;; shutdown lsp server after killing last managed buffer
  (eglot-autoshutdown t)
  ;;(eglot-ignored-server-capabilities '(:documentHighlightProvider))
  ;; if server-initiated edits should be confirmed with user.
  ;;(eglot-confirm-server-initiated-edits nil)
  :config
  (add-to-list 'eglot-server-programs '((rust-ts-mode rust-mode) "rust-analyzer")))


;; Go configuration
(use-package go-mode)


;; Python configuration
(use-package elpy
  :init
  (elpy-enable))


;; Racket configuration
(use-package racket-mode)


;; Rust configuration
(use-package rust-mode
  ;;:config
  ;;(setq rust-format-on-save t)
  )


;; Zig configuration
(use-package zig-mode)


;; Non-programming file modes
(use-package markdown-mode
  ;; use github flavored markdown for READMEs
  :mode ("README\\.md\\'" . gfm-mode))


(provide 'init-programming)

;;; init-programming.el ends here
