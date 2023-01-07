(use-package rust-mode
  :hook
  (rust-mode . (lambda ()
		 (eglot-ensure)
		 (setq indent-tabs-mode nil)
		 (eldoc-mode +1)))
  :config
  ;;(setq rust-format-on-save t)
  )

(provide 'init-rust-mode)
