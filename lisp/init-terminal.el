;;; init-terminal.el --- Terminal Settings  -*- lexical-binding: t -*-

;;; Commentary:

;;; Code:

;; eat
;; "char" mode - Use C-M-m or M-RET to switch to semi-char mode
;; "semi-char" mode
;;   - C-c C-e to switch to emacs mode
;; "emacs" mode
;;   - C-c C-j to switch to semi-char mode
;;   - C-c M-d to switch to char mode
(use-package eat
  ;; :hook
  ;; (eshell-load-hook . 'eat-eshell-mode)
  ;; :config
  ;; (setq eshell-visual-commands '())
  )

;; (use-package eshell
;;   :after eat
;;   :hook
;;   (eshell-load-hook . 'eat-eshell-mode)
;;   :config
;;   ;; now that we use eat-eshell-mode, eshell won't need to send
;;   ;; visual commands to term-mode
;;   (setq eshell-visual-commands '()))

(use-package vterm)

(provide 'init-terminal)

;;; init-terminal.el ends here
