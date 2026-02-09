;;; init-evil.el --- EVIL Configuration -*- lexical-binding: t -*-

;;; Commentary:

;;; Code:

(use-package evil
  :init
  (setq evil-want-keybinding nil)
  ;;:config
  ;; disable vim keybindings in insert mode
  ;;(setq evil-disable-insert-state-bindings t)
  ;;(evil-mode +1)
  )

(use-package evil-collection
  :after evil
  :config
  (setq evil-want-integration t)
  (evil-collection-init))

(provide 'init-evil)
