;; prefer eldoc buffer over minibuffer
(setq eldoc-echo-area-prefer-doc-buffer t)
;; limit minibuffer expansion to 3 lines
(setq eldoc-echo-area-use-multiline-p 3)

(use-package eglot
  :config
  (add-to-list 'eglot-server-programs '((rust-ts-mode rust-mode) "rust-analyzer")))

(provide 'init-eglot)
