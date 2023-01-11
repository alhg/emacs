(use-package magit
  :custom
  (git-commit-summary-max-length 50)
  (git-commit-fill-column 72)
  :config
  ;; remove stuff from magit-status screen to speedup on large codebases
  (remove-hook 'magit-status-headers-hook 'magit-insert-tags-header)
  (add-hook 'git-commit-setup-hook 'toggle-frame-maximized t)
  (global-git-commit-mode 1))

(provide 'init-magit)
