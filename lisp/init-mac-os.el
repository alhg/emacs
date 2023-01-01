(when (string-equal system-type 'darwin)
  (progn
    ;; sets option key 'alt,command key is 'meta
    (setq mac-option-modifier 'alt
	  mac-right-option-modifier 'alt
	  mac-command-modifier 'meta)
    ;; sets fn-delete to be delete-char
    (global-set-key [kp-delete] 'delete-char)))

(provide 'init-mac-os)
