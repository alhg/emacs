(use-package nov
  :init
  (add-to-list 'auto-mode-alist '("\\.epub\\'" . nov-mode))
  ;;:config
  ;;(setq nov-text-width 80)
  )

(provide 'init-nov)
