;; Some basic settings
(setq frame-title-format '("%b"))
(setq ring-bell-function 'ignore)
(setq use-short-answers t)

(setq initial-buffer-choice t) ; always start with *scratch*

(setq switch-to-buffer-obey-display-actions t)

;;; PACKAGE CONFIGURATION ;;;
(require 'package)
(setq package-archives '(("melpa" . "https://melpa.org/packages/")
						 ("elpa" . "https://elpa.gnu.org/packages/")))
(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

;; setup use-package, which is a nicer way of organizing config
(unless (package-installed-p 'use-package)
  (package-install 'use-package))

;; Configure and load use-package
(require 'use-package)
(setq use-package-always-ensure t)

(eval-when-compile
  (defvar use-package-verbose t)
  (require 'use-package))

;; NOTE on use-package
;; :init runs code before package is loaded
;; :config runs code after package is loaded
;; :ensure installs package if not found on system. Set to nil if its a builtin package
;; :defer defers loading of package until needed.

;; diminish is used on use-package configuration to remove minior mode strings
;; from appearing modeline, with :diminish
(use-package diminish)

;; Get PATH from shell
(use-package exec-path-from-shell
  :config
  (when (memq window-system '(mac ns x))
    (exec-path-from-shell-initialize))
  (when (daemonp)
    (exec-path-from-shell-initialize)))

;;; GENERAL CONFIGURATION ;;;
;; place emacs generated custom settings to another file
(setq custom-file (concat user-emacs-directory "custom.el"))
(load custom-file 'noerror)


;; turn off annoyances
(setq make-backup-files nil)
(setq auto-save-default nil)

(transient-mark-mode +1) ;; highlight area when setting mark

(setq blink-cursor-interval 0)

(use-package paren
  ;; highlight matching parens/delimiters
  :ensure nil
  :config
  (setq show-paren-delay 0.1
		show-paren-highlight-openparen t
		show-paren-when-point-inside-paren t
		show-paren-when-point-in-periphery t)
  (show-paren-mode 1))

;; display line numbers & highlight line for text and programming mode
;; buffers only so we avoid situations like vterm having line numbers/highlight line
;;(setq display-line-numbers 'relative)
(add-hook 'text-mode-hook #'display-line-numbers-mode)
(add-hook 'prog-mode-hook #'display-line-numbers-mode)
(global-hl-line-mode +1)

;; show extra information on modeline
(setq-default column-number-mode t)
(display-time)

;; make cursor the width of the character it is under
;; i.e. full width of a TAB
(setq x-stretch-cursor t)

;; change the recenter-top-bottom behavior to leave lines when on top or bottom
(setq scroll-margin 3)

;; move based on visual lines
(setq line-move-visual t)

;; create more unique buffer names when there are duplicates
(use-package uniquify
  :ensure nil
  :config
  (setq uniquify-buffer-name-style 'post-forward))

;;; KEYBINDING CONFIGURATIONS ;;;
(global-set-key (kbd "M-n") #'forward-paragraph)
(global-set-key (kbd "M-p") #'backward-paragraph)

;; Crux, a Collection of Ridiculously Useful eXtensions for Emacs.
(use-package crux
  :bind
  ;; goes to beginning of line of first char, then column 0 if used again
  (("C-a" . crux-move-beginning-of-line)
   ;; kills up to end of line, then kills whole line if used again
   ("C-k" . crux-smart-kill-line)
   ("M-o" . crux-other-window-or-switch-buffer)
   ;; opens new buffer to init.el file
   ("C-c i" . crux-find-user-init-file)))

;; show all possible keyboard shortcuts
(use-package which-key
  :diminish
  :config
  (which-key-mode +1))

;; fido is ido-like mode that has vertical-mode
;;(fido-vertical-mode 1)
;;(fido-vertical-mode -1)

(use-package selectrum
  :config
  (selectrum-mode +1))

(use-package selectrum-prescient
  :config
  ;; make sorting and filtering more intelligent, using frequency and recency
  (selectrum-prescient-mode +1)
  ;; saves command history to disk, to improve sorting
  (prescient-persist-mode +1))

;; Enable rich annotations using the Marginalia package
(use-package marginalia
  :init
  (marginalia-mode 1))

;; Add pulse on line of cursor when it jumps vertically or to windows.
;; Helps visually know where the cursor is more quickly
(use-package pulsar
  :config
  (pulsar-global-mode 1))

;; TODO: Do I need this package?
(use-package savehist
  :config
  (savehist-mode +1))

;; Best git interface
(use-package magit
  :custom
  (git-commit-summary-max-length 50)
  (git-commit-fill-column 72)
  :config
  (remove-hook 'magit-status-headers-hook 'magit-insert-tags-header)
  (global-git-commit-mode 1))

;; isearch replacement
;; (use-package ctrlf
;;   :config
;;   (ctrlf-mode 1))

(use-package flycheck)
;;  :init
;;  (global-flycheck-mode)
;;  :config
;;  (setq flycheck-global-modes '(not c-mode))

;; compilation settings
(setq compilation-scroll-output 'first-error) ;; always scroll to the first error

;; c/c++ stuff
(setq c-default-style "linux")
(setq-default c-basic-offset 4)
(setq-default tab-width 4)

;; have syntax highlighting up to modern C++20
(use-package modern-cpp-font-lock)

;; d stuff
(use-package d-mode
  :defer t)

;; go stuff
(use-package go-mode
  :defer t
  :hook (before-save . gofmt-before-save))

;; Go - lsp-mode
;; Set up before-save hooks to format buffer and add/delete imports.
(defun lsp-go-install-save-hooks ()
  (add-hook 'before-save-hook #'lsp-format-buffer t t)
  (add-hook 'before-save-hook #'lsp-organize-imports t t))

;;; JAVA CONFIGURATION ;;;
;; setting indent-tabs-mode to nil will have spaces for indentation
(add-hook 'java-mode-hook
		  (lambda ()
			(setq c-default-style "java"
				  tab-width 2
                  indent-tabs-mode nil)))

;;; LUA CONFIGURATION ;;;
(use-package lua-mode
  :defer t)

;;; PYTHON CONFIGURATION ;;;
(setq python-shell-interpreter "python3"
      python-shell-interpreter-args "-i")

(use-package elpy
  :defer t
  :config
  (elpy-enable))

;;; OCaml Configuration ;;;
(use-package tuareg
  :defer t)

;;; racket  Configuration
(use-package racket-mode
  :defer t)

;; rust stuff
;; (use-package rustic
;;   :defer t
;;   :bind (:map rustic-mode-map
;;               ("M-j" . lsp-ui-imenu)
;;               ("M-?" . lsp-find-references)
;;               ("C-c C-c l" . flycheck-list-errors)
;;               ("C-c C-c a" . lsp-execute-code-action)
;;               ("C-c C-c r" . lsp-rename)
;;               ("C-c C-c q" . lsp-workspace-restart)
;;               ("C-c C-c Q" . lsp-workspace-shutdown)
;;               ("C-c C-c s" . lsp-rust-analyzer-status))
;;   :config
;;   ;; uncomment for less flashiness
;;   (setq lsp-eldoc-hook nil)
;;   (setq lsp-enable-symbol-highlighting nil)
;;   (setq lsp-signature-auto-activate nil)

;;   ;; comment to disable rustfmt on save
;;   (setq rustic-format-on-save t)
;;   ;; Default is pop-to-buffer, but I don't like cursor switching to other buffer.
;;   (setq rustic-format-display-method 'display-buffer)
;;   (add-hook 'rustic-mode-hook 'rk/rustic-mode-hook))

;; (defun rk/rustic-mode-hook ()
;;   ;; so that run C-c C-c C-r works without having to confirm
;;   (setq-local buffer-save-without-query t))

;; sml
(use-package sml-mode
  :defer t)

;; Web Stuff
;; Typescript
(use-package typescript-mode
  :config
  (setq typescript-indent-level 2))
;; (use-package tide
;;   :after (typescript-mode company flycheck)
;;   :config
;;   (add-hook 'typescript-mode-hook #'setup-tide-mode)
;;   (add-to-list 'auto-mode-alist '("\\.ts\\'" . typescript-mode)))

;; (defun setup-tide-mode ()
;;   (interactive)
;;   (setq typescript-indent-level 2)
;;   (tide-setup)
;;   (flycheck-mode 1)
;;   (setq flycheck-check-syntax-automatically '(save mode-enabled))
;;   (eldoc-mode 1)
;;   (tide-hl-identifier-mode 1)
;;   (company-mode 1)
;;   (prettier-mode 1))


;; ;; Prettier
;; (use-package prettier)

;; zig
(use-package zig-mode
  :defer t
  :mode ("\\.zig\\'" . zig-mode))

;; elgot

;; lsp stuff
;; (use-package lsp-mode
;;   :commands (lsp lsp-deferred)
;;   :hook
;;   ((go-mode . lsp-deferred)
;;    (lsp-mode . lsp-enable-which-key-integration))

;;   :custom
;;   (lsp-keymap-prefix "C-c C-l")
;;   (lsp-log-io nil) ;; only turn on if you need to debug lsp
;;   (lsp-eldoc-render-all t)
;;   (lsp-idle-delay 0.6)

;;   ;; Rust
;;   ;; what to use when checking on-save. "check" is default, I prefer clippy
;;   (lsp-rust-analyzer-cargo-watch-command "clippy")
;;   (lsp-rust-analyzer-display-chaining-hints t)
;;   (lsp-rust-analyzer-display-parameter-hints nil) ;; super annoying, interrupts editing
;;   (lsp-rust-analyzer-server-display-inlay-hints nil)
;;   (lsp-rust-analyzer-macro-expansion-method (quote rustic-analyzer-macro-expand))
;;   (lsp-rust-full-docs t)

;;   :init
;;   (setq lsp-keymap-prefix "C-c l")

;;   :config
;;   (add-hook 'lsp-mode-hook 'lsp-ui-mode))


;; (use-package lsp-ui
;;   :defer t
;;   :diminish
;;   :commands lsp-ui-mode
;;   :custom
;;   ;;(lsp-ui-peek-always-show t)
;;   ;;(lsp-ui-sideline-show-hover t)xo
;;   (lsp-ui-doc-enable nil)
;;   ;;(lsp-ui-doc-alignment (quote window))
;;   ;;(lsp-ui-doc-position (quote top))
;;   )

;; code completion
(use-package company
  :diminish
  :custom
  (company-minimum-prefix-length 1)
  (company-idle-delay 0.0) ;; default is 0.2
  ;; (company-begin-commands nil) ;; uncomment to disable popup
  :bind
  (:map company-active-map
		("C-n". company-select-next)
		("C-p". company-select-previous)
		("M-<". company-select-first)
		("M->". company-select-last)))

;; lsp's rust company mode requires yasnippet for code completion
;; (use-package yasnippet
;;   :diminish
;;   :config
;;   ;; Need this if we only use yas-minor-mode.
;;   ;; Will load the snippet table before yas-minor-mode is called
;;   (yas-reload-all)
;;   (add-hook 'rustic-mode-hook #'yas-minor-mode)
;;   (add-hook 'go-mode-hook #'yas-minor-mode))

(use-package nov
  :defer t
  :init
  (add-to-list 'auto-mode-alist '("\\.epub\\'" . nov-mode))
  :config
  (setq nov-text-width 80))

;; Frame background transperancy
;;(set-frame-parameter (selected-frame) 'alpha '(90 90)) ;; set current frame alpha
;;(add-to-list 'default-frame-alist '(alpha 90 90)) ;; set a default alpha for new frames

;; Themes
;; modus-themes
;; ef-themes
;; vscode-dark-plus-theme
;; naysayer-theme
(use-package modus-themes
  :bind ("<f5>" . modus-themes-toggle)
  :init
  (modus-themes-load-themes)
  :config
  ;; OR (modus-themes-load-vivendi)
  (modus-themes-load-vivendi))

;; (use-package ef-themes
;;   :bind ("<f6>" . ef-themes-toggle)
;;   :init
;;   Disable all other themes to avoid awkward blending:
;;   (mapc #'disable-theme custom-enabled-themes))
;;   )

;; naysayer theme is based on jon blow's theme, I really like it
;; cause it uses green for comments, which makes it easier to read
;; than light grey in modus-themes
;;(use-package naysayer-theme
;;  :config
;;  (load-theme 'naysayer t)
;;  (set-cursor-color "lightgreen"))

;; timer package, provides timer functionality
(use-package tmr
  :init
  ;; set to nil to disable the sound
  (setq tmr-sound-file "/usr/share/sounds/freedesktop/stereo/alarm-clock-elapsed.oga")
  (setq tmr-notification-urgency 'normal)
  ;; Read the `tmr-descriptions-list' doc string
  (setq tmr-descriptions-list 'tmr-description-history)

  ;; set keybindins
  (let ((map global-map))
	(define-key map (kbd "C-c t t") #'tmr)
	(define-key map (kbd "C-c t T") #'tmr-with-description)
	(define-key map (kbd "C-c t l") #'tmr-tabulated-view) ; "list timers" mnemonic
	(define-key map (kbd "C-c t c") #'tmr-clone)
	(define-key map (kbd "C-c t k") #'tmr-cancel)
	(define-key map (kbd "C-c t s") #'tmr-reschedule)
	(define-key map (kbd "C-c t e") #'tmr-edit-description)
	(define-key map (kbd "C-c t r") #'tmr-remove)
	(define-key map (kbd "C-c t R") #'tmr-remove-finished)))

(defun my-org-hook ()
  (setq fill-column 100)
  (auto-fill-mode 1))
(use-package org
  :config
  (setq org-startup-indented t)
  :hook
  (org-mode . my-org-hook))

;; Linux specific settings
(when (string-equal system-type 'gnu/linux)
  (progn
    (use-package pdf-tools)
    (use-package vterm)))

;; macOS specific settings
(when (string-equal system-type 'darwin)
  (progn
    ;; sets option key to 'alt, command key to 'meta
    (setq mac-option-modifier 'alt
		  mac-right-option-modifier 'alt
		  mac-command-modifier 'meta)
    ;; sets fn-delete to be right-delete
    (global-set-key [kp-delete] 'delete-char)))

;; Windows specific settings
(when (string-equal system-type "windows-nt")
  (progn
    ;; deleting moves it to Window's recycling bin
    (setq delete-by-moving-to-trash t)))

;;; init.el ends here
