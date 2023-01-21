;; prefer eldoc buffer over minibuffer
(setq eldoc-echo-area-prefer-doc-buffer t)
;; limit minibuffer expansion to 3 lines
(setq eldoc-echo-area-use-multiline-p 3)

(use-package eglot
  :hook
  (rust-mode . eglot-ensure)
  (rust-ts-mode .eglost-ensure)
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
  ;; shutdown server after killing last managed buffer
  (eglot-autoshutdown t)
  ;;(eglot-ignored-server-capabilities '(:documentHighlightProvider))
  ;; if server-initiated edits should be confirmed with user.
  ;;(eglot-confirm-server-initiated-edits nil)
  :config
  (add-to-list 'eglot-server-programs '((rust-ts-mode rust-mode) "rust-analyzer")))

(provide 'init-eglot)
