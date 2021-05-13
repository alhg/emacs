;; this init.el assumes you are using emacs 27+

;; Add melpa to the package list and initialize our packages
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(package-initialize)

;; setup use-package, which is a nicer way of organizing config
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

;; Configure and load use-package
(setq use-package-always-ensure t)

(eval-when-compile
  (defvar use-package-verbose t)
  (require 'use-package))

;; have emacs autogenerate compile files when it loads a new .elc file
;; will freeze emacs when it is compiling
(setq comp-deferred-compilation t)

;; diminish is used on packages to remove/change minor mode strings in modeline
(use-package diminish
  :ensure t)

;; place emacs generated custom settings to another file
(setq custom-file (concat user-emacs-directory "custom.el"))
(load custom-file 'noerror)

;; Best git interface
(use-package magit
  :ensure t)

;; Theme
;; modus-operandi-theme (light)
;; modus-vivendi-theme (dark)
;; vscode-dark-plus-theme
;; naysayer-theme
(use-package modus-vivendi-theme
  :ensure t
  :diminish
  :config
  (load-theme 'modus-vivendi t))

;; Font
;; Go Mono is a really nice serif monospace font, use if available
(when (member "Go Mono" (font-family-list))
  (set-frame-font "Go Mono-14" nil t))

;; turn off UI stuff
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)

;; disable startup splash & message buffers
(setq inhibit-splash-screen t
      inhibit-startup-echo-area-message t)

;; turn off annoyances
(setq ring-bell-function 'ignore) ;; turn off all bells
;;(setq visible-bell nil)         ;; toggle between audio/video bells
(setq make-backup-files nil)
(setq auto-save-default nil)
(fset 'yes-or-no-p 'y-or-n-p)     ;; simplify Yes/No Prompts

(transient-mark-mode 1)
(global-display-line-numbers-mode)
(show-paren-mode 1)

;; show extra information on modeline
(setq-default column-number-mode t)
(display-time)

;; show all possible keyboard shortcuts
(use-package which-key
  :ensure t
  :diminish
  :config
  (which-key-mode))

;; keybindings
(global-set-key (kbd "M-n") #'forward-paragraph)
(global-set-key (kbd "M-p") #'backward-paragraph)

;; Crux, a Collection of Ridiculously Useful eXtensions for Emacs.
(use-package crux
  :ensure t
  :bind
  (("C-a" . crux-move-beginning-of-line)  ;; goes to beginning of line of first char, then column 0 if used again
   ("C-k" . crux-smart-kill-line)         ;; kills up to end of line, then kills whole line if used again
   ("C-c i" . crux-find-user-init-file))) ;; opens new buffer to init.el file

;; completion matching
(use-package icomplete-vertical
  :ensure
  :diminish
  :demand
  :custom
  (completion-styles '(partial-completion substring))
  (completion-category-overrides '((file (styles basic substring))))
  (read-file-name-completion-ignore-case t)
  (read-buffer-completion-ignore-case t)
  (completion-ignore-case t)
  :config
  (icomplete-mode)
  (icomplete-vertical-mode)
  (fido-mode 1)
  :bind (:map icomplete-minibuffer-map
              ("<down>" . icomplete-forward-completions)
              ("C-n" . icomplete-forward-completions)
              ("<up>" . icomplete-backward-completions)
              ("C-p" . icomplete-backward-completions)
              ("C-v" . icomplete-vertical-toggle)))

(use-package company
  :ensure
  :diminish
  :custom
  (setq company-idle-delay 0)
  (setq company-minimum-prefix-length 1)
  )

;; compilation
(setq compilation-scroll-output 'first-error)

;; c/c++ stuff
(setq c-default-style "k&r")
(setq-default c-basic-offset 4)

;; d stuff
(use-package d-mode
  :ensure)

;; go stuff
(use-package go-mode
  :ensure)

;; Go - lsp-mode
;; Set up before-save hooks to format buffer and add/delete imports.
(defun lsp-go-install-save-hooks ()
  (add-hook 'before-save-hook #'lsp-format-buffer t t)
  (add-hook 'before-save-hook #'lsp-organize-imports t t))

;; rust stuff
(use-package rustic
  :ensure
  :bind (:map rustic-mode-map
              ("M-j" . lsp-ui-imenu)
              ("M-?" . lsp-find-references)
              ("C-c C-c l" . flycheck-list-errors)
              ("C-c C-c a" . lsp-execute-code-action)
              ("C-c C-c r" . lsp-rename)
              ("C-c C-c q" . lsp-workspace-restart)
              ("C-c C-c Q" . lsp-workspace-shutdown)
              ("C-c C-c s" . lsp-rust-analyzer-status))
  :config
  ;; uncomment for less flashiness
  (setq lsp-eldoc-hook nil)
  ;; (setq lsp-enable-symbol-highlighting nil)
  ;; (setq lsp-signature-auto-activate nil)

  ;; comment to disable rustfmt on save
  (setq rustic-format-on-save t)
  (add-hook 'rustic-mode-hook 'rk/rustic-mode-hook))

(defun rk/rustic-mode-hook ()
  ;; so that run C-c C-c C-r works without having to confirm
  (setq-local buffer-save-without-query t))

;; sml
(use-package sml-mode
  :ensure)

;; zig
(use-package zig-mode
  :defer t
  :mode ("\\.zig\\'" . zig-mode))

;; lsp stuff
(use-package lsp-mode
  :ensure
  :commands lsp
  :custom
  ;; what to use when checking on-save. "check" is default, I prefer clippy
  (lsp-rust-analyzer-cargo-watch-command "clippy")
  (lsp-eldoc-render-all t)
  (lsp-idle-delay 0.6)
  (lsp-rust-analyzer-server-display-inlay-hints t)
  :config
  (add-hook 'lsp-mode-hook 'lsp-ui-mode)

  ;; go setup
  (add-hook 'go-mode-hook #'lsp-deferred)
  (add-hook 'go-mode-hook #'lsp-go-install-save-hooks)
  )

(use-package lsp-ui
  :ensure
  :diminish
  :commands lsp-ui-mode
  :custom
  (lsp-ui-peek-always-show t)
  (lsp-ui-sideline-show-hover t)
  (lsp-ui-doc-enable nil))

;; code completion
(use-package company
  :ensure
  :diminish
  :custom
  (company-idle-delay 0.5) ;; how long to wait until popup
  ;; (company-begin-commands nil) ;; uncomment to disable popup
  :bind
  (:map company-active-map
	      ("C-n". company-select-next)
	      ("C-p". company-select-previous)
	      ("M-<". company-select-first)
	      ("M->". company-select-last)))

;; macOS stuff
(when (string-equal system-type 'darwin)
  (progn
    ;; sets option key to 'alt, command key to 'meta
    (setq mac-option-modifier 'alt
	  mac-right-option-modifier 'alt
	  mac-command-modifier 'meta)
    ;; sets fn-delete to be right-delete
    (global-set-key [kp-delete] 'delete-char))) 

;; Windows stuff
(cond ((string-equal system-type "windows-nt")
       (progn
	(when (member "Consolas" (font-family-list))
	  (set-frame-font "Consolas-12" nil t))
	(setenv "HOME" "c:/Users/Allan Hoang")
	(setq default-directory "~/")
	(setq delete-by-moving-to-trash t))))
