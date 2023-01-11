(use-package modus-themes
  :demand t
  :init
  (setq modus-themes-common-palette-overrides
	'(
	  (cursor green-intense)
	  ;; set green comments and green code strings
	  (comment green-intense)
	  (string green-intense)
	  ;; active modeline changes
	  (bg-mode-line-active bg-blue-subtle)
	  (fg-mode-line-active fg-main)
	  (border-mode-line-active blue-intense)))
  :config
  ;; 'modus-operandi is the white theme version
  (load-theme 'modus-vivendi :no-confirm)
  :bind ("<f5>" . modus-themes-toggle))

(provide 'init-themes)
