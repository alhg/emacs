;; default is ("" "%b - GNU Emacs at " system-name)
;; "%b" is name of buffer
(setq frame-title-format '("%b"))

(setq-default column-number-mode t) ;; display column number beside line number on modeline
(display-time)                      ;; display time on modeline

(global-hl-line-mode +1)       ;; positive turns on global highlight line
(setq blink-cursor-interval 0) ;; 0 stops blinking cursor
(setq x-stretch-cursor t)      ;; stretch cursor to fit width of character. Useful for detecting tabs.

;; pulses current line when switching windows or using scroll commands
(use-package pulsar
  :config
  (pulsar-global-mode +1))

(provide 'init-ui)
