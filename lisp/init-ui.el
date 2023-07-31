;;; inti-ui.el --- Emacs UI Config -*- lexical-binding: t -*-

;;; Commentary:

;;; Code:

;; modus themse by prot. Really like the colors and ability to
;; customize specific colors
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
  ;; 'modus-vivendi is the black theme version
  (load-theme 'modus-vivendi :no-confirm)
  :bind ("<f5>" . modus-themes-toggle))

;; set default fonts
(defun set-font-if-avail (font-name font)
  (when (find-font (font-spec :name font-name))
    (set-frame-font font)))

(set-font-if-avail "Go Mono" "Go Mono-12")
(cond
 ((string-equal system-type "darwin")
  (set-font-if-avail "SF Mono" "SF Mono-12"))
 ((string-equal system-type "windows-nt")
  (set-font-if-avail "SF Mono" "SF Mono-12")))

;; default is ("" "%b - GNU Emacs at " system-name)
;; "%b" is name of buffer
(setq frame-title-format '("%b"))

(setq-default column-number-mode t) ;; display column number beside line number on modeline
(display-time)                      ;; display time on modeline

;; turn on hl-line only for text and progrmaming modes, avoid for
;; terminal buffers
(add-hook 'text-mode-hook 'hl-line-mode)
(add-hook 'prog-mode-hook 'hl-line-mode)

(setq blink-cursor-interval 0) ;; 0 stops blinking cursor
(setq x-stretch-cursor t)      ;; stretch cursor to fit width of character. Useful for detecting tabs.

;; pulses current line when switching windows or using scroll commands
(use-package pulsar
  :config
  (pulsar-global-mode +1))

(provide 'init-ui)

;; init-ui.el ends here
