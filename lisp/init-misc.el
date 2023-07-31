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

(use-package projectile)

(use-package detached
  :init
  (detached-init)
  :config
  (setq detached-metadata-annotators-alist '((branch . detached--metadata-git-branch)))
  :bind (;; Replace `async-shell-command' with `detached-shell-command'
         ([remap async-shell-command] . detached-shell-command)
         ;; Replace `compile' with `detached-compile'
         ([remap compile] . detached-compile)
         ([remap recompile] . detached-compile-recompile)
         ;; Replace built in completion of sessions with `consult'
         ([remap detached-open-session] . detached-consult-session))
  :custom ((detached-show-output-on-attach t)
           (detached-terminal-data-command system-type)))


(use-package devil)

(use-package rg)


(provide 'init-misc)

;; init-misc.el ends here
