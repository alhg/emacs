;; windows-nt specific settings
(when (string-equal system-type "windows-nt")
  (progn
    ;; deleting moves it to Window's recycling bin
    (setq delete-by-moving-to-trash t)))

(provide 'init-windows-nt)
