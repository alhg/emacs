;;; init-general.el --- General Configuration  -*- lexical-binding: t -*-

;;; Commentary:

;;; Code:

(setq ring-bell-function 'ignore) ;; 'ignore stops ring bell from working
(setq use-short-answers t)        ;; changes 'yes-or-no-p to y-or-n-p (emacs 28.1+)

(setq make-backup-files nil) ;; nil makes emacs not make backup files
(setq auto-save-default nil) ;; nil makes emacs not auto save any file-visiting buffers

(setq initial-buffer-choice t) ;; t makes emacs start with *scratch*

;; t makes pop new buffers to a display buffer or rules specified by
;; ‘display-buffer-overriding-action’, ‘display-buffer-alist’, etc.
(setq switch-to-buffer-obey-display-actions t)

;; turn on settings for all programming modes
(add-hook 'prog-mode-hook
	  (lambda ()
	    (electric-pair-local-mode +1)))

;; get $PATH into emacs GUI
(use-package exec-path-from-shell
  :config
  (when (memq window-system '(mac ns x))
    (exec-path-from-shell-initialize)))

;; keybinding changes
(defun go-to-init-file ()
  "Go to emacs user init file"
  (interactive)
  (find-file user-init-file))
(global-set-key (kbd "C-c i") 'go-to-init-file)

(provide 'init-general)

;;; init-general.el ends here
