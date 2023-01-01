(use-package modus-themes
  :demand t
  :init
  ;; set green comments and green code strings
  (setq modus-themes-common-palette-overrides
	'((comment green-intense)
	  (string green-intense)))
  :config
  ;; 'modus-operandi is the white theme version
  (load-theme 'modus-vivendi :no-confirm)
  :bind ("<f5>" . modus-themes-toggle))

(provide 'init-themes)
