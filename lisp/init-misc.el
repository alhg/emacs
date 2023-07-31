;;; init-misc.el --- Misc Configuration -*- lexical-binding: t -*-

;;; Commentary:

;;; Code:

;; nov can display epub books
(use-package nov
  :init
  (add-to-list 'auto-mode-alist '("\\.epub\\'" . nov-mode))
  :config
  (setq nov-text-width 80))


(use-package org
  :hook (org-mode . (lambda ()
		      (auto-fill-mode +1))))

;; provides timer notification functionality
(use-package tmr)

(provide 'init-misc)

;; init-misc.el ends here
