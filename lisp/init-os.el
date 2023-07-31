;;; init-os.el --- OS Specific Configuration  -*- lexical-binding: t -*-

;;; Commentary:

;;; Code:

;; macOS
(when (string-equal system-type 'darwin)
  (progn
    ;; sets option key 'alt,command key is 'meta
    (setq mac-option-modifier 'alt
	  mac-right-option-modifier 'alt
	  mac-command-modifier 'meta)
    ;; sets fn-delete to be delete-char
    (global-set-key [kp-delete] 'delete-char)))


;; Windows
(when (string-equal system-type "windows-nt")
  (progn
    ;; deleting moves it to Window's recycling bin
    (setq delete-by-moving-to-trash t)))


(provide 'init-os)

;;; init-os.el ends here
